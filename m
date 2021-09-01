Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD3EC432BE
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 19:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D2006101B
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 19:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbhIATCJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Sep 2021 15:02:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58402 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344147AbhIAS70 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Sep 2021 14:59:26 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181I46Xb005715;
        Wed, 1 Sep 2021 18:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=C/oq+oZWoqpgO0D5rKGS6XBGZO1jg3iCheHlsDvc0E8=;
 b=b9Ykzev6LRs59ZcXgl+N7b8mMRN2kb7NBwbNbxvCiFzpzkbAFsdq95qsv2nYDboBUgD/
 NLSeGK7bKoFrdFemKJJrC2Xo/LiqmoiY+n/SZUuhnBDmkQ2cBHxyt48G+b33IaKs8PBM
 YPalyM+/hRjJZy2LZe6QGoPBTjyuTxF0PzQvnMBMGdB/bu7rppS/K4hgkNO6n5TV3KoJ
 1bq9fFcbbWYOUC8xFM7e8NSJMlkWl/poQ+enOu0wQO9bpDwE4T0j4d3wmI97nCmJ8fuo
 ZCyJb4LWYDGDX4jq/jnjQYO/poGQhCCrBcqjJpcX7kLxNqboXvk5F8jJeCLTbohjt2zt pg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=C/oq+oZWoqpgO0D5rKGS6XBGZO1jg3iCheHlsDvc0E8=;
 b=V55cCXmRLV7jFcnKPlC4Fom+Gr4RtVTw93/o+biBbI4nboAI53tM9d5Ehnk/vgOG9GNR
 j37hz5sr71S0N5UgLI8l31+OCLqwtWKKSW6ptr0hjQGxJDeXnH3mpDdj/JNOxGDIYm0h
 L0/egJLcyPuMHTY9si0g87lSOXEPoQrYMSF+4SpwcviRY8AdHgxeqTtNosteqqprHIzT
 wc7V5Ojw+K1deh/Z7U6004i98ZP5rfzHN5YVF8bNq/JZZXVIR06G2UfnFFx0ekH83GZ6
 q8rhp/gqM5jmKHBt7mUJNnWeAdIOM9kyMGMKPy88ZSlq6rUt5JAMtsXDtkeQnesyqdtG EA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw0g8a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 18:58:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 181Itd3m030848;
        Wed, 1 Sep 2021 18:58:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 3atdyubjp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 18:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmeE8GM9WTXg1HoEcdyfoXMBWX11OSMDWFS/kW2mmomQMEidLtXxLxkqoDR6H1xQsokYDS0tdQPPJROv0DEcPtCCVYaEoUYHeTzsHCweq0MRu3N3ipaCWd5lYI2R8N8jFi/3S2uUtBN6q0EixMZ6Yw/YZcbT7yOR6iLLv6jcwMun527j8ldT1ntSEtRZGRQV4vsTjaqybkXE87Ym2Bh113FHbVoNkt8TGoznZUJcf6uZmntDQ7pOjRPbem4K8zNbVNYLV1dIjBuMpwDgmvWSM3eO2HWdmsNfVTLshH4mg6jnAW6EhoaE9f5+vC63h2CDBcCBiaMIaZtIC4/Q9LLUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=C/oq+oZWoqpgO0D5rKGS6XBGZO1jg3iCheHlsDvc0E8=;
 b=KKTIlUwo5zU903E8zN/mEuNiLBtLQgVtkWffny+87/snDhBbmhIAYC5/NYgDQsMR5LTWETIQv2SkaM+uo9+jdiuj6cVA8HFoFsTFcCpKBzj/jxMAdTwp9CblK2Xl2faLMCI+splmxoHGCrBNQks4THEpnkh2scYTlfeU/YJUe0NHx3D83PnOTUnMjrmJOGzcZfV1TMNoQaz9afwlBcuxZfu4edvDRqDlvvatuHye0cCAbPNSaQOTlZkjLlTjuAAbPpKjjRBrYZmH4ReqA9yYoMiHQ8Sq/0gVxdApboszr9aDTOfzKVfr9FrOHMX6QyGN8q3WZVbzvcPQEjRI6H1F/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/oq+oZWoqpgO0D5rKGS6XBGZO1jg3iCheHlsDvc0E8=;
 b=M46fDG8fk1ry5XlfQy1paxflSDwkCKV+x2Wez/lOMATcBklCBGqpyN5Rsvstzs8PnKK0vqw7jDBszBoCRZitKJC8JazryyCE0/XIzUqZ2xhjzrcsekcPHVxZY0u4Z6TQk5fkcHlvdv5oOJ5HtWhqTRNCCBmk2WSMNrYxhq0kyyo=
