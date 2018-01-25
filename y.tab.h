/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    WHILE = 258,
    IF = 259,
    THEN = 260,
    ELSE = 261,
    READ = 262,
    LET = 263,
    NEXT = 264,
    TYPE = 265,
    PRINT = 266,
    NUMBER = 267,
    ID = 268,
    EXPR_ARIT = 269,
    EXPR_REL = 270,
    ATTR = 271,
    DIM = 272,
    AS = 273,
    SUB = 274,
    STRING = 275,
    BREAK = 276,
    OPLOG = 277,
    OPREL = 278,
    DECL = 279,
    RETURN = 280,
    NEW = 281,
    FLOATING = 282,
    INTEGER = 283,
    FLOAT = 284,
    ARRAY = 285,
    MODULE = 286,
    MAIS = 287,
    MENUS = 288,
    MULT = 289,
    DIV = 290,
    MOD = 291,
    AND = 292,
    OR = 293,
    NOT = 294,
    LT = 295,
    GT = 296,
    GE = 297,
    LE = 298,
    NE = 299
  };
#endif
/* Tokens.  */
#define WHILE 258
#define IF 259
#define THEN 260
#define ELSE 261
#define READ 262
#define LET 263
#define NEXT 264
#define TYPE 265
#define PRINT 266
#define NUMBER 267
#define ID 268
#define EXPR_ARIT 269
#define EXPR_REL 270
#define ATTR 271
#define DIM 272
#define AS 273
#define SUB 274
#define STRING 275
#define BREAK 276
#define OPLOG 277
#define OPREL 278
#define DECL 279
#define RETURN 280
#define NEW 281
#define FLOATING 282
#define INTEGER 283
#define FLOAT 284
#define ARRAY 285
#define MODULE 286
#define MAIS 287
#define MENUS 288
#define MULT 289
#define DIV 290
#define MOD 291
#define AND 292
#define OR 293
#define NOT 294
#define LT 295
#define GT 296
#define GE 297
#define LE 298
#define NE 299

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
