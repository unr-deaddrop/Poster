cmake_minimum_required(VERSION 3.18)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_BUILD_TYPE Debug)
project(POSTER_T08)



# Document
find_file(FINDLATEXMK FindLatexmk.cmake)
include(${FINDLATEXMK})
set(LATEX_SRC_FILES 
	${PROJECT_SOURCE_DIR}/POSTER_T08.tex
)
add_latex_document(${LATEX_SRC_FILES} ALL ENGINE LUALATEX)
