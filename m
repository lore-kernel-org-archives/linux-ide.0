Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF63C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  6 Oct 2021 07:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B21206113A
	for <linux-ide@archiver.kernel.org>; Wed,  6 Oct 2021 07:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbhJFHgn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 6 Oct 2021 03:36:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43992 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231221AbhJFHgl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Oct 2021 03:36:41 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1967LIXR014741;
        Wed, 6 Oct 2021 07:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=fb1qfU7616c/kbd4r5kCxdPvv0QrlvwsQ9UdiycHjEI=;
 b=Cde3TLPIxvgRu2pipLcIsmUd1s0T6ZDI2chJhs1Ke2O32SOchi8zMiHbevGJQsrbaHSC
 zQp1887YkaoUpvnttn8XDe4JwnJvce5t2e45Qw9dLTM/HvCXWIWXjYCOadMV6PxiRdqN
 OtTtxnryZbpIsG7TUEUAbAalN0Tmk95I80hmpvNM3Ny6oYqAjA0ZP8KZXBohBBf93En3
 yM/NMzSPG1lz/PCQGjkqseg0/QTVw9JnH7p2aqBorSGTCszisvYax0WQdEP4qFXEBnbE
 S3rYknakJQF1wQLij9V08YKRcnzmgBRlM7FqVmZTRj5Z/6KPdrnCpTYfeRuIGrI0kxlK Vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bh3y590fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 07:34:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1967Q1tm157564;
        Wed, 6 Oct 2021 07:34:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3030.oracle.com with ESMTP id 3bev7ueq42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 07:34:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6YdOeBMXBGEECwdhHf9cnVwnYG4S6it1pwexv2GHZHl1xrg19Y2FZnn2J/f42EIxB40ZgRByQST+rf+drv5DhAWJ1A4rRy+VSE+t1BtZk/xhH9RefAcIcu/wteGtF+OhErGLv5QFnf4H+3Fuz6bKSHv51A4ChWQELIy9h8Y7ZnApxdzlhKKiZq6tcGcRmoOHFhW9iw63O67aKr2VfLS5bxGOVD4vhRrrRqo22imnZlnNsHhUP1k9md9Y9vCK0YXwVcV8pED1QCnwIbpffsHljZj/E4ZFe7Rri3A4wHZ3M5RtzOBHWUNXCZ95IBUqpm4Fw9PKySpcm2RzoZ3KmDHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fb1qfU7616c/kbd4r5kCxdPvv0QrlvwsQ9UdiycHjEI=;
 b=WrnQ1UUzB5yNEpgbPWVx8txBW4RFCXRa06KW/4S1Gntc9y5vaNfWVICQ4KHH9v9/6lwaWzDg/fOmZPO/IIE5JlMqfRhXZNv7ngzBpPIXEJtlF/0yJgegF6kzHwoCtztjXiD4S3STEf2vCTX0exofwkNXUltjiEZaK40LxT9Jvoeib2iEJ6qT91PCfln3B/mVTFOy+C6nEW4ewv0ppo4h6Fdg7MfYQUw3Rd9dARE6hC0Bu78toZb3dpZVq6Me/5fiy/N8NZ9DISIjSWpAbD3zhq1nNCGq3ldFmi7RO9jLddbXO7w0LgBcklPFMUpAjb2ijQujAkc1Ur97b9G67JX7Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb1qfU7616c/kbd4r5kCxdPvv0QrlvwsQ9UdiycHjEI=;
 b=vz90Ij+CP096c2eK8HEoApOOhMFPWCCuS8wXZ6EJ9PAx269HK2RYF/YZgMG1o89t+J6ELkbzojCFLJI2Rxj8x9oN7LrotT6IeE+HSkxZeQZBCE7it2/2vTZ40v9izL07D+BQspI3JOy6btZLBlv/jb9oJMmCwkA0gM7CUn4ZLWk=
