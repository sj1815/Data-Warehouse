-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema finance_and_analysis
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema finance_and_analysis
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `finance_and_analysis` DEFAULT CHARACTER SET utf8 ;
USE `finance_and_analysis` ;

-- -----------------------------------------------------
-- Table `finance_and_analysis`.`customer_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finance_and_analysis`.`customer_dim` (
  `customer_sk` INT(11) NOT NULL,
  `customerID` INT(11) NULL DEFAULT NULL,
  `customerName` VARCHAR(50) NULL DEFAULT NULL,
  `customerTypeID` CHAR(1) NULL DEFAULT NULL,
  `typeName` VARCHAR(50) NULL DEFAULT NULL,
  `customerAddress1` VARCHAR(50) NULL DEFAULT NULL,
  `customerAddress2` VARCHAR(50) NULL DEFAULT NULL,
  `customerCity` VARCHAR(50) NULL DEFAULT NULL,
  `customerState` CHAR(2) NULL DEFAULT NULL,
  `customerZip` CHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`customer_sk`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `finance_and_analysis`.`date_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finance_and_analysis`.`date_dim` (
  `date_sk` INT(11) NULL,
  `calenderDate` DATE NULL DEFAULT NULL,
  `calenderYear` INT(11) NULL DEFAULT NULL,
  `calenderQuarter` INT(11) NULL DEFAULT NULL,
  `calenderMonth` INT(11) NULL DEFAULT NULL,
  `calenderWeek` INT(11) NULL DEFAULT NULL,
  `calenderDay` INT(11) NULL DEFAULT NULL,
  `fiscalYear` INT(11) NULL DEFAULT NULL,
  `fiscalQuarter` INT(11) NULL DEFAULT NULL,
  `fiscalMonth` INT(11) NULL DEFAULT NULL,
  `fiscalWeek` INT(11) NULL DEFAULT NULL,
  `fiscalDay` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`date_sk`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `finance_and_analysis`.`junk_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finance_and_analysis`.`junk_dim` (
  `junk_sk` INT(11) NULL,
  `shippingType` VARCHAR(45) NULL DEFAULT NULL,
  `orderType` VARCHAR(45) NULL DEFAULT NULL,
  `paymentMethod` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`junk_sk`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `finance_and_analysis`.`product_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finance_and_analysis`.`product_dim` (
  `product_sk` INT(11) NULL,
  `prodID` INT(11) NULL DEFAULT NULL,
  `prodDescription` VARCHAR(50) NULL DEFAULT NULL,
  `price1` DECIMAL(10,2) NULL DEFAULT NULL,
  `price2` DECIMAL(10,2) NULL DEFAULT NULL,
  `unitCost` DECIMAL(10,2) NULL DEFAULT NULL,
  `productTypeID` INT(11) NULL DEFAULT NULL,
  `BuID` VARCHAR(5) NULL,
  `BuName` VARCHAR(45) NULL,
  `BuAbbrev` VARCHAR(15) NULL,
  PRIMARY KEY (`product_sk`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `finance_and_analysis`.`supplier_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finance_and_analysis`.`supplier_dim` (
  `supplier_sk` INT(11) NOT NULL,
  `supplierID` INT(11) NULL DEFAULT NULL,
  `supplierName` VARCHAR(50) NULL DEFAULT NULL,
  `supplierAddress1` VARCHAR(50) NULL DEFAULT NULL,
  `supplierAddress2` VARCHAR(50) NULL DEFAULT NULL,
  `supplierCity` VARCHAR(20) NULL DEFAULT NULL,
  `supplierState` CHAR(2) NULL DEFAULT NULL,
  `supplierZip` CHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`supplier_sk`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `finance_and_analysis`.`sales_finance_fact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finance_and_analysis`.`sales_finance_fact` (
  `customer_SK` INT(11) NOT NULL,
  `product_SK` INT(11) NOT NULL,
  `supplier_SK` INT(11) NOT NULL,
  `salesDate_SK` INT(11) NOT NULL,
  `orderDate_SK` INT(11) NOT NULL,
  `junk_SK` INT(11) NOT NULL,
  `invoiceNo_DD` VARCHAR(10) NOT NULL,
  `source` VARCHAR(10) NOT NULL,
  `salesAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `salesQuantity` INT(11) NULL DEFAULT NULL,
  `processingDays` INT(11) NULL DEFAULT NULL,
  `totalCost` DECIMAL(10,2) NULL,
  `shippingCost` DECIMAL(10,2) NULL,
  PRIMARY KEY (`customer_SK`, `product_SK`, `source`, `invoiceNo_DD`, `junk_SK`, `orderDate_SK`, `salesDate_SK`, `supplier_SK`),
  INDEX `fk_sales_finance_fact_product_dim1_idx` (`product_SK` ASC),
  INDEX `fk_sales_finance_fact_supplier_dim1_idx` (`supplier_SK` ASC),
  INDEX `fk_sales_finance_fact_date_dim1_idx` (`salesDate_SK` ASC),
  INDEX `fk_sales_finance_fact_date_dim2_idx` (`orderDate_SK` ASC),
  INDEX `fk_sales_finance_fact_junk_dim1_idx` (`junk_SK` ASC),
  CONSTRAINT `fk_sales_finance_fact_customer_dim1`
    FOREIGN KEY (`customer_SK`)
    REFERENCES `finance_and_analysis`.`customer_dim` (`customer_sk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_finance_fact_product_dim1`
    FOREIGN KEY (`product_SK`)
    REFERENCES `finance_and_analysis`.`product_dim` (`product_sk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_finance_fact_supplier_dim1`
    FOREIGN KEY (`supplier_SK`)
    REFERENCES `finance_and_analysis`.`supplier_dim` (`supplier_sk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_finance_fact_date_dim1`
    FOREIGN KEY (`salesDate_SK`)
    REFERENCES `finance_and_analysis`.`date_dim` (`date_sk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_finance_fact_date_dim2`
    FOREIGN KEY (`orderDate_SK`)
    REFERENCES `finance_and_analysis`.`date_dim` (`date_sk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_finance_fact_junk_dim1`
    FOREIGN KEY (`junk_SK`)
    REFERENCES `finance_and_analysis`.`junk_dim` (`junk_sk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `finance_and_analysis`.`shippingCompanies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finance_and_analysis`.`shippingCompanies` (
  `shippingCompany_sk` INT NULL,
  `shippingCompanyID` VARCHAR(10) NULL,
  `shippingCompanyName` VARCHAR(45) NULL,
  `shippingCompanyAddr1` VARCHAR(45) NULL,
  `shippingCompanyAddr2` VARCHAR(45) NULL,
  `shippingCompanyCity` VARCHAR(45) NULL,
  `shippingCompanyState` CHAR(2) NULL,
  PRIMARY KEY (`shippingCompany_sk`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `finance_and_analysis`.`supplier_shippingCompanies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finance_and_analysis`.`supplier_shippingCompanies` (
  `shippingCompany_sk` INT NOT NULL,
  `supplier_sk` INT NOT NULL,
  `weighingFactor` INT NULL,
  PRIMARY KEY (`shippingCompany_sk`, `supplier_sk`),
  INDEX `fk_supplier_shippingCompanies_supplier_dim1_idx` (`supplier_sk` ASC),
  CONSTRAINT `fk_supplier_shippingCompanies_supplier_dim1`
    FOREIGN KEY (`supplier_sk`)
    REFERENCES `finance_and_analysis`.`supplier_dim` (`supplier_sk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_supplier_shippingCompanies_shippingCompanies1`
    FOREIGN KEY (`shippingCompany_sk`)
    REFERENCES `finance_and_analysis`.`shippingCompanies` (`shippingCompany_sk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
