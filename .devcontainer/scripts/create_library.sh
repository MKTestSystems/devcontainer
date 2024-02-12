if [[ $1 == "" ]]; then
    read -p "Enter library name" LIB
else
    LIB=$1
fi 

echo "creating library \"$LIB\""

mkdir $LIB
cd $LIB

######## create inc directory & header file ########
mkdir inc
GUARD="_${LIB^^}_H"
printf "\
#ifndef $GUARD
#define $GUARD

#endif //($GUARD)" >> inc/$LIB.h

######## create src directory, cmake & source files ########
mkdir src
printf "#include \"$LIB.h\"" >> src/$LIB.c

printf "\
target_sources($LIB PUBLIC
    $LIB.c
)" >> src/CMakeLists.txt

######## create test directory, cmake & test source files ########
mkdir test
printf "\
#include \"$LIB.h\"
#include \"unity.h\"

void setUp(void)
{
}

void tearDown(void)
{
}

void test_one(void)
{
    TEST_ASSERT_EQUAL(1, 1);
}

int main(void)
{
    UNITY_BEGIN();

    RUN_TEST(test_one);

    return UNITY_END();
} ">> test/test_$LIB.c

printf "\
add_executable(${LIB}_test_app
    test_$LIB.c
)

target_link_libraries(${LIB}_test_app
    Unity
    $LIB
)

add_test($LIB ${LIB}_test_app)" >> test/CMakeLists.txt

######## create top level cmake file ########
printf "\
add_library($LIB STATIC)

target_include_directories($LIB PUBLIC
    \${CMAKE_CURRENT_LIST_DIR}/inc
)

add_subdirectory(src)

if(\${CMAKE_BUILD_TYPE} STREQUAL Test)
    add_subdirectory(test)
else()
    target_link_libraries(\${PROJECT_NAME} PUBLIC 
        $LIB
    )
endif()" >> CMakeLists.txt
   






