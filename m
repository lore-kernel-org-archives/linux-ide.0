Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F07EC77B75
	for <linux-ide@archiver.kernel.org>; Tue, 23 May 2023 08:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbjEWIe2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 23 May 2023 04:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjEWId3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 23 May 2023 04:33:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1435310CA
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2023 01:30:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6EpNe000613;
        Tue, 23 May 2023 08:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=92PDk+wcwidbx2Sl/ROV3Sc3Co3DZPaUJeFXlsy5pdU=;
 b=vpgfG0wwvky8ycnrN9rryOQsderH2gVKTKfuSc1st8aU6nDKJ1boBqMJeqo8nJ8jE6kT
 fKOte1l90O3C47jZJ8TvWuVZ/ZkkbmjjlLusjUVtaBEuAwwInZ0LYfpOSC2JnRXCLIe1
 WK5cyNm0Ea1Ihii3f6xBmipJKHS0buQg92+Pbui73MdCScdDDYLIXgCLLInuD4BdvHvF
 Bem8SOw0WRdgpau4al2mCp4X2HEjMofpUfA4egVG2p4NfTVGtfg6fCUXLjADtbbCMufE
 e8zInbF6I8yQ93P8+JSekoWbPLoxvmtK7rwEJPUM6Vgb/3KHbIR5Wn3we6GZTwcsjkGl yQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpprtmhge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 08:30:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6s2av028580;
        Tue, 23 May 2023 08:30:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2qrmb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 08:30:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JG0keUWZNAlYAfeIx3ufJsTPfZnPn9VoXu3zEYI6wZsuPafTucz4IiYkMXB8+YkvEP9xCble8uH8vi5q+7jV6zB+z/YT3MKvjJkilw9pmTKXHLMgh0t/WVFEEt+2TRecjZpU0/8ajLdNXcQmU3D6tCuDFclYiTSihBgXut/+6CMGaTDOI0dhtSNu03nBVwlBqpvg2+/MxEXuWOMVpnQC8hvjnQMvMgz+1lLvp5+xO44K44pmgTs9he+oYL86Hlgi+GA7a4hJErhW/0cWToFUyOTwiHYWGz+SgcX7+XnSxyMjarKNYkdFhH4aX3Tk/DUc2eH+O1axLLIMtd1fX7ZmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92PDk+wcwidbx2Sl/ROV3Sc3Co3DZPaUJeFXlsy5pdU=;
 b=SXvW16HAXnFcZEuwOYdhEoeggMYs5TxZiQddEH3iaATujIUZQwRoRodHCkWUDCx30NDga0ipGoFeZ4cLfMZ53y7oaKglNQj9OoOs1l60C/mv08nT5GCiEVASEhjDS6+SgohZPwnuLAHSyoJaYmAUDIx0b5izYGrXqATz2adw/tJ3egXg49sy8E9D3BuPPK3XWjrD1va2+xS5X4/GjWUzixjoVZGwCOgM8PBF54qBiYSPtg0N/yJiazHqflS5ApN4rYNtOGE+Pd4pHcJy21MxjMNC+xljm239lPQODt7ucMv03rTVMj2zERny81yVLnZ13iO9HHHxYpwINilSGtYlsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92PDk+wcwidbx2Sl/ROV3Sc3Co3DZPaUJeFXlsy5pdU=;
 b=rsoHE2RBOCgopjtYYgJqAtZdmKUUutwn5S4Oe2TeOlePHSfhM0bJE1YpqEKM9SU9ti8V9HaloDk5xUUYCSRGQY+75Sc75xIP8LeNWt10L19AAn0thNbOIB5QAEJNDrPGZgsJ/HgjmDVxfHI3XjTMkmZ0PqwP8mnfrwjdPQ6X8lo=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by PH0PR10MB4453.namprd10.prod.outlook.com (2603:10b6:510:37::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 08:29:58 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::cd3d:1d7:c4bd:d290]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::cd3d:1d7:c4bd:d290%2]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 08:29:58 +0000
