Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E26C4332F
	for <linux-ide@archiver.kernel.org>; Wed,  9 Nov 2022 07:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiKIH6l (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Nov 2022 02:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiKIH6k (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Nov 2022 02:58:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B5813DFB
        for <linux-ide@vger.kernel.org>; Tue,  8 Nov 2022 23:58:38 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A97vAXP030656;
        Wed, 9 Nov 2022 07:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=96QJedUBCYDk53adlyaaCI0mqLEK5n6rfJiaD4j1YL4=;
 b=vmmvyi9vIFSsYBb02tFPxwYYWW3ifu7yvkx5sqqYG32cyhfYHnUUMBMdpwjjByihjUfL
 yUcc9YDwyMUEr1GCIEoso3Q+GSB9ojqQRBfrZk94V995MVl+GGTTcSSbI4unnUDCBnVC
 zYnDw563I+2QtWse+QlvsD5kXDmKqP7pgV6SA1uhz0GQYq0G3e5Cbqw28BN8XUJIZO8m
 Zv/awhvm+2SPH1mKEl1T4RBn+qvUsxyDAN7ibanSc756Y3p2DadcXDJ/+tcMaGXAXnVi
 oLJTAzY+AnykOMiRio4fP1Pf6F80PIkOrrOyvll66ee8ASGx587nh+Tr9M7eX0cZlJbT 4A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kr89300eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 07:58:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A97p586036389;
        Wed, 9 Nov 2022 07:57:36 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcypwm9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 07:57:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZIoMPwZ0u64gPtXlIuGVkF47XvEXANZYLUwBhY//5tNzjM8nP1UbU9tX9iO2AaZyhdcOGSmQKrD5mqQQU8tFhSno5Br0lvS19xjYcINfhWHkdLAsIrbqGxCYPSNxevich1RfrCRuibrUaR2koV7XtgrlgfhH3SziouDsKyOTgovLlGKgoEYfBzK0A0VHpXFDlnYyAe972Tk8SCVyY/Yjn5uVbs/uW1Eh1nntJsVK4C8HJppaLmKdKFpAKPxHEp8/o+nZTPe4DxDhPYk2SpP5cLCoUY+fEmq02/0+4sZ1XmFiQYIoRboiV2mIgFh8qXJk19KHScrQq6Xo0GcMvpXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96QJedUBCYDk53adlyaaCI0mqLEK5n6rfJiaD4j1YL4=;
 b=FVayHirCZ+JCgyqYUWcCd/te8AJ9WWazgyfy9O7gHP5LiqMimOA+wAL1eZSg0L6hrGCfSq3vVXx27XGMR3Ee9sutKz9Fa/Te4G8cME3tRO/uVRMM1I/3Rz6VmkxC8AnyJVrvD3zjAn/GcCuQjpcPV5zmJuHNn3ugu9FLc7A3BQ9ZgiPxR4+UeTWSZvUSLK9ObSuyTaBQjI0ZJ4A+SIyNVD54qChjUJxtf019h8TK2Vd68chvBdNIG/yz784mgaTrYzVK35/yKAxi7Y82kFgRPn1Pnc3BoNf50pQxxYlsyTZjqXJXuPBiI0pZ7zQ3AkDGQxpteviWrjHeLvB+LVpWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96QJedUBCYDk53adlyaaCI0mqLEK5n6rfJiaD4j1YL4=;
 b=qRglFEOoCXQ3HVDAzv/aDPC3vnbNsajtxs0NnpVSN9F1jGq5zNarFuceN6VS2eWfrZud29InQj+GvWzbm9qRWWg40tP6ctmrPjkouP/rjgVdkS0HrvU76xARp7/VATwSr0/Fqbb54K2F5Vn6OflsWumS+s7ztBAuRRXkDeDTKsM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6702.namprd10.prod.outlook.com (2603:10b6:8:132::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Wed, 9 Nov
 2022 07:57:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b%4]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 07:57:35 +0000
Message-ID: <bb443aaa-ebc4-5302-9962-a5bca6143c3a@oracle.com>
Date:   Wed, 9 Nov 2022 07:57:32 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
From:   John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v3] ata: libata-core: do not issue non-internal commands
 once EH is pending
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>, tj@kernel.org,
        hare@suse.de
Cc:     linux-ide@vger.kernel.org, chenxiang66@hisilicon.com
References: <20221108231534.982516-1-niklas.cassel@wdc.com>
 <5b63945b-b12c-480c-3b3d-cea9420d08d4@opensource.wdc.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <5b63945b-b12c-480c-3b3d-cea9420d08d4@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0288.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: be0192ce-ed26-43a6-99dd-08dac2280fef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X1wT1N8v1NeVbzIQWzxL6a7cA2+9ocv/LLIsgpko8M1lX6nxe1sn/P1Gbb+30TQKTsAKRq2RBzgFMoOtQimPR35sZk+cjsoxOdr/Qj+h+RysBB5xK8AZ5L2kGXyCL6GKLhoRV2j88ot9DuUR3bwLJFBNe5lFMPR0kUJCQyEc08WCYVauyMt9YCW9uNTBDjQQWXHIQmt8q6/Qz00FpEFRvJE/Wk15or1NvKQqkUHFYH7UwSO/4iMpVVNHg2Zwj6tcgCfKe1m1as/uVDvfYM90NqPIFl0Smaaljp1wk5rTsSJMdk8l8SiQWbc73QUNqGD2bg+Ky5rTnsABKrMXMbBsrhF9wQIUiaU4xkhdmt95TGwNJPnmFgAQahCYDCSOeMiRAuxn2w3JzvvKdyEGDsmAvDxKvw7vMjGm9G0D1l7z5cTFHjQtf4RoYqUFeDFmxlFFpcYxDxiveuD7AOpy6ue+A4+REHZHcW8EL0VatCgejzDy2dTZkaCvCfxK2VGpjqQGbr6fSVyhSgKfjTBvrNf8vdKVh663lGFWIyMRoYVLC+7zZmsgN49s2OC4+Mc4HcQ844KHmqB+rYdVobEJDkm4yvNb0Cfg6/fj2D3Ip6Q4P7RmArxeLwFJbGh9nngc4vad2HaHe0IOCkxfY5LnUNl9nkF56IYgpRaQOxjICWO8lmrE7alT5LHvB/s14iUzHn9Py/x30CK2E9HMBYZ0fU0xH9zvG11RJiTVB0KHvVcDwEUxlK9E7FMUxpQ9D24nTzKtbwXbivdQegKO5mQJCbJJqTyeXZEUy3V+LI34WSR/eB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(110136005)(41300700001)(5660300002)(2616005)(316002)(66556008)(36756003)(6506007)(36916002)(8936002)(83380400001)(26005)(53546011)(6512007)(186003)(4326008)(8676002)(66946007)(66476007)(2906002)(31686004)(6486002)(478600001)(6666004)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3cvUEZWbjk1VlVTSWZFYk91OUlrc29VRlVrVXY3Z0RFR2NUaVM2eS8xTDF2?=
 =?utf-8?B?N2I0WnQ0OWE1dXJCZk9JREhXbHA5UVdJaEJ6NWpJalRTTnJYL2JqbERCSmor?=
 =?utf-8?B?Z1hYTk1udnhKS045dDRTK2I2M0NIbVF0aXNaQm5ZVlZ6ZkZHM1gwd2FxSkl3?=
 =?utf-8?B?bWh3MElYa1JEVnczRzJzU0kwakpCNW1GQUtDZVhpa0hUUGVMYUlmOGRUTlJk?=
 =?utf-8?B?Qm1IVUU2VGh2R1lYeWlLTUJrK1NzZ2xVQmIxYjI1dGhpeGZ6MGxxTnQ3UXBY?=
 =?utf-8?B?ZGdPZUU0a2JSYVlGV01obXFTbWFCaHFHNFVoMXp4NGRoYjJjTFZqTktXdzNH?=
 =?utf-8?B?NzMvdlZmZ21PUEEvcnJQc3BaQzkzRXh0Ti80SVprdWM5L3VTU2RqZUgwRkhG?=
 =?utf-8?B?U0FuS3ZxZW1hbTV1UnFzRFZXVG1KTnc5aFRFM0JDWEtlc3E2OXoxK3hpRnlT?=
 =?utf-8?B?TVFabXpLWld1dzRsOFVEZVVlbFRubUVGcUF2clgyakZ3Z25KeWNITVRubzlM?=
 =?utf-8?B?T1FMUWFTay9pOEdpQTRoVXZOOHZtSm5EYW83S0IyYWpyTW9RQ0xRR1h4Vi9t?=
 =?utf-8?B?TDVnOFJ5OVdzS0oyY1dRUkFzbHdoblV3US9pUmg3OHFOOC9tUHJmVy9iWEl1?=
 =?utf-8?B?UTlUVE1QVGF4Z21Pd0JqZHZrcGdZRjZFR2dxdWhOZ2wxRDhJaFlxcnNZSGxi?=
 =?utf-8?B?NnVNd2o4QzB1Z3RsTXBUQVpWMnpodWFPRnhBQWlycDg0VjFub2Nma3B3QW1W?=
 =?utf-8?B?QW0zNHR0TjNHeWNUMFZ2RU14ZWduaWJ0T3V4S1JGV2wwNlNReUd6eDNDRTd3?=
 =?utf-8?B?ZDk4eU00enZYRUVxWnV1VVBuS3ZJanBuQlRoNU1Ld1dudlI2bHNXNUVhQ29Z?=
 =?utf-8?B?V3ZRKzczMUpWcUVsU2YvZ1dpL0VKWmxwQ1VlNnpWSzdtRG9NTWEwclVSSHJi?=
 =?utf-8?B?T1l0Z2tTWFhCVU1DTkVzY2RqYWZtNktBTkFKR2toVWphOGVxQnRIVmFKWllZ?=
 =?utf-8?B?ZUowU0tKc09VNlBUUHNZK05UWCtDeFhCRVdOZmU4ckRMZUJ1MkJuZnBXVDJl?=
 =?utf-8?B?NStpZ1dNU3QycGZRR2tQSGxEVFZiU3dLTnhQVVFmRjhkMWZ6eTJXRkxvQjRQ?=
 =?utf-8?B?RmFtRHhEMnFPRWZ1U2RxYTQ4ZGRZaHZCbWFldUxpMEpqS3JLNDdZOEJWMFVz?=
 =?utf-8?B?cnFmeVAwWjE4VWEySEZKenFqM0RxM2k4ZHhLVnpnOGFPOWpSWWo3YUI3TUYr?=
 =?utf-8?B?MmNSM2t1eXNFZ2Y3KzJpd3FkVFpuNllENEFoTURhY015WmgzQ2xwZng2TnFi?=
 =?utf-8?B?WG01WmpuTkVOZWU1SCtpNE9yLzFEaEFGZWlDZU5pSGE0L21LZDlhc1RnVGwx?=
 =?utf-8?B?RTdMVEhZcG8rOFRlSjZJSW1DZjMyMExSKzNHaDRlU2JUVHFRT1pFL0RXQ2J4?=
 =?utf-8?B?ZUYwVWY4eDZoeHAzcmp5cGxla2E1OXBJL3lubUwzTFlsQ2pxMmtGdTkvR3Ry?=
 =?utf-8?B?Zk5yblBHem5nZ2x0Vkw1cHFZY0QxSVkxYUY1RVBxa3BNTUNkbkNGSUd4dVVR?=
 =?utf-8?B?N21FS0MyRi9PUS9sajdDZHc2SExFK0xCWnA1L1JCTW1iYUUrNU51K3p2TWRk?=
 =?utf-8?B?eks1L1J0Y0hCbUN3Zk01T2lheG9kL2VBOVNXd1lHcUNheDJNYjYvMTRqNnYy?=
 =?utf-8?B?K0pBdjVROEUzMnpyaTlFcWZ3TmNndVdWSnZZK3Y1ZDRSMjM3L2FPYnlDb3FX?=
 =?utf-8?B?L1hXdnl1SmFSUTRCaFh4YXI4SWZPb1g5RkgzYmptM04wam5SQ3hxRW5pM3Zh?=
 =?utf-8?B?TWJiVUhyMVlUNkx2a2FlOXVuNGcrdEt1K2dhcXpQbmY2Z3U2VzBUT3J4Y1ZJ?=
 =?utf-8?B?U0FCc05QbUc4cTJDVFFjQW5naERJSWJrSkNRZE9sLzNnVS9DbkU4VUVsMUVl?=
 =?utf-8?B?bEZjNzEvM1NUc3NIUmtNYXRhU1dNS2VWSFhTclhFcTVaK2owcStnN3hsK0M3?=
 =?utf-8?B?Q1N4NE9PeHBNL2J3bnFPZ2NyL0Evc1dFS0g2RUhxNWp4cUpPc3BXeHlPeGNH?=
 =?utf-8?B?S2hOeFVnT0NGMUtXTmNKUEdRU0k1V3ZlZnZTZndWSlVoL0xIbm1lUkM3bVR1?=
 =?utf-8?B?WXVqSjdvV0NESG9nZTBTVWltYmR1ZEZjZ3IydWQ4ekQ2RWxxVWxLaDFta1hp?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0192ce-ed26-43a6-99dd-08dac2280fef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 07:57:34.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/YN4Kku2LECaOk6iNoEMeqJnghcYmt0oG4/CYdCazkvLXeOdSvHxyGLkI78S0X7OeQFfEsm5A4qRvKddsH8pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6702
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_03,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090061
X-Proofpoint-ORIG-GUID: qv74DdMOJSb1lpZvQzZCjfHhlbi34FrF
X-Proofpoint-GUID: qv74DdMOJSb1lpZvQzZCjfHhlbi34FrF
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 09/11/2022 05:15, Damien Le Moal wrote:

+

> On 11/9/22 08:15, Niklas Cassel wrote:
>> While the ATA specification states that a device should return command
>> aborted for all commands queued after the device has entered error state,
>> since ATA only keeps the sense data for the latest command (in non-NCQ
>> case), we really don't want to send block layer commands to the device
>> after it has entered error state. (Only ATA EH commands should be sent,
>> to read the sense data etc.)
>>
>> Currently, scsi_queue_rq() will check if scsi_host_in_recovery()
>> (state is SHOST_RECOVERY), and if so, it will _not_ issue a command via:
>> scsi_dispatch_cmd() -> host->hostt->queuecommand() (ata_scsi_queuecmd())
>> -> __ata_scsi_queuecmd() -> ata_scsi_translate() -> ata_qc_issue()
>>
>> Before commit e494f6a72839 ("[SCSI] improved eh timeout handler"),
>> when receiving a TFES error IRQ, the call chain looked like this:
>> ahci_error_intr() -> ata_port_abort() -> ata_do_link_abort() ->
>> ata_qc_complete() -> ata_qc_schedule_eh() -> blk_abort_request() ->
>> blk_rq_timed_out() -> q->rq_timed_out_fn() (scsi_times_out()) ->
>> scsi_eh_scmd_add() -> scsi_host_set_state(shost, SHOST_RECOVERY)
>>
>> Which meant that as soon as an error IRQ was serviced, SHOST_RECOVERY
>> would be set.
>>
>> However, after commit e494f6a72839 ("[SCSI] improved eh timeout handler"),
>> scsi_times_out() will instead call scsi_abort_command() which will queue
>> delayed work, and the worker function scmd_eh_abort_handler() will call
>> scsi_eh_scmd_add(), which calls scsi_host_set_state(shost, SHOST_RECOVERY).
>>
>> So now, after the TFES error IRQ has been serviced, we need to wait for
>> the SCSI workqueue to run its work before SHOST_RECOVERY gets set.
>>
>> It is worth noting that, even before commit e494f6a72839 ("[SCSI] improved
>> eh timeout handler"), we could receive an error IRQ from the time when
>> scsi_queue_rq() checks scsi_host_in_recovery(), to the time when
>> ata_scsi_queuecmd() is actually called.
>>
>> In order to handle both the delayed setting of SHOST_RECOVERY and the
>> window where we can receive an error IRQ, add a check against
>> ATA_PFLAG_EH_PENDING (which gets set when servicing the error IRQ),
>> inside ata_scsi_queuecmd() itself, while holding the ap->lock.
>> (Since the ap->lock is held while servicing IRQs.)
>>
>> Fixes: e494f6a72839 ("[SCSI] improved eh timeout handler")
>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>> ---
>> Changes since v2:
>> -Improve commit message and the comment inside the code.
>> -Move the check to __ata_scsi_queuecmd().
>>
>>   drivers/ata/libata-scsi.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 4cb914103382..93ebcdf2e354 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -3978,9 +3978,19 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
>>   
>>   int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
>>   {
>> +	struct ata_port *ap = dev->link->ap;
>>   	u8 scsi_op = scmd->cmnd[0];
>>   	ata_xlat_func_t xlat_func;
>>   
>> +	/*
>> +	 * scsi_queue_rq() will defer commands if scsi_host_in_recovery().
>> +	 * However, this check is done without holding the ap->lock (a libata
>> +	 * specific lock), so we can have received an error irq since then,
>> +	 * therefore we must check if EH is pending, while holding ap->lock.
>> +	 */
>> +	if (ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS))
>> +		return SCSI_MLQUEUE_DEVICE_BUSY;
>> +
> 
> I prefer this to the scsi recovery state approach.
> 
> John,
> 
> Can you test this with libsas ?

I have no HW access currently, sorry. Maybe Xiang Chen, cc'ed, can assist.

Thanks,
John

> 
> 
>>   	if (unlikely(!scmd->cmd_len))
>>   		goto bad_cdb_len;
>>   
> 

