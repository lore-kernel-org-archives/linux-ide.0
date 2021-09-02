Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAABC433EF
	for <linux-ide@archiver.kernel.org>; Thu,  2 Sep 2021 18:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F441610A2
	for <linux-ide@archiver.kernel.org>; Thu,  2 Sep 2021 18:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347005AbhIBSm1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Sep 2021 14:42:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12566 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347024AbhIBSmZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Sep 2021 14:42:25 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 182IA4vh029120;
        Thu, 2 Sep 2021 18:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=J/uFNgP94LtXqwGnwtJ5u3/wVmVeEOh5RbjOyQVXOrs=;
 b=X3c7LZQadoyeyv5AGPAIL46D3ccbPfl0gwZcXdmvyM02Yh7FjigKnaVizJlyiONjC0bC
 0nTOaKgW7bXA8l/jNMwa/1uvMwWm/yTDEGAoWr9mt2QBTVvFyi/WgEhATVeNw6uhlXpB
 /+Uqz386Wakxv2a/riab5C3TT5IZ1OA9WwOgelN3/04DpNQOdn9400rTjpMIl/VK7oMr
 s+cfEqv8UeQEqs6b7U6ZFmM0ksgcoD3SJyssDZttgSKTE1vmZSVJcuLEONXCS5h8n/z/
 8xCSHjcd8U+s0VSCBn6eT1M4NN/zVF/BGzrWMololC58azTD7lOUC8dxzIZJf2P5V7O3 /Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=J/uFNgP94LtXqwGnwtJ5u3/wVmVeEOh5RbjOyQVXOrs=;
 b=aQV5av3k6zA6nEkC+vdGvT91FbnQOoGXzKRbCIESQtxUcc44l2Ab8/I9TRrTwfGfDORi
 DzFrKVoSkvjWfkuSDVBW0LrT4P2v7AeI/w6THh3nO9Vb5vNR1PnPHCTmFlbgeSg/qjBd
 ZkmxaxqLy+02oVmsiXMYYAGImDG6hvLwZurYZqd5ZcoARQiR+mBZKKRyjKgHxPI2IjSj
 QRfn4od73UrlhS+lyYcqLO7Bqrt/bdHcjaIr4WqwkpxeRZKYTs5X2XM9r7hP/A7r3xhk
 Dxr9a2HmsdMiBzKKvQ7VDz2TxFqtEJYDcmOuYt9pH7eQVgA7KDv9yYXFAgFljd98r9AO ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw5bpv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 18:41:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 182IZxai057209;
        Thu, 2 Sep 2021 18:41:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3020.oracle.com with ESMTP id 3ate00a99c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 18:41:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nx13Ibda/008KS2Et5pKae0Bc3f8lFIjcNknaHWpKHOX7xlPjJGgq9l02Zo5SHCLIBp0nqOtSePKLmYbNVSBWiVzW4JHql74m+RdyBg42joFtm7CqbwV2LJHNtGcmilpbnpR7tr4K0Jl/uZoPwQdT8PBbYSL8qtraokpxmtNJMFScdlqRU5uwQViMKEYcdRjzEFp0tCKheyzu5gjRCQmD3h9ELuWhznCrSFLewr5ThneiQIccGXNGusEupsdTU/6fnvhCqN+fwtIVnGeqNXxT7jhWn3I+0ISfL3fuuWj7YIHi2xrVRpDIdYXtY4GgL7iuid3C2/mjmXf6HQEtH1qxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=J/uFNgP94LtXqwGnwtJ5u3/wVmVeEOh5RbjOyQVXOrs=;
 b=gg2tMQF9ETdP3m7tFSe1ldmoaOIrdnZY1Cmv8srVT4OSt7GAaf0PqjUS2Zsu1zs947FkFIjr5KMbVqzKwEs5ulIzv2+bVJW9gnzACtOGb/KQN9oF3PAVR1SLwx04508XTRddOjY8aDTAkSxoZcg7zNemjvUckH2YVBgST4rX4vT/cKbuM8R/FCSNJBWCrTNNQj+IbuuepuiKuSaNLq9xNgQHPLh/9WG5JuSH6ME7SYPSXD6nJGFEJy3Tl31K7/yMjqzcmQARPKpFzU6wQySDkacfvpL7Req6qefwOojDX3Q/78Elv3t48gSH/DWx2tYIRmjIF65HLYDg++3utIjydA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/uFNgP94LtXqwGnwtJ5u3/wVmVeEOh5RbjOyQVXOrs=;
 b=bwW4tQvJTRr3lAviiqOccajJHm7LSYCeg1GpicoOB5PfRQXp8tYoOce+KPTWDqSM2aO4Yf302VMhKG63WFfDJFnXjio7BGYKyAisxScvw3ctY+X5l9vPW9Js955s3qFBnYZRbtpJu+MK6ciOFrykTPpHHqCXkcYAXb/yE5vRmxU=
