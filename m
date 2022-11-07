Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDA2C433FE
	for <linux-ide@archiver.kernel.org>; Mon,  7 Nov 2022 17:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiKGRCL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Nov 2022 12:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiKGRCJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Nov 2022 12:02:09 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A901122B0A
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 09:02:08 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7GTJpY026660;
        Mon, 7 Nov 2022 17:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=meh62S61kX/Bo6fkxTv+4TWIlA18w/xT8rcG0NPEXOo=;
 b=zPQw9pIB+Wn3ICoy4HEleHV5YqVLcIXm3sgnyf21yyG4aNRGrRzP5Pkb97B4kLo10gLZ
 F7tk2p1EX5lcnapT86Rd14JN70VzRtMP5MbcGt/qf7rKc/ivztDDHr0Z6VZa8lh7JlIC
 9URfMvSnCacZIwe0qCgIK0+ZlDfRUWFg8awyeNsfXQdtw2DhYdkYprQpnsfFLDxPtKlB
 49s+ubtrr5BgWo5fPqI+6sKsCZReO5U0lb2oAhvnMsZJ1kqpdOncXnZK4eN9f1JkqQbv
 jTsf2Xp3Uh/G89/awfINrT0VOVPi4WawGCNpkdjvdTxaREXwJlhwzVCU04KibkFCDcwK eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngkfvnq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 17:02:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7GboPb025649;
        Mon, 7 Nov 2022 17:02:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqf1a6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 17:01:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ja49mMjzBUoV5p3jo2qydzw+F3gersJ/h5UsR7Tu6vtS9ytOLvn+e8Ist4EUDIhhtqrCotxIX5kgEoFYmDODrWsamvPnp+MhSCQt60V8zoVxSDnBjKtV8rFIznH0necQzUNmZosPPRaOxvLTdX4U3Sqx8BoHN2gPbIsH+kON2aFXBlQ1bghJBodBA9MYMkOd1kwl1bj9yUYh+n2P2wwZHK2uEjrx+KFtx17tBy8m0EO87TelqiOkIK84e5n8QBS8LmQjZEOTm0/EZ1q3TflhjOsWO2+jbTKSfH6Rth2zaPTXukPKmdr873BW3OiwKHrDv/RLeRz+yHoQTcdBS4t0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meh62S61kX/Bo6fkxTv+4TWIlA18w/xT8rcG0NPEXOo=;
 b=CSmKxLuLA/EJ4RHQR1aqzyvvAnQRGVLR0u9YIu1lLFXIn2JiVH09Pt4HYotewTQlKvkloLs7fuiGITCb0xASU+KySNZrq1F6hK6NYhn8tLNFjOd2xtpXQ3q11ytP5ptbt9JBtYxM98S1kqPuO2MTiVp/KjgxEaqFF1mVnoRCVs+MLHazY0uY5SqOf9+smxBNGw927lNK3XeQKa/OCGPo1a4fBW7c6WblGmw/na70mDLcy6poDlzWQg27u2BhYaA+ONN+8L4NYolHK9jQYl/e8Xugl6oLYEgosBd4FX5NdS6oH6ELs+8/fJqSHqnrNl9gadGCdxYZaqfPw4LzD+PbEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meh62S61kX/Bo6fkxTv+4TWIlA18w/xT8rcG0NPEXOo=;
 b=T92E6wIjmAGsn77MLCiMQVIiDpBXtBbvhayrb229A2EyFXdxpmj4smfbyH7JBGskPxL6Tc2NI6yRL21ESO3dVrrR68PGUerodxhMce/9OGnrBE8D0vocbMXvxKQ0h5SZBaP/SGYS9TxezppWB1yVanxBXrIoQ3qq0m8j2d/5T7U=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH2PR10MB4262.namprd10.prod.outlook.com (2603:10b6:610:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Mon, 7 Nov
 2022 17:01:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 17:01:56 +0000
Message-ID: <5a4fa5db-c706-5cf2-1145-bf091445d20e@oracle.com>
Date:   Mon, 7 Nov 2022 17:01:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] ata: libata-core: do not issue non-internal commands
 once EH is pending
Content-Language: en-US
To:     Niklas Cassel <niklas.cassel@wdc.com>,
        damien.lemoal@opensource.wdc.com, tj@kernel.org, hare@suse.de