Authentication-Results: opensource.wdc.com; dkim=none (message not signed)
 header.d=none;opensource.wdc.com; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4546.namprd10.prod.outlook.com
 (2603:10b6:303:6e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Wed, 6 Oct
 2021 07:34:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 07:34:30 +0000
Date:   Wed, 6 Oct 2021 10:34:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] pata_legacy: fix a couple uninitialized variable bugs
Message-ID: <20211006073419.GC8404@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0036.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Wed, 6 Oct 2021 07:34:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 344dffc9-14b8-418c-ce61-08d9889bbbb1
X-MS-TrafficTypeDiagnostic: CO1PR10MB4546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4546179DAB296EF699FBA1268EB09@CO1PR10MB4546.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k6cYbgDwOCKiniuNstQIqcn0a9Z85itm8FsDIL8frZ6RuTJsT+unanTQcfyrmRNG1E5r7aXP1CEHJze7wj6rcFDSboL4yjfQZkrk4Ux+thzOsnOYPk3amqjwGIfQyjlCiIquDn0MkhqLfgkmu1JsBEKb8tlCzkD1jndWUTO7NDPPBAkqmTKZ6y09V8Z1Cdr5luXNoNF0FCYUJBNmd8GAobQUDKNhFx1LbhVWjBLgcOndl2OH7Cy9SstviNrCgceKwcjSc+KsurK4TvL5dXDIL2JPFBxk85/iveC3BZMKY7dkJfRk8ldjmBVPMOBg1G6uDqKjx1ssTz0Mo3Ia1crj63n6Q8a/r7ZmS91CPCUX7eb6UpgHaJqMwJpxMfCkqZu8AK2QDMmad12QTLHpTp7Qgr0ponXrc1LU1ZwXPlzqDOcQGsHr321MZpozM84fAvXREOZ9a/ObAAUVASOpuw4xIaaFrf9JScWUQ0Aj6oKebuXHdTuo1Hkw0tLxhACsR8DeQ3MufTIQExCZFYRIor3eSrK0aQNGe38oU+O96KIyOkShagoPWTlkFSJ29N2Deg7SnsjPDcCz5r4LFDA7JrHQMZ7mdh//P8fbILopmSAOZQoA5fd2tN/4GEzq6NRaVT+ATxR1QKvUiNLKaE5EPU8l9xhdcqEasPDbp9hZrNvfGR624hFGOvZ2ZCQhRgdzsES/BN66DKkP6p5bgmccsYWb+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(86362001)(6916009)(33716001)(1076003)(26005)(508600001)(6666004)(44832011)(956004)(4326008)(186003)(2906002)(38350700002)(52116002)(9686003)(6496006)(66946007)(66476007)(66556008)(8676002)(316002)(8936002)(38100700002)(33656002)(55016002)(9576002)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yxiwkS/bIEEYuyd53NswA3DC7OKMzWrvaLKzOFLjzFMiygMeY5kfF2lLqf2a?=
 =?us-ascii?Q?tTY6h/Jytkdy6L4HNJVg9lXjwz4Uj3BUY53RP9g8rnVTo+hZVzG4/g4KIKpN?=
 =?us-ascii?Q?xNS4hx4BWhTRME3oZJv5toMK0fpCHk940351dvB/DTSoWXAa7iv6J8/PKgqg?=
 =?us-ascii?Q?PYyAO5+rTEwWNQboNzLO5GuIMWfFxl3Vuw+6Yk1KXU4Zmo5cMThMGMHiAHpJ?=
 =?us-ascii?Q?tHn/wiq0VFXz8FoAtwQQl+XINxdil2MpWSrCJl6Pd8gwZjEe9rlHktX4qxyv?=
 =?us-ascii?Q?PJlAwWLEXgZ5jhr6nupSgFkUDOk/nvpwzFU7aNvlmoy49VDMgERRfeILRgte?=
 =?us-ascii?Q?5vsEZXoMScAq0ryQWMhUjx15k8TcVx+2HthhfG+POEP3DPlQjnBQM45hKSaT?=
 =?us-ascii?Q?lrOfE/c42wOsuzihD0FNcZ8Vy7HlUFN32u74cpa7D3EpFj8t/NmZCK4tM0an?=
 =?us-ascii?Q?ZjJ2RI18jDzyTIkfpQGNH6TpzVWF4Ru+Ug7L6R9K/zBZaERJY/pL+kmXPcjC?=
 =?us-ascii?Q?m6pSwX8yryJyH3An9e2+rkbUgf3vi5TUezK08mD/PcM+RQ6oK1zw3hqY24r8?=
 =?us-ascii?Q?IS1ikUhgJgDRUvTQwaWjZJWqB5XwK2D2wQ+ocOZNCXoGDsHI0VoHbyJN669l?=
 =?us-ascii?Q?tdHkN/OCd5RHwg0nbh2dC/MJta2dCW7iY8jF6L3SIaJp1xSq8SjSmK2kYPMV?=
 =?us-ascii?Q?PfoGTfEgjTDrFZaKNPhMYw62GvbyvRw/WO0Cu6VjLJDMh+LiFpfzB4S8Mqyo?=
 =?us-ascii?Q?jn+T9xur+GfD/RA930rd9FCEvT8YPXhlVJ/KFNY1NKOUF9Z0C6mlmSVk5ZaS?=
 =?us-ascii?Q?xa1fDlLUZVEQsxIordWx1M6caebHG3JAraFSfwxb/GSSejcWEGl/dB8h1NUY?=
 =?us-ascii?Q?hvLUCh6UaxTdt67xMLE98mRg3rpn2KoVEG3WZs2ss0aPpNPBPjvHjMEyozEK?=
 =?us-ascii?Q?5hlAG1lnnVAB/wTHE3a/5Lt5ORzYXRHlwLIowHX4f6MPqvMwh46xjWvyJehr?=
 =?us-ascii?Q?iqWTkK5qcgMQMMpEQUvi9DKE75vjoDrg5zsTIYkgvFQdmpbJgrrZuD1wBIIw?=
 =?us-ascii?Q?94sbRp3PwtfkVU8lnsXslr80B2ESFFvdsZoHh6lDPaCVAzSbxnEcJxnc9jHj?=
 =?us-ascii?Q?A6038PuQH0DBss2nAkDKAp08vVoO9iNbwkj4MVOqDyBNkutelLZKi62VdEVj?=
 =?us-ascii?Q?REQKbCJWZelJ+a8Iy3VSSfzIA4xO6w1iGSPzKulRC2a0dVPk4lZNLDrTnWyj?=
 =?us-ascii?Q?2voJQIw09FspoTW55GuXFJ8SC57gPY9SAEJm0jH3LxWa7Ksqib0uT6C5w4e7?=
 =?us-ascii?Q?o5+hRyrpO+0fIXYiqSddTyGE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344dffc9-14b8-418c-ce61-08d9889bbbb1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 07:34:30.1125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1/trz84SgM3aHiC39520dDe6GHJiDSC0nnBGj3kTlAnmj5YhD15NrTLoggA6uwyBciks16XkWj8vYTpCvbfmgFBQRtZv/kI3pjyfU9A9/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4546
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110060046
X-Proofpoint-GUID: kXJ87ITGLgbrRGfM5RAk-qxCTtXg0Ap9
X-Proofpoint-ORIG-GUID: kXJ87ITGLgbrRGfM5RAk-qxCTtXg0Ap9
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The last byte of "pad" is used without being initialized.

Fixes: 55dba3120fbc ("libata: update ->data_xfer hook for ATAPI")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/ata/pata_legacy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index c3e6592712c4..b53f0e09783d 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -352,7 +352,7 @@ static unsigned int pdc_data_xfer_vlb(struct ata_queued_cmd *qc,
 			iowrite32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
 
 		if (unlikely(slop)) {
-			__le32 pad;
+			__le32 pad = 0;
 			if (rw == READ) {
 				pad = cpu_to_le32(ioread32(ap->ioaddr.data_addr));
 				memcpy(buf + buflen - slop, &pad, slop);
@@ -742,7 +742,7 @@ static unsigned int vlb32_data_xfer(struct ata_queued_cmd *qc,
 			ioread32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
 
 		if (unlikely(slop)) {
-			__le32 pad;
+			__le32 pad = 0;
 			if (rw == WRITE) {
 				memcpy(&pad, buf + buflen - slop, slop);
 				iowrite32(le32_to_cpu(pad), ap->ioaddr.data_addr);
-- 
2.20.1

