df <- read.csv("bigdata/9_Microsoft R/20190626/income.csv",
              header = TRUE, stringsAsFactors = FALSE)
str(df)

# 설치
# plyr(x)
# dplyr
options(repos = c(CRAN = 'https://cloud.r-project.org'))
install.packages('dplyr', repos = 'https://cloud.r-project.org')
library(dplyr)

df
sample_n(df,3)
sample_frac(df, 0.1)
# 모든 항목 중복 제거
df2 <- distinct(df)
df2

str(df)
select(df, Index, State:Y2008)
select(df, Index, State)
select(df, State)

# cloumn제거
select(df, -Index, -State)
select(df, -c(Index,State))

# cloumn중 Y가 포함된 것만 출력
select(df, starts_with("Y"))
select(df, -starts_with("Y"))
select(df, contains("I"))

# cloumn이름 변경
# select(df, State, everything())
df2 <- rename(df, Index2 = Index)
names(df2)

# filter
filter(df, Index == "A")
# A 포함된 데이터(컬럼 아님 주의) 추출
# %in%도 or 조건과 같음..
filter(df, Index %in% "A")
filter(df, Index %in% c("A","C"))
filter(df, Index %in% c("A","C") & Y2002 >= 1400000)
filter(df, !Index %in% c("A","C"))

# 010-1234-1234 -> [0-9][0-9][0-9] => 정규표현식
# regular expression
# Ar로 포함, 시작하는
filter(df, grepl("Ar", State))
# group by와 같은 개념
summarise(df, Y2015_mean = mean(Y2015),
          Y2015_median = median(Y2015))

# arrange - sorting
arrange(df, Index)
df3 <- select(df, Index)
arrange(df3, Index)
df4 <- arrange(df3, Index)
head(df4)
# 내림차순
df5 <- arrange(df3, desc(Index))
head(df5)
# order by두개 사용
df6 <- select(df, Index, State)
df6
df7 <- arrange(df6, desc(Index), State)
df7


# group_by
group_by(df, Index)
View(df)
head(df,5)
tail(df,5)


# Pipe Operator %>%
# magrittr
# 첫번째 인자로 자동으로 df가 들어감.
# select(data, Index, State) 이렇게 안써도 됨
df %>% select(Index, State)

df_temp = sample_n(select(df, Index, State),10)
df_temp
df %>% select(Index,State) %>% sample_n(10)


# ------------------------------------------------------

df10 <- read.csv("bigdata/9_Microsoft R/20190626/exam.csv")
str(df10)
# 전부다 intager 형으로 문제 없다.
df10
filter(df10, class == 1)
df10 %>% filter(class==1)
select(df10, math, english)

filter(select(df10, class,math, english),class == 1)
df10 %>% select(class,math, english) %>% 
  filter(class == 1) %>%
  arrange(desc(math))

df_temp <- df10 %>%
  filter(class %in% c(1,3,5)) %>%
  arrange(desc(english))
df_temp

# --------------------------------------------------------

a <- 10
if(is.integer(a)){
  print("X is an Integer")
}

a1 <- 10L
if(is.integer(a1)){
  print("X is an Integer")
}

a2 <- c("What", "is", "truth")
if("Truth" %in% a2)
# Code Complete(코드 완정정복)
# 컴퓨터 역사... 빌게이츠 생각속도

# ------------------------------------------------------

# Loop
a4 <- c("Hello", "R loop")
cnt <- 2
repeat {
  print(a4)
  cnt <- cnt + 1
  print(cnt)
  if(cnt > 5){
    break;
  }
}

a5 <- c("Hello", "R loop")
cnt <- 2 
while(cnt < 7){
  print(a5)
  cnt = cnt + 1
}

# r에서 제공하는 함수 LETTERS
a6 <- LETTERS[1:4]
a6
a7 <- letters[1:4]
a7


for(i in a6){
  print(i)
}

# ---------------------------------------------------------------

# function -> 함수, 프로시저(procedure), 메소드(method)
# input -> (black box, swap...) -> output
# 반복적인 작업을 줄이기 위해 함수를 씀.


# built-in functions
#select
#print
#filter
print(seq(1,10))

#user-defined function
myfunc <- function(a) {
  for(i in 1:a){
    b <- i*2
    print(b)
  }
}

myfunc(10)



myfunc4 <- function(a=0, b=0){
  r <- a+b
  print(r)
}
myfunc4(a=1)
myfunc4(b=2)

myfunc5 <- function(a){
  c <-a
}
myfunc5(1)

setwd("C:\\Users\\user\\Documents\\bigdata\\9_Microsoft R\\20190626")
df <- read.csv("exam.csv")

str(df)

df %>% 
  select(id, class, math) %>%
  filter(class == 1) %>%
  arrange(desc(id))

df %>%
  arrange(class, desc(id)) %>%
  head(5)

df %>%
  arrange(class, desc(id)) %>%
  mutate(total = math + english + science,
         mean = total/3)

# n() , class를 기준으로 4건씩 있으므로 count 값은 4
df %>%
  group_by(class) %>%
  summarise(mean_math = mean(math),
            median_math = median(math),
            sum_math = sum(math),
            count_math = n())

mpg <- as.data.frame(ggplot2::mpg)
mpg

str(mpg)

select(mpg, class)

mpg %>%
  group_by(class) %>%
  summarise(mean_cty = mean(cty))

# 어떤 회사의 자동차 hwy가 가장 높은 것을 
# 알아보려고 한다.hwp평균 가장 높은 회사 5곳을 출력하시오.

mpg %>%
  group_by(manufacturer) %>%
  order_by(desc mean(hwp))
