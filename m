Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9F3C4332F
	for <linux-ide@archiver.kernel.org>; Fri, 11 Nov 2022 10:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiKKKa0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 11 Nov 2022 05:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbiKKK36 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2022 05:29:58 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3949A5BD57
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 02:28:20 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABANELx013936;
        Fri, 11 Nov 2022 10:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=66Nq4Ss7FD7AiLMKE67Z7J1P3bB44VMhLTicQSqa0/U=;
 b=J1cY8Lj8l4nuJuNV6Xae90lPU7gowk9radT/lgsPwjS1CfpYabjHoCsmbER14H/MNsyw
 zqp3m9Sh7dOzEG+XGtsG7rFjuN0LxGfNM0RsSuZ24mzcogabJ1JL4iii7NLPcTR+k8+E
 CsjgNldf7shlDhmQ9/wA4H/+VR6/0iUFz0uJ0Kic+OaXbd6IAxfCqNyvOPGlUWmLZ12S
 dl0Bw6KHUQdx5i97Upb7M/Bhc48+sbXVGapjjnZrQuG0K4xyrckzgvtHmkZqg5g4XosJ
 M0Wl1DLDXcpmA0VxROu2g0u2KGvzr/SnX5kepU/e6HamLOPJ4OS/rC4rERX51GwEptZk OA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksmkb8038-59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 10:28:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABA3LuQ038387;
        Fri, 11 Nov 2022 10:11:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctge4jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 10:11:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ujk380nExFqz0cyzO4d9Izwmcuiomdipnl3YhKvNOsYcufJyTd0WqWOyyT2JZTZchrnywLRnDLSM4hzLDuY5t0kZdRl/wWva9FmWIkg+ZeyH1BBua9OJ4fiJ99cfhTg0PZoX3O4Elip5wmY8yu9djw383eiFKpVKhMO6bnAYp2+3IYtDgriVar2TSxXvcfCLiZaWNILDlWRNXB9KV/xxjvQHimZKqQgnhT81UU08hF9zn0zJUOk/Z02L00JfAU7Dr++p96WzLMM1d33hHmuzOhUX9UuvotmmjQENkdHnJzuyVuXOd3D5yEhFmfDbgRQaZlGFVDwlAD5QDIH0VmHXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66Nq4Ss7FD7AiLMKE67Z7J1P3bB44VMhLTicQSqa0/U=;
 b=ofB7Bk4wOzrmNDTMkI9Ra2YL3p/KeBlFCwbSIuonCnlE6RzDXqZizmiVpdDqNITPBy7aObx4DQuAzQdBvue6/0hZ4aBeoHZlez9l+UVhliq16VCejovhgwm99LsfCGCTLkrTrhygs8B3HAxefyoqH1n8XkJWPdqjbiswSyu/dqKStKyeZIeFjw5FDSA2wpaZvn+OWgGFuAoPGjvwg4zI7gAEzsMzUGSetrrrb5BuTKiYj+Gs7dZ6KzEdIiuQMKGF9Jti+z4D8T9D4Vmcedh8CbxzDMKpt3hqMLSv0yq2kC54wHJELwkFSJ8zfWKIJBeNmNOe6HF0/lhaJox0YnEooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66Nq4Ss7FD7AiLMKE67Z7J1P3bB44VMhLTicQSqa0/U=;
 b=dy72tCIHsRRkF2Lis4kHaI16LmWEWW86M7fdXye7YPUaPLc0T5ssl0BWbAEYwQQ2jt+4Yiq1BzRw2Z38Niz6b/6Ff86FJpsRdehnt2gxxcoT47dnH1rnHAdWKmx1E8edInCQuOUiMCb6yU+QaWDavgWPGAQ5GmDAvLzBoNyPiuc=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by MW4PR10MB5679.namprd10.prod.outlook.com (2603:10b6:303:18d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Fri, 11 Nov
 2022 10:11:34 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::b03f:ba3f:28ed:e2bd]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::b03f:ba3f:28ed:e2bd%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 10:11:34 +0000
Message-ID: <863efa99-320e-0f50-73d3-56727528be4d@oracle.com>
Date:   Fri, 11 Nov 2022 10:11:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3] ata: libata-core: do not issue non-internal commands
 once EH is pending
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>, tj@kernel.org,
        hare@suse.de
