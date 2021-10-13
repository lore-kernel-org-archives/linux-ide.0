Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCF7C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 13 Oct 2021 03:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F03D860F92
	for <linux-ide@archiver.kernel.org>; Wed, 13 Oct 2021 03:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhJMDVi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Oct 2021 23:21:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26766 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhJMDVh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 12 Oct 2021 23:21:37 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D38EeC028773;
        Wed, 13 Oct 2021 03:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=VBiH6OC+wQBecbwUiRjy81yIy7V6rvpund3tv/UCbzk=;
 b=Jw5JEsc5PqgLSdHgNiniyK5dsMc0jirgpWyX4c+eMfj9i66hUlHNotQcjR5dP+w/WUxl
 /4dKAoGYTJIWid/rg4c7+Y6jtxunompGlL6LI+9nya5G9ovzZm60E8xCpfx9dp7JtRo/
 ZNE8zbK9cTlIe8KBywdp5cQwNs9ekenSmJ7YPFWoqpFpUiGPjOockFmCjOJJXKmXvJuN
 PbAE7gpAsbsFLJWqRTL7p//w5xo3zoIC1a9FLo+u2xhNHqAiJ2B7fhHW/PUmZh+WinRy
 N2r5FzNEcP/Q5N9ULXfulZs2hH6Axg9oaI7/USaDJW/Dk2yuAcNNzG5AHCgF1pGzCH7v 4Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbh0xpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 03:19:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19D3D8eP095958;
        Wed, 13 Oct 2021 03:19:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by userp3030.oracle.com with ESMTP id 3bkyva1gqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 03:19:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXR9vJdi1tJLeXpuewUHyvvufAfPZILr2GyUjp0x7jQ+ILIGBZUDdVp/AXIOVu5GT4rxbdqGSFADNQQHKWISJoHncBDD03qXLcz8n0viy1gNT09+GnqH9rXrgR+nH7U7sB9FEKXOur8VZHifSnklaZ0OEmGy1NQZDEc9l2Ah0jolgxvtjPnb9uOYNPgg2E0p5SRGdQdlppuCVTsPxchTBGe2IM0JjScMHdJPCt9q7wxf4oNMFQGba7CMDWH5leUY6ZtlCgaOdmOxEgD0rvrv8CZFNx7Y9lcL2f0rz7TGF4Xh58PdnmygvyyxnewEEqug0WiL+6HEjfYXD6t9cEuaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBiH6OC+wQBecbwUiRjy81yIy7V6rvpund3tv/UCbzk=;
 b=jwfrGZ2scAPgZLy7T2Dz3PEYS3/l4nz4zzLmLzEco4FpECZ9OM94ziErbFQ3XYTCmi976ktkMHdFXa3nN2YPl9+aeWnetnnss2TPAi8CaBjAgr6uHGjuJmF4kdL1G+4bxIw81VXzHrA2fbZLkpMPFmG0q0GMDHOLTf36fQooOPErwqqkzxKX+p8BjQKv2BHtsf1aaqDx8ETuxEhqmIZIaR9ETgIroR45wl0SYiHNjexSHVkWf1EwBLHn1d3Ub8hE6Meox8uOAjys4e+tH88ZB3jbdIyDAH+94dUnGdB+MVtKbTvF3K4UdtvSUZUryjhKuDabcoKG9gVW8Zi5iukRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBiH6OC+wQBecbwUiRjy81yIy7V6rvpund3tv/UCbzk=;
 b=lruofEiWX8BylRIL7ErvIoHq2J28blUKmP/oaBBTqolsso93qdu4xiSa0pRsomqhk9GHNZ5gTfIRNdNnyNc+J9VnzQJjg33Ln6MPjVE3FyksRqD086m9Wm4J0HYIheLS2/OkVzbZ46tobw16riGtKtodSBva41QNSEyS+369Wyo=
Authentication-Results: technikum-wien.at; dkim=none (message not signed)
 header.d=none;technikum-wien.at; dmarc=none action=none
 header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4550.namprd10.prod.outlook.com (2603:10b6:510:34::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Wed, 13 Oct
 2021 03:19:21 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%9]) with mapi id 15.20.4608.015; Wed, 13 Oct 2021
 03:19:21 +0000