Message-ID: <1da247a6-57d3-a2dc-7375-e5a1fb02f9c1@oracle.com>
Date:   Tue, 23 May 2023 09:29:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] ata: libata-scsi: Use correct device no in
 ata_find_dev()
To:     Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc:     Jason Yan <yanaijie@huawei.com>,
        Xingui Yang <yangxingui@huawei.com>
References: <20230523080443.398912-1-dlemoal@kernel.org>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230523080443.398912-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0599.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::11) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|PH0PR10MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: 128e8a79-a4f2-4a54-fadf-08db5b67e4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56gtFrmx4HIA53z1iD7wmQB7NIz4lWVFmdF/gOnPSLWZN0nt5wv2u0O9S/FQAuCwPtgVyhvslHALI8A4wIkpMSEvlokDCYWASHsofjC9vQclyYqKz0ZDjcupdBpGJLgJYePqmA6Pj3nTZROOBW4JwCfXI+dH/RtXgDpS/xPFa3x/QAZWp/hN0+uFZYsBdd3KTnk5YgzCxaozqFsj3Y4afYvTy6qX7aWTltCizGsQ2DJ6MEPNwOorceHVsOWD0iDFVC2r0mZkTM9d7iDV1Gb9v3aFmoiuNFEsonlXfBQQIuWkbs/V8d16kG9qDfdSvL6tKDls8vZTq0j9RD3yCyYvBCkULbNrTd8IttuYsbde+7kYB4gpHL0dOYBpCKatm3agRd1ZkR8bSHehCDqeeEotnU0SmZydDyup3rVlco23vRuFiaYPVKOhTjpQiwYsUmU3JocOKkSv085NV9Tvdemj+Gpa1lc6NFeDqJA2DCCozS0MEITS2SNk4j3NVSEgeTObuVMCCb7q2seeipL6BTSS4ycu3esoARmZf4RhQegNvkpeYskMNo6NZHLto0keJRWQlawplZ/umFsu8F2MsPo9k/il6gdEpKbuXV2i/qKq7fnNOdpK7RmSlmKUE3cjPeSlbvkRz9AnvL0i4PqyZkhekQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(31686004)(66946007)(66556008)(66476007)(478600001)(31696002)(41300700001)(6486002)(6666004)(54906003)(316002)(36916002)(4326008)(86362001)(8936002)(8676002)(5660300002)(38100700002)(26005)(6512007)(186003)(53546011)(6506007)(83380400001)(2906002)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVRHZHYzbGU2c1F4SnhRZDRTcnRYbjJRWVNtamlKMzVWclNvaGZJRkxRZ1Ju?=
 =?utf-8?B?a21uYlFPakRaWmRTazd6UXh1bUh5OFBjYmVDK1BEbG14UmtrZE02d0ZaNk40?=
 =?utf-8?B?czRhcGlpWmFYc1Bick0zemNTSUV2MHV6R3orUzI0Q2N2WC9pN095TTZJUnhK?=
 =?utf-8?B?MlVjWEpYdFNMSC9wSEFNeEdZMU1OLzM4a0tRS2xzTGcwTDhyZmtMRGFxUmhh?=
 =?utf-8?B?a1RzbDJHd3ppRkJ1WTlRdlRHaWFrQ29pWnFzS2RnMXFIdExNQmhNS0ZSOGg5?=
 =?utf-8?B?eDFJQ0ZhdFo4NFFTTzFzcWQwWHZhYm1WdU9zOThVT3hxQld2N0I2Q1pObFZ0?=
 =?utf-8?B?Umxtd3ZPa1QvSEtNTGJTZytpZWtrMUZBa2lRM0pSYWcrMCtSbnhUVjltaXl1?=
 =?utf-8?B?NjRXWExsd1ZISWZOWEVULzBialJIM2NZVkxHTjFKV2hYK1V4V1lQNDVVeVdG?=
 =?utf-8?B?RU1FZ0phS1M2VWgwbFRaVHFhWEFKVGdXdkp6ejF0TTZUa0N6ek9kOUtxSDlT?=
 =?utf-8?B?Z2kwWWxXWXdpM2g1anhCN2N1UzA5MXViSUZ0RHZHTk1jTHErb0FseFdYVXMw?=
 =?utf-8?B?Q0t2cGI5Q0FIaGN4cDQycDFsZVhyb25tWU8xa3A4QmoxSmM1bHNscnF3ak13?=
 =?utf-8?B?NlZzeEM0MWhXSXZoTmd0eUZPNHBYMGkrQlZiRkhuZFdNbHpIVFlTRGV1OFlp?=
 =?utf-8?B?QWhJcFA2aWd0cjZYMDgvSzF4YUZmYW55YlJmZmlxelBLNWhMUWYvK2JFTyt4?=
 =?utf-8?B?TXN2NW5HKzVZSTRxekg0TFZVYW9xUEFTRkswSjl2blhIRDJuUXVKeEVzWXRE?=
 =?utf-8?B?WVRXOEg2aU9GSzhKK3ZvTlJPNWI1M0dLUWxSVjl2WkVpTkNVZ05yWmloNCtu?=
 =?utf-8?B?OHlKakM2aHJPQWhldG5pOVFhV2o3Q0pSVFE5Ymd3VGlxMzBZSHVCUFFkSXJu?=
 =?utf-8?B?MytQVlNXa1ozOXRYYkRyYS9PZld1S0wyeGlid2ZOdS81SGlhbWxiNUJ3QnFx?=
 =?utf-8?B?MmcwWkFkVm9BVXprWGliVDgvSkhZU05QR3NYdWZadHFnZ2dpbktib1c5Z2lX?=
 =?utf-8?B?OVg0TE1nY2s1aFVLeis5eUFYZnJxaWtLN1FONDl5cHd6RWtiRVZZbEpmN1BN?=
 =?utf-8?B?YzdJNTVyMTF5VnppbUFsWDkvK0c2VENBRkpCOHVPMkxDbTFocmpEWGJIOHJp?=
 =?utf-8?B?eHNaa1hsUFBCWGtpaWR5MTFLQmt4MGlNaGV1bHQvU3F0dGlWRExrTmZabXBN?=
 =?utf-8?B?MklKdUpKdG8zV3Exa3BabnFCWms1MSt4QlNYRkNrNGM4ZC9IZWJ3MnVoWWRH?=
 =?utf-8?B?QTN3WDlieGh0cXJIbWZBdGhMZHI3cG93MXYrUTc5MmY4aHE2dzRUbzFkcnRR?=
 =?utf-8?B?SXZ5YmFWSm5vb3hST3R6V2Z2WTh1cEJxcnVDaVdnSlpNT2RBci9wVWJZTFBj?=
 =?utf-8?B?cGJiK3AzRm9lelNKVlJvRmFwLzQ4Sk9kVnRzRHA2MTNNYllPNmtFeS9NL2d3?=
 =?utf-8?B?YlF6NTdrSGt1ejNKcjViL2U2ZVRTVEdTVHgyWVUvZ2hHWFdsUmdEMmN0eDFr?=
 =?utf-8?B?elJTOUFVTkprSFVlRFdUN3llQm5kQjFoZXIvMmxPdGd5VXBlT0o4OVcxQzBE?=
 =?utf-8?B?b1ZDekd5czVUSVlWdS9TZHh5K1krUU5BUmVrejh5RmtxU3RTOEg2dHlNdTB3?=
 =?utf-8?B?am4ySThrMEVqZWpIL0paQ1d6d1RrTVlpTm13NTJSTjRUaGlKTDNjRVJtaGFR?=
 =?utf-8?B?ampJUENCbm5vUjdMYXJhMTRRTDVLK1FJakJKV25UVnBDelNFN1hmVUpMWHY5?=
 =?utf-8?B?OU5QZnlkWUFHQWZzNk9xVTFNaUdOUy9Kd2lyU0ZuajkyblZIc0xrM1NCTWZ5?=
 =?utf-8?B?Y0VmQU51UFduTm9mOWlhMFZLcS9MeVZnZjYrL0dIcjVQYzl1bTM0T1dUTzB0?=
 =?utf-8?B?Mk5tbFBZSkczSjFrUFBVNkZmWVVLckZBeEQzMTMxYWQ3ZWhIU3FleGlTM2VH?=
 =?utf-8?B?QTYwY0lYeHpHTFZjTk9MeEcvdFQzSDVWQ3huL203V1B2em5pblpUcFlodkVu?=
 =?utf-8?B?cFU3MzBGQ2RGU2FQWm9oRkpKTlp5aE5qbkxkUnlZTktKbnVzUTYzUG15QVdF?=
 =?utf-8?B?aTRiQmR0YWdhUVVYY1VueGFTd0FFd1BzVHg3OWhUaXdNRnNuQWZZaGlhRGE3?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QmmPc5DeZGP9uB+H+VDqAAOs4mufbdVV0yFKHSndGzucrlQPnRK0GhvuZOS63hseaDoDrLIJ5ShU/0cVwDuDXxay0VSUaUEQenFw0owvAYy5XrLDp5zjReRyJyk/+89zL7JjWoXc7XrFWEITTOQC6OoVvHFuJwfsVQ9ykxWtnqm51gOoyzYCDDGsz9d4aMLWcCKKvl//6TkpREcic1+M3S/Buiqd4JJGgDDunCn0rJGuDTC/sXM3Qsk3GOHf7KcDA5N5tuoZIJheD6dzHIYkegPb14HYvHgYmi+ian+mL8/78+LONTM6ZGzPToQBjdk+hcLrYxdw8Lntvz/QvJ2uETugQRg9w3alNFJxPJ02ah0gf3GV+RPJoNzd/hTkxIVXwVHQqnr06NM/C0QF/TBxYPMVTBffLUTdC2Swy86Yml1WuNEkJI1y4AQOHgJJ7xR5Jt+FapoQKjIMkvCsqVnk0DAJKKyKxsL0aOEmFhucyL7LyHYm3fohi7JcaMNL9DoD8cZ8YFMKHjs/WQDbLUT+PPw44KWyvk03zCf5cPmFvQTWkigG+HKPxWSMteo2DMzsIY1M0Pr7DPEiTB539hOGiye63eTIVBzDdf0aeFyCoOOytyyph/qR2kuNLoyvPTLQwhXlxvQhzK/bxWjwi87K5L8ogcvp0ivO5a/4CYAF2FS7rDjB3i7X8we4Orl4IiG6Y5HO1GNQEeFitRUJXA3uYkRD3gD/cfxLTO4mwrmvJAWmix4nAUN00hKb3DdCV8VqBe6finlmKmT22QCNAFSBtmYrWMfIeU/6w5sB5NlPVvDDqD6lm5LOd2jbLqQgZZhn
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128e8a79-a4f2-4a54-fadf-08db5b67e4c5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 08:29:58.3083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zegy2AF9JnluqUCbxLJyMOphh1Wjm3BAM3Ad578kfFdb6Aoa13f3l0zDqhjURvOJXUmnVfA4EXxyZcuQc3eOdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4453
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_05,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230069
X-Proofpoint-GUID: kXr_AE7x2xEPHFbM0mEgYhJdReioYdAL
X-Proofpoint-ORIG-GUID: kXr_AE7x2xEPHFbM0mEgYhJdReioYdAL
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 23/05/2023 09:04, Damien Le Moal wrote:
> For devices not attached to a port multiplier and managed directly by
> libata, the device number passed to ata_find_dev() must always be lower
> than the maximum number of devices returned by ata_link_max_devices().
> That is 1 for SATA devices or 2 for an IDE link with master+slave
> devices. This device number is the scsi device ID which matches these
> constraint as the ID are generated per port and so never exceed the
> link maximum.
> 
> However, for libsas managed devices, scsi device IDs are assigned per
> scsi host, leading to device IDs for SATA devices that can be well in
> excess of libata per-link maximum number of devices. This results in
> ata_find_dev() always returning NULL for libsas managed devices except
> for the first device of the host with ID (device number) 0. This issue
> is visible by executing hdparm command, which fails:
> 
> hdparm -i /dev/sdX
> /dev/sdX:
>    HDIO_GET_IDENTITY failed: No message of desired type
> 
> Fix this by rewriting ata_find_dev() to ignore the device number for
> non-pmp attached devices with a link with at most 1 device, that is SATA
> devices on SATA ports. For these, device number 0 is always used to
> return the correct ata_device struct of the port link. This change
> excludes IDE master/slave setups (maximum number of devices per link
> is 2) and port-multiplier attached devices. Also, to be consistant with
> the fact that scsi device IDs and channel numbers used as device numbers
> are both unsigned int, change the devno argument of ata_find_dev() to
> unsinged int.
> 
> Reported-by: Xingui Yang <yangxingui@huawei.com>
> Fixes: 41bda9c98035 ("libata-link: update hotplug to handle PMP links")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
> 
> Changes from v2:
>   * Change ata_find_dev() devno argument type to unsigned int
> 
> Changes from v1:
>   * Simplify code change (remove uneeded check and remove switch-case)
>   * Reword and improve comments in ata_find_dev()
>   * Reword commit message
> 
>   drivers/ata/libata-scsi.c | 34 ++++++++++++++++++++++++++--------
>   1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 7bb12deab70c..6878ddf49880 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2694,18 +2694,36 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
>   	return 0;
>   }
>   
> -static struct ata_device *ata_find_dev(struct ata_port *ap, int devno)
> +static struct ata_device *ata_find_dev(struct ata_port *ap, unsigned int devno)
>   {
> -	if (!sata_pmp_attached(ap)) {
> -		if (likely(devno >= 0 &&
> -			   devno < ata_link_max_devices(&ap->link)))
> +	/*
> +	 * For the non PMP case, link_max_devices is 1 (e.g. SATA case),

mega nit: non-PMP

> +	 * or 2 (IDE master + slave). However, the former case includes
> +	 * libsas hosted devices which are numbered per host, leading
> +	 * to devno potentially being larger than 0 but with each ata device
> +	 * having its own ata port and ata link. To accommodate these, ignore
> +	 * devno and always use device number 0.
> +	 */
> +	if (likely(!sata_pmp_attached(ap))) {

Is this function ever used in fastpath? I doubt it, but I suppose having 
likely() can't do any damage.

> +		int link_max_devices = ata_link_max_devices(&ap->link);
> +
> +		if (link_max_devices == 1)
> +			return &ap->link.device[0];
> +
> +		if (devno < link_max_devices)
>   			return &ap->link.device[devno];
> -	} else {
> -		if (likely(devno >= 0 &&
> -			   devno < ap->nr_pmp_links))
> -			return &ap->pmp_link[devno].device[0];
> +
> +		return NULL;
>   	}
>   
> +	/*
> +	 * For PMP-attached devices, the device number corresponds to C
> +	 * (channel) of SCSI [H:C:I:L], indicating the port pmp link
> +	 * for the device.
> +	 */
> +	if (devno < ap->nr_pmp_links)
> +		return &ap->pmp_link[devno].device[0];
> +
>   	return NULL;
>   }
>   