Cc:     linux-ide@vger.kernel.org
References: <20221108231534.982516-1-niklas.cassel@wdc.com>
 <8a9a84da-13fc-04e9-ec23-807933b616e4@opensource.wdc.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <8a9a84da-13fc-04e9-ec23-807933b616e4@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0361.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::13) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|MW4PR10MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 620b075f-233c-4ace-b0a0-08dac3cd1c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qesW/iMwSfQzACzWh9tvkbKvwwf7RvQsoY6RPLzMgnOUfrtqD9udnNITL/bf+yIiykTWqNi5U61W1w7o2LLLIHYCegIXxD+pXvj4SgDLg4xQFu7uDeIYivooDY/ozPgCv2eAVID7esKkhXeU3TC1MNIoB4/V22Tvx+kiV5JKUb7xLhpyxusSxpa4bMjmWSOBAZIWPtiKaJrSP5/TS0tM3JhyvxU3JEPVkdNjGtl1bRiXRg2Rv/HImKByl7nCTTExkkcNTJ2hJ77lo5hQ6+iVB/GNq2tFli33p40lBFlyLBZqrVb/nNr8PUd8HP7gZ0tWrGAJff7H22+einnZVEuTfoqIt4tfPGlSCEQIoduG1UpZE1E/jHh+3byE4rWkpHfJbs0zBn2H/kGcPIGYO3qlUatIrHUieYrbNYdvMBteJAaJYTnlwHkLw+Mk8dxTm97//wqMftHwvVHR3oYrUMgP7LCt6JmSuVfo0hM1QBVfIyQjM63G90EI8pPYkH1IZN5U1a3CCFpI2/CCh1HIIZEJI9+6lTVx3FibWNDKBNIqPDCge5xyUDU6V26DLYD3Vd+AK+B4BtkF9zJliKqs81ef+h2iDg+LH5qdAVBx0/qAMrLoN+YNdtZTrZncYkZDflYrCH09nmFga3b64q08nc1TJOEYZibHg4H1TsV6Mgv23g39qH3MGwqF7mAyeEyycPiPUeroGtjLiTUpgaezF3QD7qONpWSZhgKf3xpYj+nDSzE8dtMmKujv4NOfHEeSqrkhUVk/8UjG22A2PZLxynIErNsopIfSd/LCYPuHBqMRM0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(6506007)(110136005)(41300700001)(6666004)(316002)(38100700002)(26005)(86362001)(31696002)(6512007)(36756003)(66946007)(2616005)(36916002)(66476007)(4744005)(478600001)(6486002)(8676002)(4326008)(5660300002)(8936002)(186003)(53546011)(31686004)(2906002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmhGandpM21sMHgwbXNDUVBhcXlKSVBlRWpRcFpsNU53eTJVWFZ0U2JUSHdj?=
 =?utf-8?B?VklrNUVvQ3dPYld6SzRrcWNwdi90WU9PNWx1VndaNG5BLzY0bVBIVUpKOUhF?=
 =?utf-8?B?ckx0TURvTFdnY1NJTGQ3NmZRdmxQTFhTSGplTytMRGtra3RBUXQ3OVpiNytm?=
 =?utf-8?B?clZ4Tk1zbkhlL01VSjN6L0FKSjhUYTJ4anRpRHQvVThJaGp4U2w5OXIvbVhW?=
 =?utf-8?B?dXlhaitrSzlTZ1N6QTBYVVB1NFk1V3I4MWQ3M1VhWGFyOXk1d3ppU045dkc3?=
 =?utf-8?B?YTFzSVVqd2Z6NFRYMXZTWXR2N2VKWk1rejAwNngwelFpVFAwYjVScS9sNjJT?=
 =?utf-8?B?VWx4OFdPMzErWFpkaSsyT3A4NzByVWhRU3hTc2F4WVV0dDNiRFgzNmVHVmFB?=
 =?utf-8?B?aTR3STJIOWE0THp0NjZYRlJ3aUtmVXEwRVVyaGVWVll2bGhoSHozNXQxN1pJ?=
 =?utf-8?B?cmxxWUlWaU9vbk1Gb0hNM0x0cVJrSkppWCtId0VSWWhoT3pLS0N3SlRjakpJ?=
 =?utf-8?B?MGN1QTNjcHA3K3FicnRCRldwdGlIQmZIcUpwKzBQWHA0RElDY2pXUmNlM0hD?=
 =?utf-8?B?bnZGenNuTkYrb0VBd3VkM2VJV3RiYTJ6UHhpL1NhbnBEMlpOQmpMM1hid2xp?=
 =?utf-8?B?S3VHVFVFbEJjZnQ2dUdlTE1ZUDROMjlyaEZhZDJYaC9BWlJCUFJFUFhiL3Y3?=
 =?utf-8?B?QUtqR2pYY0NJMGdSbWw1T21ERXZpS3VzUnRpRlFMWStyVU5GeWE0RnppTU8v?=
 =?utf-8?B?RHNWd0FKdjdqVFpuNUpiVHQ1YXMzSXg2cUwzd245MU1aSWE2WFNMQW5FUVB6?=
 =?utf-8?B?NnpqNjJpeTl6aEJKdmR3enBWa0VvWUlpUzNPRUdtalZGYjlPNndHOVRXMlYr?=
 =?utf-8?B?U24zNVloZWV5YWVkM2wyUUhxcE9mYldKaVNlbGN6NUp4NWlMNGpyU1lJZ2wv?=
 =?utf-8?B?eHBaUjNjdENhY3NLbTBzenhMZS9XZVdEWmNHdTZVbkhTNkFYd05iQlptcHZB?=
 =?utf-8?B?N0ZjZG5WWTBNM21yUlJ3ZDU5NUpDZWE0dVozMGhrRTIvbzhjYytUMWMzUFFS?=
 =?utf-8?B?Ukd2NUw2aEVVbllINCtPeXJ2QXljVGZ2UEpzVkZFSlJlOXA3OHluQjdDTmh4?=
 =?utf-8?B?ZDc4bU1QREJyaGhOYUtpSFlRUWc0TUVZVmVCaWt0MzE5aHN3a2NFVGoybkND?=
 =?utf-8?B?NDUxUjVIM2ZBcTVtR3VzczAzTlJpenFwTFdTUW90ZUNXdjBnRytYZzg0bjNB?=
 =?utf-8?B?YVdUSEpIa0g0ZjhicjhiQmJwODNobENTakhzaGlQRkk1K0dTRmtLV1h6cmVH?=
 =?utf-8?B?VWkyZTNjUXQ4SU9ybEI5NGxYMUlIVDNIUjRxSk1NU2NrOFNoYlZZR04welZJ?=
 =?utf-8?B?TE9URkcvdEJDaXlBc2Vvdi9GUURlOHJlc1c3bm5CRnI5bVI4OWZRYVplRFc5?=
 =?utf-8?B?ZEtCY3FNc3lIMUR5L1VwQTVWaG55bGdRTGlJV21raEtBdTgzU0Vzc1VabTNN?=
 =?utf-8?B?NWNGWkRRaDFtNEI2d1pzRlR4NzdEeFlDM2xOekV4cUthTVFadzJ2RnJGcFIr?=
 =?utf-8?B?cGpCWmVJZE52L3JiYStLNitYaVRmaDZadVo5dEt0VUZnckgxODZXQnV6MGtF?=
 =?utf-8?B?bTZjZS9ma3E1QkdFb04weUNEQjAvTXBYbXZuUEVWSGRaWVRLeDZvMVlEUHpP?=
 =?utf-8?B?SldxSm8rSklocTBHeHFOUjhBQlZXTmtyZWt2akM3SjJMOSt2YXU3ZHRiSEdK?=
 =?utf-8?B?em5OYmVwdm5rZFZBaFdxY0gyTmNUN1JrZVFLZUJ5N1AyTmZnMUxLRTFLVmJL?=
 =?utf-8?B?c2pLMTJML29RSlNLbjhnL1ByaVVacDZZd1RWb0dhUGFKUjZtMHNKUXZFbWtx?=
 =?utf-8?B?VWdNblJCT20rbWdQZmlWSzYyTDdVTFBwSjRqRnF5TkZPYVRScmtXcDhPaFJT?=
 =?utf-8?B?R0JFOVFQcG9FM2ZqaGtBc3kxWGcvK0RyeGwwU1dNSjU2djJUU1NLUHlVSjVI?=
 =?utf-8?B?SURPd0NtVDgzZDlXdlJzaUpTNjh5ZEIzbVRWRDZTMlNoRW9BbFNkTHdtU1Ux?=
 =?utf-8?B?NkxzbWVteTVvV1U1QVVFRHlNYnJNQjExZitGZlpqdy90Nm84NlhlZ2JtcGFY?=
 =?utf-8?Q?ipon+ePpEjzglVEiI/ZVKC6hS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620b075f-233c-4ace-b0a0-08dac3cd1c8c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 10:11:34.3384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ICqK+iyxT1RGPv+LUsI+44Sy3OcUig5vDSzvBzS+IZdXlRwEABP9XAP/ML3Nl5gJFSwx3OqKk7MQ7qNc+Saxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_05,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110068
X-Proofpoint-GUID: 5q6bOApcwSibbmJ_ohQfia3bqIWmSCYq
X-Proofpoint-ORIG-GUID: 5q6bOApcwSibbmJ_ohQfia3bqIWmSCYq
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/11/2022 08:55, Damien Le Moal wrote:
>> Fixes: e494f6a72839 ("[SCSI] improved eh timeout handler")
>> Signed-off-by: Niklas Cassel<niklas.cassel@wdc.com>
> Applied to for-6.1-fixes. Thanks !
> 

If not too late, I tested this with that NCQ QEMU model again:

Tested-by: John Garry <john.g.garry@oracle.com>

Thanks!
