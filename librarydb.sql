-- library DB 실행
USE librarydb;

-- 테이블 삭제
DROP TABLE IF EXISTS lb_reviews CASCADE;
DROP TABLE IF EXISTS lb_book CASCADE;
DROP TABLE IF EXISTS lb_rental CASCADE;
DROP TABLE IF EXISTS lb_member CASCADE;


CREATE TABLE IF NOT EXISTS lb_book (
book_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID',
book_title VARCHAR(100) NOT NULL COMMENT '제목',
book_author VARCHAR(30) COMMENT '작가',
book_pulisher VARCHAR(30) COMMENT '출판사',
book_publish_date TIMESTAMP COMMENT '출판일',
book_ISBN CHAR(5) COMMENT 'ISBN',
book_genre VARCHAR(30) COMMENT '장르',
book_borrow_status CHAR(1) NOT NULL COMMENT '대여 가능 상태; y/n'
)ENGINE=INNODB COMMENT '책 정보';


CREATE TABLE IF NOT EXISTS lb_member(
mb_id int AUTO_INCREMENT COMMENT '회원ID' ,
mb_name VARCHAR(100) NOT NULL COMMENT '회원PRIMARY KEY이름',
mb_email VARCHAR(100) NOT NULL COMMENT'회원이메일',
mb_phone VARCHAR(100) NOT NULL COMMENT '연락처',
PRIMARY KEY (mb_id)
)ENGINE=InnoDB comment '회원정보'; 


CREATE TABLE IF NOT EXISTS lb_reviews (
review_id INT AUTO_INCREMENT PRIMARY KEY COMMENT '리뷰ID',
mb_id INT NOT NULL COMMENT '회원ID', -- Changed to INT to match lb_member table
book_id INT NOT NULL COMMENT '책ID',
content TEXT NOT NULL COMMENT '내용',
rating INT UNSIGNED NOT NULL CHECK (rating >= 0 AND rating <= 5) COMMENT '평점',
created_date DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '작성일',
FOREIGN KEY (mb_id) REFERENCES lb_member(mb_id),
FOREIGN KEY (book_id) REFERENCES lb_book(book_id)
) ENGINE=INNODB COMMENT '리뷰관리';


CREATE TABLE IF NOT EXISTS lb_rental(
rental_id   INT AUTO_INCREMENT COMMENT'대여ID' ,
mb_id       INT NOT NULL COMMENT'회원ID',
book_id     INT NOT NULL COMMENT'책ID',
rental_date  DATE NOT NULL COMMENT'대여일',
rental_return DATE NOT NULL COMMENT'반납일',
book_borrow_status CHAR(1) NOT NULL COMMENT '대여가능상태; y/n',
PRIMARY KEY (rental_id),
FOREIGN KEY (mb_id) REFERENCES lb_member(mb_id),
FOREIGN KEY (book_id) REFERENCES lb_book(book_id)
) ENGINE=INNODB COMMENT '대여정보';


COMMIT;