Authentication-Results: mailbox.org; dkim=none (message not signed)
 header.d=none;mailbox.org; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4630.namprd10.prod.outlook.com (2603:10b6:510:33::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Thu, 2 Sep
 2021 18:41:13 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc%7]) with mapi id 15.20.4478.020; Thu, 2 Sep 2021
 18:41:13 +0000
To:     torvic9@mailbox.org
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@redhat.com" <hpa@redhat.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Subject: Re: [PATCH v4] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung
 860 and 870 SSD.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mtou4y8v.fsf@ca-mkp.ca.oracle.com>
References: <1876334901.51676.1630481868266@office.mailbox.org>
        <DM6PR04MB708115B43C231444AFB22DC2E7CD9@DM6PR04MB7081.namprd04.prod.outlook.com>
        <1e52352c-05e3-700a-58e7-462e1c0adbd1@mailbox.org>
        <yq14kb45dut.fsf@ca-mkp.ca.oracle.com>
        <1789509750.63786.1630568657296@office.mailbox.org>
Date:   Thu, 02 Sep 2021 14:41:10 -0400
In-Reply-To: <1789509750.63786.1630568657296@office.mailbox.org>
        (torvic9@mailbox.org's message of "Thu, 2 Sep 2021 09:44:17 +0200
        (CEST)")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0049.namprd16.prod.outlook.com
 (2603:10b6:805:ca::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SN6PR16CA0049.namprd16.prod.outlook.com (2603:10b6:805:ca::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 18:41:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f57795b9-f3aa-4aa0-ff71-08d96e413d6f
X-MS-TrafficTypeDiagnostic: PH0PR10MB4630:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4630600EF267EDCE83C4F5928ECE9@PH0PR10MB4630.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h+/nZPmfcQkBvgUFH1aUeGc5at0/TTPPmifosIX8foKGrTYqvLP0i7f2fHkJkPXTUkYymL3spi81lPWdYx5cq08LtkPIO6eAG4R5Xc21d8iRvJ42A1T8qnMVWQ+Elh7g1yaVTFYUuoki5hMzMIu5LaxV1VNM+O4tPgjoVdRi0qoM13kotD/FyHsbmMJI8o/i4y49Kis8UU0QlXOoTEnkPaFBUEGiSd1UDMiqoTCLrDKc8ZzhDdz6sgShNIGt3fxHQFtIFWQB7FNkIPaqzOtaXFRHzCLGaPMjPpAiZP0tP96nlvXno1oX410XhYXk6CR6+b6SoYGuFXnMKfdeO0wZpx6HAHst/Pc3+UvTk7c/F8ZLaNi1d/OjwEZrfBb1NMKNAvlY515MwAmtEGP7kz05n28ly6XP7j9zqP19uQ5C+RU/qR5lsPOCjHpb8OR+xwvZZRYciBl5vH2qD0cj3MeiZlWuVBLOImorzWaSaDi7uhRKdfOpL0qoH7h6NVEokYJqX2okoy+s5jEClcNKADpQTHbbrJ7HZV059x99gFmBDy57Nrap9g+OXZRhNs0cbBPRZU8He0s6dt9H6skb9XfKy+a3M8mrnfoL3cRTSGPSTrAsKHNIpYVoWH84+lG7Acnuts+76vjx7o8Zp+Zj+MvqBqrdiYXu6VOiUim/kckvUPiBya/6SvmEMe9/mYs6/rc0qtjwN8u1NF5KnnD+3+CARw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(346002)(376002)(366004)(956004)(316002)(4326008)(478600001)(55016002)(86362001)(38350700002)(38100700002)(6916009)(8676002)(8936002)(2906002)(5660300002)(7696005)(52116002)(36916002)(26005)(66556008)(66476007)(54906003)(186003)(4744005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oAsWBoPEizQ4WJd+PFlTiNFmnCJuovo7eX3YpPhsH23+AIh3pUutKEFjZaEO?=
 =?us-ascii?Q?SvTtsuf94H952BjvA5gGgWVao3rxiAy42nwf/5lnbHZMM4rOY2V/6OSf8jei?=
 =?us-ascii?Q?jD6ZgqKMwDMCfUUihgQQkwoPkNeLZJ85nOjZ994KfHGF9yKfvDOtfes4Kewe?=
 =?us-ascii?Q?VSmtDpUl+XZU6zoWPKOz/vkDufJvYT3fVjai45zepSaSP+LH7ftNwyeI9UGq?=
 =?us-ascii?Q?WPehGuHCjfnLyQUm3mOXw7ILkzFySt/F8QKIIyTFKRh2U/2OvBVCU4Vz6NRE?=
 =?us-ascii?Q?xCM/5P8c2VWJ1VnKXebRDCptOxxayekQ3Ao1myengjQ0ZzMtbS+UOsZcrq0+?=
 =?us-ascii?Q?qJuzDvrKB+aPrwIPtCXsLADjjwe7U1e2e5nEzwBc0lAIcakmACNX85YUaNSa?=
 =?us-ascii?Q?KbaFe9ag8ICKlgYiSzBwxCKqAc5CX9v4x7R4LXDFLbMZi53kWvkm5C7ZZSwR?=
 =?us-ascii?Q?RnQPUMEVITQzGr5FBulgXtNDdrEAbeg1eawqx2Jwfxm9aAuRuoqXkDMQXJtZ?=
 =?us-ascii?Q?WpnbRg9xngSdChrGyv9UAfepKEj8UPwgDQmu16Bm1Ebcc0PBplBHmZHGYCQo?=
 =?us-ascii?Q?eRcGTKgmdQNPU7+U8rN+ULMpIFmUaenkGoZaAyeO44awZA8nG1DVDWff+viw?=
 =?us-ascii?Q?6QJ774Jd+a+onLYpZQ8z0OmMEbkMMfEqVveVz6zKY6LNWuAVszz/uAyEy9xg?=
 =?us-ascii?Q?xecvpjXEKU2O7pqhvKFg/IGYXDvmJOQFn6xhFCwFWQP2U/NWBk3a372g7/QQ?=
 =?us-ascii?Q?oo6BfPOszjhc4xRldBkZ5WXNo4/cl704hciT2tMLZrLEW0Jdx2tN09KZqYUk?=
 =?us-ascii?Q?M6W6cxvpB1YrBjLb5Qi+61p754vMhbmZxt8rKAOrWm9a0JibuOIlNfiq7EiY?=
 =?us-ascii?Q?sOlV5mO+VCjNk657p7gkBQsjasxLhqNUtkoT5o71FplmLEQEO/NNEcf3UQE0?=
 =?us-ascii?Q?kLzWer4n2scGGLnuBDnL32GdTRBq8Qxu6pyQVnLsdQZMKci0LqnWvfxlRDZi?=
 =?us-ascii?Q?fc8i4BE12VH5fA/0Rr128mIFZJUzs5LBredC84C59LcHb7jprlEgqdvjdswc?=
 =?us-ascii?Q?IfoX0i/Pdxihnm92vNYSyOdsJ+hJhAmTsPHUHxs+Gxa6PtDy/jmfpWOsNYHI?=
 =?us-ascii?Q?Gwvbe4zDpaFpjaCBvwDOntu4RcQ3Br/fTHCgyafJf7CC7NieEYN+Jk+EjgW4?=
 =?us-ascii?Q?jhUHE4+i6Ao5C5VrKm+mgdN0/o28n4HYzHOOUOH2Lk55HzcPz09LRAJZGaP6?=
 =?us-ascii?Q?iCm6lsCIqz27VaqmaKAaLF2pjYgtZqIpC5wTfAaRQw+yZhhX4q3sE7v7RwEa?=
 =?us-ascii?Q?ylHnb99YdRJw1KcE/Fh5FUbw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57795b9-f3aa-4aa0-ff71-08d96e413d6f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 18:41:13.4067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8uB1+OqduQ5zdKJh1sSLupO2iFgp4EvOH1uWvQ1Lih092C7Iak/328rrOb1E+KoyVIjuR1qkv9YSyZW/AwNauGHei3NqWCrkcjGBjEaJlJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4630
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10095 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=674 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020104
X-Proofpoint-GUID: h_ZLDD_vCh9k4Q-ejI0nO8pB3LnJpqAX
X-Proofpoint-ORIG-GUID: h_ZLDD_vCh9k4Q-ejI0nO8pB3LnJpqAX
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Tor,

>> # grep . /sys/class/ata_device/dev*/trim
>
>   /sys/class/ata_device/dev1.0/trim:unsupported
>   /sys/class/ata_device/dev2.0/trim:unsupported
>   /sys/class/ata_device/dev3.0/trim:queued
>   /sys/class/ata_device/dev4.0/trim:queued
>   /sys/class/ata_device/dev5.0/trim:unsupported
>
> According to the symlinks in /dev/disk/by-path,
> 3.0 corresponds to /dev/sda (860 Pro) and
> 4.0 corresponds to /dev/sdb (860 Evo).

Good data! Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
