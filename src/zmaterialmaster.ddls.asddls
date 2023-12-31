@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material MAster'
define root view entity zmaterialmaster as select from I_Product as p
left outer join I_ProductDescription as d on p.Product = d.Product and d.Language = 'E' 
//composition of target_data_source_name as _association_name
{
    key p.Product,
    
//    ProductExternalID,
//    ProductOID,
    p.ProductType,
    d.ProductDescription,
//    CreationDate,
//    CreationTime,
//    CreationDateTime,
//    CreatedByUser,
//    LastChangeDate,
//    LastChangedByUser,
//    IsMarkedForDeletion,
//    CrossPlantStatus,
//    CrossPlantStatusValidityDate,
//    ProductOldID,
//    GrossWeight,
//    PurchaseOrderQuantityUnit,
//    SourceOfSupply,
//    WeightUnit,
//    CountryOfOrigin,
//    CompetitorID,
//    ProductGroup,
    p.BaseUnit
//    ItemCategoryGroup,
//    NetWeight,
//    ProductHierarchy,
//    Division,
//    VarblPurOrdUnitIsActive,
//    VolumeUnit,
//    MaterialVolume,
//    SalesStatus,
//    TransportationGroup,
//    SalesStatusValidityDate,
//    AuthorizationGroup,
//    ANPCode,
//    ProductCategory,
//    Brand,
//    ProcurementRule,
//    ValidityStartDate,
//    LowLevelCode,
//    ProdNoInGenProdInPrepackProd,
//    SerialIdentifierAssgmtProfile,
//    SizeOrDimensionText,
//    IndustryStandardName,
//    ProductStandardID,
//    InternationalArticleNumberCat,
//    ProductIsConfigurable,
//    IsBatchManagementRequired,
//    HasEmptiesBOM,
//    ExternalProductGroup,
//    CrossPlantConfigurableProduct,
//    SerialNoExplicitnessLevel,
//    ProductManufacturerNumber,
//    ManufacturerNumber,
//    ManufacturerPartProfile,
//    QltyMgmtInProcmtIsActive,
//    IsApprovedBatchRecordReqd,
//    HandlingIndicator,
//    WarehouseProductGroup,
//    WarehouseStorageCondition,
//    StandardHandlingUnitType,
//    SerialNumberProfile,
//    AdjustmentProfile,
//    PreferredUnitOfMeasure,
//    IsPilferable,
//    IsRelevantForHzdsSubstances,
//    QuarantinePeriod,
//    TimeUnitForQuarantinePeriod,
//    QualityInspectionGroup,
//    HandlingUnitType,
//    HasVariableTareWeight,
//    MaximumPackagingLength,
//    MaximumPackagingWidth,
//    MaximumPackagingHeight,
//    MaximumCapacity,
//    OvercapacityTolerance,
//    UnitForMaxPackagingDimensions,
//    BaseUnitSpecificProductLength,
//    BaseUnitSpecificProductWidth,
//    BaseUnitSpecificProductHeight,
//    ProductMeasurementUnit,
//    ProductValidStartDate,
//    ArticleCategory,
//    ContentUnit,
//    NetContent,
//    ComparisonPriceQuantity,
//    GrossContent,
//    ProductValidEndDate,
//    AssortmentListType,
//    HasTextilePartsWthAnimalOrigin,
//    ProductSeasonUsageCategory,
//    IndustrySector,
//    ChangeNumber,
//    MaterialRevisionLevel,
//    IsActiveEntity,
//    LastChangeDateTime,
//    LastChangeTime,
//    DangerousGoodsIndProfile,
//    ProductUUID,
//    ProdSupChnMgmtUUID22,
//    ProductDocumentChangeNumber,
//    ProductDocumentPageCount,
//    ProductDocumentPageNumber,
//    OwnInventoryManagedProduct,
//    DocumentIsCreatedByCAD,
//    ProductionOrInspectionMemoTxt,
//    ProductionMemoPageFormat,
//    GlobalTradeItemNumberVariant,
//    ProductIsHighlyViscous,
//    TransportIsInBulk,
//    ProdAllocDetnProcedure,
//    ProdEffctyParamValsAreAssigned,
//    ProdIsEnvironmentallyRelevant,
//    LaboratoryOrDesignOffice,
//    PackagingMaterialGroup,
//    ProductIsLocked,
//    DiscountInKindEligibility,
//    SmartFormName,
//    PackingReferenceProduct,
//    BasicMaterial,
//    ProductDocumentNumber,
//    ProductDocumentVersion,
//    ProductDocumentType,
//    ProductDocumentPageFormat,
//    ProductConfiguration,
//    SegmentationStrategy,
//    SegmentationIsRelevant,
//    ProductCompositionIsRelevant,
//    IsChemicalComplianceRelevant,
//    ManufacturerBookPartNumber,
//    LogisticalProductCategory,
//    SalesProduct,
//    ProdCharc1InternalNumber,
//    ProdCharc2InternalNumber,
//    ProdCharc3InternalNumber,
//    ProductCharacteristic1,
//    ProductCharacteristic2,
//    ProductCharacteristic3,
//    MaintenanceStatus,
//    FashionProdInformationField1,
//    FashionProdInformationField2,
//    FashionProdInformationField3,
//    /* Associations */
//    _AdjustmentProfile,
//    _AdjustmentProfileText,
//    _AdjustmentProfileText_2,
//    _AdjustmentProfile_2,
//    _AssortmentListType,
//    _AssortmentListTypeText,
//    _BaseUnitOfMeasure,
//    _BaseUnitOfMeasureText,
//    _BasicMaterial,
//    _Brand,
//    _BrandText,
//    _BR_ANPCode,
//    _BR_ANPCodeText,
//    _ChemicalComplianceRelevant,
//    _ChemicalComplianceRlvtText,
//    _ContentUnit,
//    _ContentUnitText,
//    _CreatedByUser,
//    _CreatedByUserContactCard,
//    _CrossPlantConfigurableProduct,
//    _Division,
//    _DivisionText,
//    _ESHCharValueAssignment,
//    _ESHClassAssignment,
//    _ESHDocInfoRecordObjectLink,
//    _ESHProductPlant,
//    _ESHProductSalesDelivery,
//    _ESHPurOrderQuantityUnitText,
//    _ESHSourceOfSupply,
//    _ESHSupplier,
//    _ESHTextObjectPlainLongText,
//    _ExternalProductGroup,
//    _ExtProdGrpText,
//    _FashionProdInfoFld1,
//    _FashionProdInfoFld1Text,
//    _FashionProdInfoFld2,
//    _FashionProdInfoFld2Text,
//    _FashionProdInfoFld3,
//    _FashionProdInfoFld3Text,
//    _HandlingIndicator,
//    _HandlingIndicatorText,
//    _HandlingUnitType,
//    _HandlingUnitTypeText,
//    _IntArticleNumberText,
//    _InternationalArticleNumberCat,
//    _ItemCategoryGroup,
//    _ItemCategoryGroupText,
//    _LastChangedByUser,
//    _LastChangedByUserContactCard,
//    _MaterialRevisionLevel,
//    _MaterialText,
//    _MDProductHierarchyNode,
//    _ProductCategory,
//    _ProductCategoryText,
//    _ProductDescription_2,
//    _ProductESPP,
//    _ProductGroup,
//    _ProductGroupText,
//    _ProductGroupText_2,
//    _ProductGroup_2,
//    _ProductHierarchy,
//    _ProductHierarchyText,
//    _ProductMeasurementUnit,
//    _ProductMeasurementUnitText,
//    _ProductProcurement,
//    _ProductRetail,
//    _ProductSales,
//    _ProductSCM,
//    _ProductStatus,
//    _ProductStatusText,
//    _ProductType,
//    _ProductTypeName,
//    _ProductType_2,
//    _ProdUnivHierarchyNode,
//    _QualityInspectionGroup,
//    _QualityInspectionGroupText,
//    _QuantityUnitText,
//    _QuantityUnitValueHelp,
//    _RetProdCharc1,
//    _RetProdCharc1Text,
//    _RetProdCharc2,
//    _RetProdCharc2Text,
//    _RetProdCharc3,
//    _RetProdCharc3Text,
//    _SerialNumberProfile,
//    _SerialNumberProfileText,
//    _StandardHandlingUnitType,
//    _StandardHandlingUnitTypeText,
//    _Text,
//    _TimeUnitForQuarantinePeriod,
//    _TimeUnitQuarantinePeriodText,
//    _UnitForMaxPackaging,
//    _UnitForMaxPackagingText,
//    _WarehouseProductGroup,
//    _WarehouseProductGroupText,
//    _WarehouseStorageCondition,
//    _WarehouseStorageConditionText,
//    _WeightUnitText,
//    _WeightUnitValueHelp,
//    _association_name // Make association public
}