Authentication-Results: mailbox.org; dkim=none (message not signed)
 header.d=none;mailbox.org; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5419.namprd10.prod.outlook.com (2603:10b6:510:d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Wed, 1 Sep
 2021 18:58:13 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc%7]) with mapi id 15.20.4478.020; Wed, 1 Sep 2021
 18:58:13 +0000
To:     Tor Vic <torvic9@mailbox.org>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@redhat.com" <hpa@redhat.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Subject: Re: [PATCH v4] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung
 860 and 870 SSD.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14kb45dut.fsf@ca-mkp.ca.oracle.com>
References: <1876334901.51676.1630481868266@office.mailbox.org>
        <DM6PR04MB708115B43C231444AFB22DC2E7CD9@DM6PR04MB7081.namprd04.prod.outlook.com>
        <1e52352c-05e3-700a-58e7-462e1c0adbd1@mailbox.org>
Date:   Wed, 01 Sep 2021 14:58:10 -0400
In-Reply-To: <1e52352c-05e3-700a-58e7-462e1c0adbd1@mailbox.org> (Tor Vic's
        message of "Wed, 1 Sep 2021 17:56:57 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0279.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SJ0PR03CA0279.namprd03.prod.outlook.com (2603:10b6:a03:39e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend Transport; Wed, 1 Sep 2021 18:58:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c78fab20-cae0-4502-e4c3-08d96d7a7340
X-MS-TrafficTypeDiagnostic: PH0PR10MB5419:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB5419419EB60CD86D1740E0968ECD9@PH0PR10MB5419.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zCBtL9wxbzO7ncvaR4uSyjzl/z+fkKno13OVNB2YvJ2b8BycQhSLZRYBBhtiySFBJXzabTp/uCAO115/HbWc/ty2J9PN8NW4krtlYu+//LzK6Jvs1k7ebgA9LbcVGdg1Z0NFmCXxvu7QYRQ59z2DSumo0xL2sgdKW3ihtB5kDNVPYggU6ZGHntAXxuha80CqxTP/VwbZhiH164UT339ovOrrOizF/J41Tv7Q+v2w8j1yuA/d1uowa0Q8UHNxDjWP8hseSzTMyaVQBl/qwu8e61lk6mazyDXqk/ncwExeDNXVs3Ja/dFCjsr+Qu2U84tvVtaLPKu3obeddI0wQTR5YYzjwIanjIT+iDl1Yft1+ia2CaQt+lPF3cqKoKAtpq8e3vdOvxzKlafWNvl44gGl72hNumJk2WYq/6oCAYVTl/TaiO6XabyoBW/pZboHoMfnDPFDTjKrAbrH7Uehr9eH6LLPXFo3SJUmB72Gol9Pnx+Wi61Td8Z4Fa/OB6JjAAQkOUmotpqfa8Deo6BtCeKvIvgC43zxw03EXvYCLvCeMxl0n50iYikAezTYPjIsYbHhLGv1m7bteZgtQQWKfDsa9QOaAT96MhCQo6d5ZO12ZG2nuiqn9+TfcvsAoaSr9oZL1HyMjX1R0DTnakgHeYAKfbjhnD3H2Mn0gkusOmMXrJBwhC3ty+3/nFK2dA93/yvV6+xk9dMDORUprxyQ5t26Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(396003)(346002)(376002)(6916009)(186003)(86362001)(7696005)(38100700002)(38350700002)(83380400001)(52116002)(956004)(558084003)(8936002)(54906003)(66946007)(4326008)(66556008)(66476007)(26005)(55016002)(478600001)(316002)(36916002)(8676002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L7AcnbFD7K5ORXwTSjh9W5CW9moD7/IBmbYuEqeFEcHlJU3pYaGQkdifl/uY?=
 =?us-ascii?Q?kYgVivqnSoL9yH+2OLQCo/kKdzIhjJVW/2Np2LmEWo5Sr4hABIThvOBB7DT9?=
 =?us-ascii?Q?hxQ8/UXlgg1lT9qlSKFH/c1/EH62+7Br0OzSw/TCDH9HqJlcgQCUtepS6Ejq?=
 =?us-ascii?Q?2J78bGdR/OHjRswoeBvqnw6lRDDKKzbtZ/DrVohA2sySU4Z3nd+DSdR7PkxX?=
 =?us-ascii?Q?VpoTMO06Ctiyb8JS8oHdCI7cBoASkoIOBxPKcx0ezuQ+WvXxINoxMQ6/N1bt?=
 =?us-ascii?Q?azKK8JnSplCmzPq6Svm/13ne/DfLaLwEMBUrw9FxLFnKVlpE1+2ONx4UWtmz?=
 =?us-ascii?Q?loGCtH97J4chlSB5qz7eJbSBPpwusJXg2Ml5slQZITlZViHkEhhBB+rc1KN0?=
 =?us-ascii?Q?Csradsn4K8OYTw6RRj9sneKhAUQ1o2716tc+uXImUs5xiKkP+dU6h5DW+9Yv?=
 =?us-ascii?Q?A1RhugQQoSc74hTkW8E1qU4oZzQCBRev91SmyO/m+g9PcZLxzH0t4guJ9WNk?=
 =?us-ascii?Q?c+g0jWovsZQbAKBpJjjzIEAcKdFDbUUHVqLftR5bvKjKdvMzhS1CqDVlJGxL?=
 =?us-ascii?Q?LnkdMQIeIJiQjdzOmeNZPkJl7A+4yKPIPVgB1bIxk8wyeIS82dH3BQ/CBmql?=
 =?us-ascii?Q?JiyU1ucA6g7lJ1cG3+ZIWn+loaCn1OTWxKM9imLkmAodwVC2ogMkweGIS7XQ?=
 =?us-ascii?Q?gEQGLXsSj04/S7Aku0Onbj5SkEfaVUPUkfPMURT5lhfMr7QQc0zHzywSZ+Fe?=
 =?us-ascii?Q?dbQbunz+hpphohVXMn92A6y7h692YQo+9PCInOwl2Sybp6UaqQYNwzZ/j8NN?=
 =?us-ascii?Q?PnSW8tCMEIRuP9SsjLkwurBcpRCPU4apZHQYKjfqQzHrNwHF5IrE1U59WPaG?=
 =?us-ascii?Q?7PT2mvcaeQGB2VHE4B8PFU22AhSkn1oqC488gU4KQdCjQjY8laQgup/0CMKk?=
 =?us-ascii?Q?VVi2tQchV6t4TxSFedJxzk1mfjgR9C/ixqpnUaj7fERFzuvY0exfnF8ReerO?=
 =?us-ascii?Q?Qu4Q0TcD601HgGyq/ouxNEmiSFHrfhPYDuSDnC1LbElXvY6CxsvAYuzNi5lp?=
 =?us-ascii?Q?gvVCzcHytWjRnS553tnboqMuF3SoGvKuB1aeDOmcSmdlagzUgoxX420aQXYf?=
 =?us-ascii?Q?RKMxhUxscBXkaF9pHTzj4NRSjOEs7AxMdk2a+fKRr7sfq8+KdJqxOSWH7bgg?=
 =?us-ascii?Q?Bp/+zkDPa237zKTfaGD4Tt4BY3/XvqDfDHIRCloa/1wVrrftirGtTz47QmMO?=
 =?us-ascii?Q?SF6tnm9Rl2sf3DtGECM+yy+jq/zrWhXCCZc8Y5X0RHZ24/lB/geQfslA8MtU?=
 =?us-ascii?Q?agErgkYgGv18k4HyW5xCap7V?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78fab20-cae0-4502-e4c3-08d96d7a7340
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 18:58:13.8000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NY3p5KqFB6V5fbfA1chfXmRqKLQ/Bv8pgGPWHOYF1UZWExFVl7brc1zXV34VEZ+Z0eG65cISMuujKISd8dfBkHbV6X1Ed2br7gO2UWwEqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5419
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=862
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109010109
X-Proofpoint-GUID: GvgaP9ptrSaD7qI3d2jPv8uAk0YveTfG
X-Proofpoint-ORIG-GUID: GvgaP9ptrSaD7qI3d2jPv8uAk0YveTfG
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Tor,

> Samsung 860 Pro:
> $ cat /sys/block/sda/device/queue_depth
>
> 32
>
> Samsung 860 Evo:
> $ cat /sys/block/sdb/device/queue_depth
>
> 32

Please also provide the output of:

# grep . /sys/class/ata_device/dev*/trim

-- 
Martin K. Petersen	Oracle Linux Engineering
