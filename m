Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C10C433FE
	for <linux-ide@archiver.kernel.org>; Mon,  7 Nov 2022 14:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiKGOTi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Nov 2022 09:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbiKGOSb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Nov 2022 09:18:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8D41DA6B
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 06:17:07 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7DKr0U024095;
        Mon, 7 Nov 2022 14:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=4vHCY20mYqQJFa/0rG/1WHuKTfQpdjJd8dfk0Srm6Co=;
 b=qkb8Z7PBQvSv+kwr8LGo0crVxHli151H6jzzGKy/cqUprDm7TegUsjmyAdN/r+7ThlBG
 hepJJwIHh4oDRyChEH9ji4Jx2gHx77pCh0sra1vq8DtPtAubY/9Ilw2Ctl6ZUlR+cPGC
 hjSKgHphZPrsYpk9eN51KjfVeJyrK+naM0qSExpyK3UpUB3gcPzI+haus+XcObA0TH+u
 SPxpdtFRxpW6w+j5GOLkCcU+yewM0o84qrMXM4tguocd70SAkBvWQXcqTNPNmnxcU3FU
 n1e4D3P1r6CjQPJP6OVss9oKLGRXkjhFmr3O4t2QrJgif4WMk63XZUD4tgCqWe7DoZh1 mA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngk6c1k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 14:17:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7DqHDQ007924;
        Mon, 7 Nov 2022 14:17:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctjas8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 14:17:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQh+6IFelTLzdx4bbfPQVvRhJY9OOu4ilvdNg01NMuVjCNVBT53di2wwsKJlQGXqYjraaFth1A6phnfv5QsDLlBs6loraJHHIPVFKXlMG1P7R3wOHzLgRNPPS0bgaQEiHuCNwmzHcOXrZHbpwxtfMI+b1hFYtzhyc9X+jcz0qVr8kaqVY/GOBF45VSSHAyoeEZQcwsD/Q+JfLP979JGj9ffXNpAb/m1/VyK7dsNsaKaeCEv/rvME4SSOQMvRbBT/1bEDn/XjYBx/bWhEUAplpASVzhQQisr4hyJi0JfZxhSpyOL1Tx8sNDtKL4c7CY5S1CvQYMr+hJ/jFjD34ETN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vHCY20mYqQJFa/0rG/1WHuKTfQpdjJd8dfk0Srm6Co=;
 b=fnG3AHPeKIEkffBn8tdHy+RAIANeGicEUQ6Or2ojqHqlFReVC301UJXKgtxn1eCxIn9P/aLHyklmy56UQBTsWZJxS2GzaA8W1vNdYdKDWi4R7CTTMdMrjsQZMlpdu9kRQ7yN0KrOz6Qv3tFyrto7jfmUWtB4cGLZH0V2NJXXPignW+ZoULcfBsAMXuRQ5rYT0olq8BWD1Q9WDt++D/agIWf6OCbe1hptq75YACKd2tnuV3W388mazNtnDZlpeWt82KWrAOJ9pZJa+Avt492V3CU/77BTwvx4zB3mV9PGSwkOwaxKSEe3KSufNxa2XAefQ6oEv3fhV4MFHMbzOXcx7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vHCY20mYqQJFa/0rG/1WHuKTfQpdjJd8dfk0Srm6Co=;
 b=OzE/efwFvifpbJqtpNpk45GFNB8KRiMEmAoKZ0rOutL4JmIlqmsa8cYFGUuAvDADTWwE8yYKhsNWEhYTnL5U+U9tJrnHxBrNLslM07wb5mepfD5IekSVbyLf+ObOuq7oHP4hKq60Gtlx3XuCCJvMgskoICQLQrhTSOIgUPogl/M=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB5068.namprd10.prod.outlook.com (2603:10b6:610:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 14:17:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1%9]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 14:17:04 +0000
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v2] ata: libata-scsi: fix SYNCHRONIZE CACHE (16) command
 failure
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq135auonnr.fsf@ca-mkp.ca.oracle.com>
References: <20221107040229.1548793-1-shinichiro.kawasaki@wdc.com>
Date:   Mon, 07 Nov 2022 09:17:02 -0500
In-Reply-To: <20221107040229.1548793-1-shinichiro.kawasaki@wdc.com>
        (Shin'ichiro Kawasaki's message of "Mon, 7 Nov 2022 13:02:29 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0040.namprd11.prod.outlook.com
 (2603:10b6:806:d0::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB5068:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c67891e-aa76-4c02-c3f2-08dac0cabee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pNmer/Yj+kOFmjo9UnwU1bjx2AypvKPXbP225sgEvn26rUcUpiWzogFFvgZbMwUopGlqlej52OGsTioeP07bqmoykF0Bk5GoPjLG4dR2o6r4fXmRRB9czzpfWl7Tv17PfcE2dAAQwmm20P4kWL72gWsGXOUWA2vpPHLsY4cpWi3EOG5de/40wHKJDLT8QADuNMpwMxB4U+VeIPRkZzOkSBStrn9Oc7/Ms6K+bU8z9/m90etijV42h7lKUTIAkM7L/zG3Q2klZjAQ89RHwolTQPJy1/QywDGK3oXIeLEZAFqaYBln+oJxBz/b8oJbeVyB4ckBS+n4Yjsgjpc7U2aNw7tnxVGxE2TUNXmq38GAcUIlvbFZP5q1vUqROxFQOzIA4JQMAxo9I2hfWdNk/w/KmR1UJCH3a+73JOa89an5cQxK4LMRtuQdGobgA0Mc7eMyCvz1sIuX069NkXK6A+L0FlDgZ0cliDDJFFrmT6duXIhxBlQ+PuQRJlLIIUCPPu6kpr4O9Ma69/ZSSHeQbgXo+dAgx8/Av8bKBLciGU29WHX8OjEUEPnwsUtdlXGAfz1A+P+EjcKynA7ftqjianBN2g7+tECeLdvYkKFhkuXz9WaIrcRXs1beAass0S6A5iBd2nLfjc3zFtAhJ5wkPb5904tmZABi/0l4/oiCyGxz+bYC5RNHwQ5e8XBQl+Kdp6r1aQneTfknoQDnRAl4Dw84iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199015)(6512007)(26005)(186003)(36916002)(6506007)(83380400001)(4744005)(2906002)(6916009)(478600001)(54906003)(6486002)(5660300002)(41300700001)(38100700002)(8936002)(4326008)(316002)(66946007)(66556008)(66476007)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VkKvKld+5sO+lp8XnGi9zBfkmkdhK3rj4BEB5iv4qN5QM0PK09vzNUov4VKh?=
 =?us-ascii?Q?E9BhQluetUSJMjSbQ6V+lGTqknSR+7F7T6OFhf+N4ro3Cs5xQfhJTTX68VZP?=
 =?us-ascii?Q?nNftI8mOHM9rNwkrzBL4wAXG4OMGIMdkL5W+KhTDjfWrObvC3T34Es/u1V4w?=
 =?us-ascii?Q?Y179Ohd0jCk9cfF8BaJxGXIaC5HtXdmPpUD4wDassJB40DmWh2hsXK+zbeY5?=
 =?us-ascii?Q?bg9vj78qCMX5h7mhg/LyHc24UY9GnwPy7nH1cyh3rrz4GlW75l/ToVWFO+ro?=
 =?us-ascii?Q?Glo1kRhYQXOe8yDOURCJVmTwmwTRsMdiIgu8JX/Qx6Oq0iTRF3oNs38Xx5DL?=
 =?us-ascii?Q?lYWgAPaVB9ftb1dtUVom+fcGEmDm+6pKY/LHPWVOYyvY5BTrP1+JDolk/mjn?=
 =?us-ascii?Q?RipXsLws2ws8h7KnhF6nWf6BSLSLK4FxL3WEB8YQ69d7i9qiYbIS+ck/aZO0?=
 =?us-ascii?Q?Cq+GvSyPf20RXr7UwnS/yvrHwG2ZcB0LFRvmOld/CjyRzi3c3N+W8i5VZ71Q?=
 =?us-ascii?Q?RJZR2Vcjm9fLwn82A0nKEN3gyTBG+dBRki3FnXMvp86ZBij5c2A+ztGf9igA?=
 =?us-ascii?Q?LbKCM1is4d1X1Qk94YCxg9R5HA8M1p9eXp916hNjjnyTdn+71HyZgOm8pgQM?=
 =?us-ascii?Q?i1N6EWpyj68lV8UH7+f+1iRCX0Msof+vDDkm554uRZP2GCQ5T0sKXVpCLqch?=
 =?us-ascii?Q?XMj5MPnLzdC4stColWMEgRDFBToy0esUuMgsJUvOUInpGrifDx13pJHB+M23?=
 =?us-ascii?Q?fpsBLf6p5IEGcgheMp98mG/3F5x1mV0lklxNPOc/Kk9mymcmqI0bzOdRlBQn?=
 =?us-ascii?Q?oVDFN1R+w6xk3Gu2z9RQsgpKXHzCsp1fXgSLw66ABS3bTJKAq/gaYcO5F6ms?=
 =?us-ascii?Q?FPFqMqdpZ+xfdNq2RDdBp6jFBrLw58NbrnVGhMv3FF07KAX+jCCrVgDlenS/?=
 =?us-ascii?Q?2Kf5hXGb8/vO7V+eo2tZ893sGtlygPrkhLVNq/9Qoxc6RZbbOz62KO8V4ARN?=
 =?us-ascii?Q?NtRjphfE/Oi/LHlg7zgXqXJytHQgKO2g9/hOXlgHQUJ2hyzRz1z5VxgzzVqy?=
 =?us-ascii?Q?xjbTMb+ZPahbEWgdPu3FLYuRVsK0JunlHdb9ehjK1YDJe68dVH4+z6C2cWn9?=
 =?us-ascii?Q?5nb7IO6bA5Msz31NskOtBqEESgNRAsa5PJT4Jkp/BnujQ5gZPxudr7JlczE8?=
 =?us-ascii?Q?+2oPvajqdYFFXn98L2ZCAQRIBsFOuMzeorsM0VgQOUjfNjDXsHYwjg5Joibk?=
 =?us-ascii?Q?2WUGEiOwKE9yqzSLsbnoCllSgPOqOhxrpf88/TttdIwv+pzeCR/jv+DqNPKA?=
 =?us-ascii?Q?wih4D6QsGHpSGzir73uMjIjQSEU49IKxv7sGTiIXJKUDTO8bVN6x24tArv64?=
 =?us-ascii?Q?m+FUude8F3Qolgaax/jlxpPfX4e1120twFuUaQwSWwJ6kMOv4vdq5AXBLycC?=
 =?us-ascii?Q?MadxOaK6H0S2ufXVTl3+aZO1SOWsDfNln4JFrEk/gXu/dE1kBnqZYb23H2jR?=
 =?us-ascii?Q?IOo2QE/cFpZ+x9wOR+xyf7GkHbtQ12ytZkX1M7DPpT39Pv7EkFxyX6K2KhMy?=
 =?us-ascii?Q?47KpKEa8OWDq3jhvc/fYKc9gMMg2clAxvwcb681WM6sHLoghZWselCJWQueL?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c67891e-aa76-4c02-c3f2-08dac0cabee8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 14:17:04.6931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08/hojD6iNWNh9YJCn4cnlfUhC1djm5bCptYnJTGzhTx31MbXy2imusvVI6xbDiM7qYbRv5a1mUiuC8nkd4KUIkzyLNlWmZv1VdD+eAafo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_06,2022-11-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070115
X-Proofpoint-ORIG-GUID: 7WucrAPDE4YBrtuqkrgkyMYaDa7q-6ml
X-Proofpoint-GUID: 7WucrAPDE4YBrtuqkrgkyMYaDa7q-6ml
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Shin'ichiro,

> SAT SCSI/ATA Translation specification requires SCSI SYNCHRONIZE CACHE
> (10) and (16) commands both shall be translated to ATA flush command.
> Also, ZBC Zoned Block Commands specification mandates SYNCHRONIZE
> CACHE (16) command support. However, libata translates only
> SYNCHRONIZE CACHE (10). This results in SYNCHRONIZE CACHE (16) command
> failures on SATA drives and then libata translation does not conform
> to ZBC. To avoid the failure, add support for SYNCHRONIZE CACHE (16).

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