Cc:     linux-ide@vger.kernel.org
References: <20221107161036.670237-1-niklas.cassel@wdc.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20221107161036.670237-1-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0460.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH2PR10MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0e1c2f-6d79-499c-477a-08dac0e1c722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: msqUAZewHQJ+gPbriF/mJ9CMfrRufSzVE00qt24yRrfkas9yoC0L1ucE69wKMl/Qq5ON8ImxP6pN9UyKf8vSPgABWVrRfb4FcpW7tc8QSBGcIqiu+2Ws2NLGgZW1BNUgzhCWRfWX4k3Psh0M28oVd6LKM2yUh/FG7u91XbJ13ehGES2gRLrJfy+PF12T7izyf1+WBbPq7YZtT7wXp6rHsCO7xsuKlvWrAPR2vywooQ1IGu6MhspHDinD1Wpvt4pYbe7h1M8hrWzOOokO+Uw8Zdt9DzVx4DuK9jRmYygxKVbEAP+ZEEYrUzidoRmGqfoJAzBkoUh12dBb6pSbPIqL2QKRGhMM3imakDOaR7OcC05c11J9n8ZebL3MioX1ebYFjZaHYY2/5iFqh/T1DapintC5Yz6VP9F7CWNTS80w0ZBDe7QnB/Rmbi0tfDulZ/Xk6QkK1t/RiXkBCHvc4Oc4MCRctDXN9ijMZ0zy6Mv1SHJpPJcCJNrFt54QMgfBzz8w+1U+isqUpSXn92hiUmGMxcvYCN0Gnmt/gLbXSTtj6wjQ3MNG1aE4VTijJYui2rn7Jc8rXBcAXuHBa94Z1O8XH9ez49rxWRLxI2VLbKicnBH5x3IVz2L09pscpOYbGAIxehpOnkjyzXFAmLLHKxtjzijrRgl+RwKeleAkkGqmKtBBtzAluWsNyKshym52OWLwmnj2dyQpUWpaG2LWgS7R6JqiQZ7qU6uaaJ8vc2ldupdhlSDKyU60BR6C03CqvUae9hZR/DlhgRNVL4QNZUxvdbEZ/Lbda5wavlFLLCAyp5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199015)(41300700001)(83380400001)(8936002)(316002)(186003)(8676002)(36756003)(2616005)(66476007)(66556008)(66946007)(38100700002)(2906002)(5660300002)(4326008)(86362001)(31696002)(31686004)(6666004)(53546011)(36916002)(6506007)(478600001)(6486002)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEppeFpsaEZoeG5QRVk0UkJiQWZSLzFhcHRlNWlieU8xdm5LU25xTWt0amNa?=
 =?utf-8?B?QmdEZEVsQzlKTGYwSFpSUDhwMjQ2TVY4bzZXNC91QmRuTU9ocWFLY01SakN1?=
 =?utf-8?B?eU9KWlJMVDJXQ254TnBLUnBYV2JjeXJxdldMSXNDelgyQ0ZUWkNrYXk0TTIx?=
 =?utf-8?B?UWxsWmxHb25VSTNMMGJISjRsQW5NdU5WODNvbnRmdWZtcmluYWRyKy8zSUpL?=
 =?utf-8?B?YVZUOHBobDNBWGQ3UzdRYW9BYWg4Y3BsSFMxRWZURmNSMGtaaVV1UTNpaTY2?=
 =?utf-8?B?SGkyS0UwaFhJLzVIWkI0LzNDb3pZeUNsdDA2S1dVcDlDbHgyOW5JelI1ZTJD?=
 =?utf-8?B?STR0WmM2UzZiVFh6R1czQ1lWVHhjUTREYnVxT2NFVDV5UHM3azIvY25PekJD?=
 =?utf-8?B?VEFrWXNTNndyZWE4WjFqbk1iSlh1ZzhscHRFZTl1V2RadGtYUHJLUzJreWlR?=
 =?utf-8?B?RkwzYWZ2MmlheEtrWHF1WXd4RExoTlZjQUNrTEJkTGRNMmg2bmZwcFQ2WjNF?=
 =?utf-8?B?TVJYSml0OXJqSEFNZjFkcndzbytoL3ZaOCtkVStOQTRjaTVRN1pHV2gzL2JG?=
 =?utf-8?B?SlNWc09hMUl4c052dndFNSt1bEdlc1R2OFNacERiWjh5Q3pkd3pvVXhxUzh6?=
 =?utf-8?B?UkhLMldNaHlBTDgzZWVMbW9PYmcydW9qQjVvdDNhWm4zTVdCTC9NU3JSbmg1?=
 =?utf-8?B?anhrMXFycTlCUDdhM2pWamJWVCs0R1RHVWpmQnNVUHJ6UHJ6OFZLLzYzOUh0?=
 =?utf-8?B?ZlZLTnljcFl2SmxLSnJMZGVzdVlLdWwxd2Zrd1F1V3dPK3dLWnRMV1lsbitC?=
 =?utf-8?B?Y21FNTR3WGJsUUI3dlNYVlpqcXFBeTdrOTR1SFplTXJ1TUhFQWl1Si9pZklM?=
 =?utf-8?B?MlpPMndBRlZjRTJXRHFjcFZ5MjNZT1lCTkRNOXZWNUw3YnUzakVQS201SnJQ?=
 =?utf-8?B?bzREZ05mb0JpNDkvQWJiWjBGWDRieWZRQ0JkeW01L1luNDJtU3M2Y2piYUVv?=
 =?utf-8?B?SS9HOVNEZVJLT0F3Ui80MXR4ekVncnJsaHcxaEE2WExtS0V4dzVtNEV1YXla?=
 =?utf-8?B?RHYyd3drVjFCQlBmRDBQaytPRHdZdnN0enpUNjhrQmNvRUNqNmhOVVZ3VHJv?=
 =?utf-8?B?eHV6THQrLzhDVTYvRTJWWHFGTS9EbjYxcmRYc1RWN25ZcjRtc2V6L09XYy9k?=
 =?utf-8?B?VmFGMC9jK1RhMi9EdmlwUXVuSWNzRVFHSHQrV2hQaEJGR0xYSFlnYUd0YStR?=
 =?utf-8?B?VGRHK29xT3lxc3cwczVLSWlpQVUxZHRucjZBcEtMeTVmSm82WXlmVDVYMjVy?=
 =?utf-8?B?alQ4b25yZ2tTemJuenFFTVl1dm9QUGhia0xSblRpaXVlMk1XMEhnZk80Z2Jk?=
 =?utf-8?B?bHZoMTdFdnhmUk9DOXpIZElMVHljby83NTV6UE8wa0dwVDdTajZ0bDdaQk9l?=
 =?utf-8?B?ME5rUCs0M3M2L05OZkVGdXB3cmhnSFdTUjdmSitDRXRxblBvcG1WVlpXajlv?=
 =?utf-8?B?VStvT0xNaWZZYThVTEpRd1d5R3BaTVlnSkI2L2JOMXVTOXdjcGtBVERsTGwx?=
 =?utf-8?B?WDlRdTYvMHVRaER4MzdXdVVkSWFYNWQvVkhWQzd4YWl6dzNQK2RYTGRiK2JX?=
 =?utf-8?B?dUsvckFCa09mNDkvcVBlM3d4allONkZLZnZJeUcwQWhySHN5c3dnMFlwc0Y4?=
 =?utf-8?B?UGE4YXhOMjlEOTBtSEJrYUp0WEZiT2VabEdZY1NHVmZRd1prUGxFeThDOU80?=
 =?utf-8?B?V1I0dElWTHZ0aWMxMFI4TFE1NFh2NlhuN3NpN0I0UXJicHc5RHJ5L2wxcTBM?=
 =?utf-8?B?dzlNR0pab1UyWnYxa05janAyK0txR2pGQTVaaVh0N0d2RUJYMHhDZ1lKdHFp?=
 =?utf-8?B?eHc3a0t6ekFUOFZqSGx6azYyMDU3TTNqbDFvTTd1dlQrZHhMRDV6M1diZk9k?=
 =?utf-8?B?V2VxR0FuK0wwYU1OUXhvUW9QL0xkeHFQNGVQYlNDd25SdzlZOEJLZ2Y3Yldm?=
 =?utf-8?B?ZUt2Tm5MMWViWDE4MFQ3Rm1zY2ZTOVR2MXNxK0R5Z2M1dWNRQmhMamZJcFZB?=
 =?utf-8?B?K1ZYTlByR3RwNTJpRk5nRjFIb1FUdjRLUHBQNUszQ0MzYS91em5FV25SOTdV?=
 =?utf-8?Q?0//RmxNyZ/O3WqcKD/2OxWh8n?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0e1c2f-6d79-499c-477a-08dac0e1c722
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 17:01:56.9152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XC5IJ5+2w1CCtsrFWaGp7czYTEjc9WWuSJqOIbucoHNfuy/CfmBo2pNiOH0R6XLSehGktwubXMYndgf2uKrAcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4262
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_08,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070136
X-Proofpoint-ORIG-GUID: anpB87CS6yld1I7JciE1W62eC7MXBUW9
X-Proofpoint-GUID: anpB87CS6yld1I7JciE1W62eC7MXBUW9
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 07/11/2022 16:10, Niklas Cassel wrote:
> scsi_queue_rq() will check if scsi_host_in_recovery() (state is
> SHOST_RECOVERY), and if so, it will _not_ issue a command via:
> scsi_dispatch_cmd() -> host->hostt->queuecommand() (ata_scsi_queuecmd())
> -> __ata_scsi_queuecmd() -> ata_scsi_translate() -> ata_qc_issue()
> 
> Before commit e494f6a72839 ("[SCSI] improved eh timeout handler"),
> when receiving a TFES error IRQ, this was the call chain:
> ahci_error_intr() -> ata_port_abort() -> ata_do_link_abort() ->
> ata_qc_complete() -> ata_qc_schedule_eh() -> blk_abort_request() ->
> blk_rq_timed_out() -> q->rq_timed_out_fn() (scsi_times_out()) ->
> scsi_eh_scmd_add() -> scsi_host_set_state(shost, SHOST_RECOVERY)
> 
> Which meant that as soon as the error IRQ was serviced, no additional
> commands sent from the block layer (scsi_queue_rq()) would be sent down
> to the device. (ATA internal commands originating for ATA EH could of
> course still be sent.)
> 
> However, after commit e494f6a72839 ("[SCSI] improved eh timeout handler"),
> scsi_times_out() would instead result in a call to scsi_abort_command() ->
> queue_delayed_work(). work function: scmd_eh_abort_handler() would call
> scsi_eh_scmd_add(), which calls scsi_host_set_state(shost, SHOST_RECOVERY).
> 
> (It was possible to get the old behavior if host->hostt->no_async_abort
> was set, but libata never used it, and this option was completely removed
> in commit a06586325f37 ("scsi: make asynchronous aborts mandatory"))
> 
> Additionally, later in commit 358f70da49d7 ("blk-mq: make
> blk_abort_request() trigger timeout path"), blk_abort_request() was changed
> to also call the abort callback asynchronously.
> 
> So now, after the TFES error irq has been serviced, we need to wait for
> two different workqueues to run their work, before the SHOST_RECOVERY
> state gets set.
> 
> While the ATA specification states that a device should return command
> aborted for all commands queued after the device has entered error state,
> since ATA only keeps the sense data for the latest command (in non-NCQ
> case), we really don't want to send block layer commands to the device
> after it has entered error state. (Only ATA EH commands should be sent,
> to read the sense data etc.)
> 
> While we could just call scsi_host_set_state(shost, SHOST_RECOVERY) from
> ata_qc_schedule_eh() directly, that might be a layering violation.
> So instead of doing that, add an additional check against the libata's own
> EH flag(s) before calling the qc_defer callback.
> 
> Fixes: e494f6a72839 ("[SCSI] improved eh timeout handler")
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
> Changes since v1:
> -Implemented review comments from Damien.
> 
>   drivers/ata/libata-scsi.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 4cb914103382..383a208f5f99 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1736,6 +1736,26 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
>   	if (xlat_func(qc))
>   		goto early_finish;
>   
> +	/*
> +	 * scsi_queue_rq() will defer commands when in state SHOST_RECOVERY.
> +	 *
> +	 * When getting an error interrupt, ata_port_abort() will be called,
> +	 * which ends up calling ata_qc_schedule_eh() on all QCs.
> +	 *
> +	 * ata_qc_schedule_eh() will call ata_eh_set_pending() and then call
> +	 * blk_abort_request() on the given QC. blk_abort_request() will
> +	 * asynchronously end up calling scsi_eh_scmd_add(), which will set
> +	 * the state to SHOST_RECOVERY and wake up SCSI EH.
> +	 *
> +	 * In order to avoid requests from being issued to the device from the
> +	 * time ata_eh_set_pending() is called, to the time scsi_eh_scmd_add()
> +	 * sets the state to SHOST_RECOVERY, we defer requests here as well.
> +	 */
> +	if (ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS)) {
> +		rc = ATA_DEFER_LINK;
> +		goto defer;

Could we move this check earlier? I mean, we didn't need to have the qc 
alloc'ed and xlat'ed for this check to be done, right?

> +	}
> +
>   	if (ap->ops->qc_defer) {
>   		if ((rc = ap->ops->qc_defer(qc)))
>   			goto defer;

This solves the issue I saw in a QEMU AHCI NCQ error model where 
ahci_error_intr() -> ata_port_abort() is called multiple times, so, FWIW:

Tested-by: John Garry <john.g.garry@oracle.com>

Thanks