To:     Stefan Tauner <tauner@technikum-wien.at>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-ide@vger.kernel.org
Subject: Re: Questions (and a possible bug) regarding the
 ata_device_blacklist and ATA_HORKAGE_ZERO_AFTER_TRIM
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15yu1pr9h.fsf@ca-mkp.ca.oracle.com>
References: <20190926150400.2524a63b@legacy> <yq1pnjm1zvk.fsf@oracle.com>
        <20210915183518.0947de73@legacy>
Date:   Tue, 12 Oct 2021 23:19:18 -0400
In-Reply-To: <20210915183518.0947de73@legacy> (Stefan Tauner's message of
        "Wed, 15 Sep 2021 18:35:18 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:806:f2::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.12) by SN7PR04CA0008.namprd04.prod.outlook.com (2603:10b6:806:f2::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Wed, 13 Oct 2021 03:19:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5db3064-066d-43dd-65be-08d98df83fc8
X-MS-TrafficTypeDiagnostic: PH0PR10MB4550:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4550763436F20907533EAB318EB79@PH0PR10MB4550.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YmLvGCW+wK0voO0n4F89IaH4fGKaKSs0ePc5WRSu+8dTya1towJtH+IdJTADHQ7pe3dDCB7qk+SMdpSQ0glE0y4NM6BNVLWs+sTEABL5VRposNGmyzoZNpbElQuTDTPVDHoMMtplNnxoDyVTpJ97ccAHD6vlSrStaktGEz04QmttrLaFzexVFj7ADk9cS4x8IKqUT862c8oxPjJzV/9rRJt21Lfgmr+7V+gnYGKmJ7eJqiTA5+cHXQYHCd22krE/VO+7lddLg+dWbdllyC1vO8f0fjyDlBcMqpSfWl1bI/olM7uidThBpRlBuLnW6ZiyqFDmnU3+HivQc4x+C5ThMA0MUzMLhJ12RwXq2KbbzNAJCYTNKGuZaclFMOYhod9d48ZH9VXmtg+6GGf4pLKw2e97CNXGdTcCuGRBQJyNniK29blXzHn1oTDAm9sZ5RUuu+IKL1Dq3XReOGePJ564Vg2Ct63sATfUatZcxkXKAfrDt8sngFNZbbCU99TtpufXO8w3lz2HxRzmGeaa7x+11pdjk3yLco4b+IMSunvg3d24OWQkOoM4sP/2SPOQMCIcJTw/vFgRPtidAOclA+9P3lcC9wYDV/3bLPRc9ymCt7Y7riMKCneOvz6OKQ+Jz4NVMk/y6MIsnmq/IY7RB7t1F5rxkOVQgIm1H9DgDWxdOpjo+xuCzfoBIzg48ASCIVxauUcmPoV6KlVtFfNNIfwgAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(956004)(66476007)(8676002)(4326008)(186003)(26005)(66946007)(8936002)(5660300002)(36916002)(2906002)(66556008)(4744005)(55016002)(83380400001)(38350700002)(38100700002)(86362001)(6916009)(508600001)(52116002)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EC32PLrK+mZ1purw27giNN/GfCoggdVNhJrXEvw5Ar18dPKVttPmV2QJP+SJ?=
 =?us-ascii?Q?nRJ+ppP02AV35fYspsWUPxL2juDkUi/buaFB20kLIw/XZImGKm/OEruTCt73?=
 =?us-ascii?Q?UoMi83wY0TtH9PLY3hL07z9pTpelDAKChE/GJLTk3g6I6JQVZMKL0ct6Fy5A?=
 =?us-ascii?Q?tgih586HSdQszLl+zveF7CZpXFwDNzHAkNlczlatiL0Z5t6AEfXGPBazbKiF?=
 =?us-ascii?Q?A/U3maOJH7QFNYyrbRgGK1EWlOT+bqS2bGTgR0Pk/7FpxkJDeJEpo0XhD6QH?=
 =?us-ascii?Q?CFzReCrrZ8eLaZP5r2njDJIIQlYSDJtg7kV9FYw21d7uRIwCRcQJ8xG8nVof?=
 =?us-ascii?Q?MgWhon9zXrEOQyy4rpJVkzShSOWQb/30f2PJGsJ0SRVMu8+SNExhwWTbDUDD?=
 =?us-ascii?Q?1dIh4eqas1J54v6Nkl0xsoweIyT5RfifZxbdeul3XT+ghgCs13AvQSVHvkN7?=
 =?us-ascii?Q?FH5IPIWlxSMUR2sWKP1bGH8kUyB2b8wK6IjoG3LFSQek4my935p9PZlnMeHL?=
 =?us-ascii?Q?DTqWbzRsXRTRLbO5dCWdX6TiunZA7i0nwI1+6qE4ne+VMu2mZ/NgpYLlGVVC?=
 =?us-ascii?Q?ark9tklg5g4w0087+EMnpWDsxuKajurESvO+wpW5NK2zFtNNDCL4/prxaw3d?=
 =?us-ascii?Q?3phfDl0A/nC1I3lXpFpU6VnZmsAhtKwdj9+agGeDIUjIOy49LEE7JzUlrePr?=
 =?us-ascii?Q?fivHL08LuvKEPzYKvq579osB1hH4Sl4EEHutUKPu8b967bWPiFH8rAxiDf8s?=
 =?us-ascii?Q?NKtDwaNoUj80uxuaJugPXN8R+19Q+inOJ+haw6L9TI85sWa26I+ZcuTPlF7U?=
 =?us-ascii?Q?a807yQFUOeZ7EIEshKYItthcoz0c4pbSRw96D6PZYgP5y2Ep/hXZcs2sc8sZ?=
 =?us-ascii?Q?uMYL0YL/DMnA7VYnmizeV2Y0j341UPfmCn1l0eXFcoCVhQUOzXCTQqHpxlU3?=
 =?us-ascii?Q?2+ADBoNJ4/sDkshwxxWgh4/izFgL9uawgVe3Jxlt6eQb33CXMb45pcJM4DAE?=
 =?us-ascii?Q?QmUn1icpiqULqveMy5r43ETCFljA5MxUu3WAtZAH1wl6z394J4Iznj361YWi?=
 =?us-ascii?Q?pIRTL730fEjf4ZoOEY1Fs4+WeLfRc3gl96sjTKUNR3elN5DPbl2KLEy4VsR5?=
 =?us-ascii?Q?82t3+zPuAWIqO96Y5eXBRrzFOZjToc7iyLdgJB8jXxrq4HfXCpqQcJ+J2zbS?=
 =?us-ascii?Q?Eax6u6ccApquGs2cMb5x0HPG9piEs453yYfots5pyIL+SOe71VppULn9fMpg?=
 =?us-ascii?Q?JEAXBVt8telbKPAUOvZjqfMWBLCji7pnR0aSyY44ncZn9Yd4W7F8ErcmJT19?=
 =?us-ascii?Q?xsftvkhBlTeHCAAxvLbAH/Rw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5db3064-066d-43dd-65be-08d98df83fc8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 03:19:21.2632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kTr+tHCrPg+3gMl/yWcdYx7qDUeqqi2RgESUjtijdUw5cIxrOaUwlRUHiX3claocLsHHCZjjIx1TGQSqIYo0+WBh2RmMA0p4eQBprLOQZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4550
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10135 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130018
X-Proofpoint-GUID: pucbToQ46HlgkcOkzIws7mYLE67aTfGX
X-Proofpoint-ORIG-GUID: pucbToQ46HlgkcOkzIws7mYLE67aTfGX
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Stefan,

> This is still the case (with Linux 5.10). I would have expected that
> to be non-zero for devices with ATA_HORKAGE_ZERO_AFTER_TRIM.

The short answer is that we have split things into two distinct
operations: Deallocating a block range and zeroing a block range. And as
a result, upper layers no longer have to know whether a discard is
deterministic or not. That is all handled at the bottom of the stack
where the requested operation is translated into something suitable for
the device in question.

Because of the semantic distinction between deallocating and zeroing a
block range, discard_zeroes_data always reports 0 on modern kernels.
This is done to make applications pick the zeroing operation over
discard when they want to clear a block range.

-- 
Martin K. Petersen	Oracle Linux Engineering
