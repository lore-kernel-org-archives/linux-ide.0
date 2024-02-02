Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C14145B0A
	for <linux-ide@vger.kernel.org>; Fri,  2 Feb 2024 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886773; cv=fail; b=ZBAXojxKwFZ7+8pstDk+5tNRfH5AA4dOVBvtOsZbj98BwovmhD0k6sMMANnLGQJDKMtSxyUgNIiNxzvbXTOHDxw+DN7n8rTTLSdUy/tsImRHvO8xXwRIttQDH+j7lmfEw5MtPYZ83CecGBRrtmsT932MeCWpIBWqD/COFxBLEQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886773; c=relaxed/simple;
	bh=8mjc9cNKf1lMK5eo2MqG1CPwHnWHlsJq/gJBTwN1tqs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iE4YO8sIxuUy5Na6BJpx52O09YjxTtANlfpcJY89hbYTvIzik2pwMP0oR/r/u1LyHVRT8GFpGBWXUKYAJgKXkoOrKvkfT8ZhnNETdo5K1+lWCRv1JoLR/hkqFq2AWRdt0SuqfsK49dWZd66u8SmFcalujUVP7lpsNr/UE1+e3sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FpwIU9/A; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FpwIU9/A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a86mGef8xNyqORcCK+yZ5NmQiGz8MlQ55wvbRGTXaJgJzSAXenCSiHX9lRWjdjuufZLdhhL1DOPebexIAPaaN0rxRQXVl9h1T1nYIVpNZItjo+uF7UpPDdKTek8cbfhGL5Y1GfVwBhUzPvLc33q+eV73E/NFRO5tewXJ9nl3DAhPZlbuudxsKFWjwGi2gVnTHBgsZqMzD7Rc2jwiUH76MSczx/548r7Z3MLkl42yoBdQyo/4iQAIsXVe+sIFpzqQBhsp4VgJRiszgcKBBGl9psM1t9VlYemaXf0Ahi1ZiQHr0ZqrPC5iHyBaKR7Z7e/tje4ol9mf24bHDuu5Ck+wsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMX+hIvj5NhUgN1X4z0R4jQ0qqYQ8aPHPoO7Hc7rJTs=;
 b=b7ex85WRNte3wJISk5d73U9Poc/71ezVZ1nh1ZZp8ydVCm8P8gG33prhg3vpnD2A2Vx6PaCKyoNdDuN48s5SrMu2NZ00HESkS/Fp5P38GCoO7NUwFq/B6i5az6TK7DTjGKVimToM5Su2GOvbYvwHQ7xTN2/NxSVl0v0VLy2A4+M8Lop3Ez50v3JtiNUZuqHxTED785p0eaBExfYylGUu7AoXxAavyO7zwAGietwTZ+1q6BPY9OqTdX0s+/3lUuN1CPFUEdNSAScNlEeys0rIzKFWjP72cwTjSqfd/knuRETB8fGT4Hrs3+OArjs0vX7h6qd2wY6dzRRTpz6TwfLkUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMX+hIvj5NhUgN1X4z0R4jQ0qqYQ8aPHPoO7Hc7rJTs=;
 b=FpwIU9/AMERB80osUXJJsDSJJs5lbAjEMQe4ze57N2Essr1Oa2VfDS4siamX9rlhJ2Yt/fxrRxyNLhch9Vuxilvvld+0Ek+3Edj1Pc4mdBxiU1MgItT4BA9YkfJDSqTwTuxdsOKfkF+xeJLkYtwO8fHFciL7G49pPYS3Hw56xJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.12; Fri, 2 Feb
 2024 15:12:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7249.024; Fri, 2 Feb 2024
 15:12:46 +0000
Message-ID: <3e50681d-7a68-4c4a-91f6-278a3cfe23f8@amd.com>
Date: Fri, 2 Feb 2024 09:12:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drop low power policy board type
To: Werner Fischer <devlists@wefi.net>, Niklas Cassel <cassel@kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>
Cc: Daniel Drake <drake@endlessos.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jian-Hong Pan <jhp@endlessos.org>, Dieter Mummenschanz
 <dmummenschanz@web.de>, linux-ide@vger.kernel.org
References: <20240201161507.1147521-1-cassel@kernel.org>
 <72f2bfb74b196267283fcee5233834146995595d.camel@wefi.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <72f2bfb74b196267283fcee5233834146995595d.camel@wefi.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0066.namprd02.prod.outlook.com
 (2603:10b6:5:177::43) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4423:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7b0130-2930-41d3-89ba-08dc240169a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Oy2LX8ucKLfxWhKTEsnYzzZ7Xk202TF/6JNdtkkzuQ91QEFolaXtPkmbqGwpAS3l0yWs5pgyB1kIP++9XxaJ13WC85MoNAE+iStzkpuFxT38rcKH1Igw7yuy1lvA19n48j2kFyeQn7YLF/EjujeaLNwmpWYzBUNB6qLGv+xpUVt4QAJfldNNT08zd0e64wJm7Ephi5b/RJYBzGhFza1nvl5UcBqqDQdyMmHvE8a8zPFY25cGYkspjQdHnKkRRbdg753bWsU6zHXMs892VPQi2hko0suG8TKojKE6j4ZwWy51BGocopTlpPH1ErZPGgC1M35w5ZgCzKePoa5kMwDyZ5Qf6oS0Sa2N0/z8Y25LM6djUWwdTblV8GFbMKbJEXvrlIdhtXa1qzwv4kLZ0r3mxbID3br/gwIeJMEtVeSyELcFazwMqMN3mUxt+bN5fo9BwjLVyBeF2Csym5IfBY+eSZLmKsH2sV1ZzBWnvMXNkPiMFn5+eLV6hqM/jPKTUe3Kt37GTkPnvI8UsddqNvSiCuqp0ofU0ZDIUvwHkSvbQqrfMfyJnYUPp+yaDE5hnaEK2W2H2xkp0RSOx1Xbfbdz3sjXqFEi4WDse2oM+ERVUwy8TJRTO1PMorKdiL+t4LQrMWFab64YUeQ6UrnVUqomUljicQzARJDhSCZ06vblQaL7N/T4bMYxZvUyFyIMCkU7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(64100799003)(1800799012)(2616005)(26005)(41300700001)(31686004)(66899024)(478600001)(316002)(36756003)(6486002)(6512007)(83380400001)(53546011)(966005)(6506007)(45080400002)(38100700002)(86362001)(31696002)(66476007)(66556008)(2906002)(54906003)(66946007)(5660300002)(110136005)(8676002)(44832011)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWVNbnA4UUpKamxIVVZPcTUvSm04OXpMSEJIOVBlRWZCWmc3Y0xpUmpWWGVs?=
 =?utf-8?B?NDNvSksxUGtTaU0ycFQ3TDdKYTlwc3A2NlhnYlBaQTdrQnI1WWd4UVNURCs0?=
 =?utf-8?B?NHYvWndDTWpZd0xtaXpPNXV2WUtnRUdXZVZ5NFNzYVdZV1ZtQVBvYjdkMm9a?=
 =?utf-8?B?b2x1bzFHWEQvODUzSUE1b0p2M0tBS1VkNmFaeDExTFlnK1A3dzNYQlRUc2pB?=
 =?utf-8?B?YjFXVENlOEFTczluTWRWZnpZUGE2MGhNSVhDUG5RSHRHLzRzODhoYU9ta0Z3?=
 =?utf-8?B?TXMyTTFoUjBabXFHOWo3NFRObitzanVvUDYxWGpvYzR3VjBwb1pxWVZabUNP?=
 =?utf-8?B?cjV5S1YveW1xQWE5Wm5nVmhOUXJXbEJtSlFXb1cwRkIza2lBY0JDUmsyeFVD?=
 =?utf-8?B?c2J3cUpHVFI2TjAwQUwvSW1pTXk3ektUeVdKQ2IrZ0gxa2Y2emdyb0dsUG9Y?=
 =?utf-8?B?dGMyc2xGQ1JsREU2MXpMVFhMM0RvRGdadStlUGNhWWs3VlhXOThWSmJUdWVu?=
 =?utf-8?B?T290TFNQZ0JBc01pdWllMmp3bjVKT1FUMHJMUXV2V0Y3b3pEZ01Kdm5NZWNk?=
 =?utf-8?B?b1BFcTAxeXRrNlhDUnVtM1h4LzVsREFsVGNKWFJ2aGtDSVFNd0pURTE1SFZq?=
 =?utf-8?B?Y0VMY2NNYUxnb1EwOXZ0QWQ5ZkFNbGZVVVdsMzZYdEh1YUl3K3BVV2FMMUR5?=
 =?utf-8?B?VDdFTzB4eTc3TS96YWtCK1pvYUNSUTdrUzN5YmloSnliRlN0M3poS0RFM2Zh?=
 =?utf-8?B?OUF5Y0YyRkx3TTVYSytwOW1CSVNGamhQeWdPZ2tDN0ZEcUVZZ0ZwREVDdEls?=
 =?utf-8?B?NDNxK1RCcEVadTZoTjJQY3pGYSs5NXdKNGR6T2lnVUxkcDRLRTArVFdZb0pr?=
 =?utf-8?B?Y0xmc0ZRcTVFVE1sQktLdDJUZFltVW92RFhpM3h2RG5oUGMrTkVERmRKbThK?=
 =?utf-8?B?ZkNoNWNMRW83REFvU3VqTkh4V1NTTFdISkwrZWxhWWpyWGUvUm9ybnM1WHNk?=
 =?utf-8?B?aGd3eldxTk9BWmpaYmZhV3JVQnZGSFh0TDB3SmpoZk9xaVFLK1lwS1dLZDdT?=
 =?utf-8?B?WGJveDFTTG55RWt0UmJrMHNFMFdadjIxeUdyS2lCOVNnS0pDT0U5cHFZSjhM?=
 =?utf-8?B?NytlRmxrUzFFTmJseVQrS0FFOER0UkoraDBTdmZpbmg1NE1hQ0hBMGtLaFNx?=
 =?utf-8?B?Z1BrR1NyVVFqdDUvOXhCdTc4SG5pR2tteTJDc2tOdGJhcFVaVDMyVEFEV0Fw?=
 =?utf-8?B?TkRWaGJOazcvV0t3dW1GenhEd1lORUxVZEsrYXFlSzhlYVlYVXg1TENiSG1F?=
 =?utf-8?B?bGova2FidUZvbnZ0TnhmN3pRZnA5eStQMjM2L0U4NjBDdnFoMHlFY1QxMWZH?=
 =?utf-8?B?Ym9rbDBzc3gwVWRnWGx4WUVxOUdJS01yWHMzOWdCd0NBc3JrR3llZHd0R1JG?=
 =?utf-8?B?YlV5NDZiTXUreUlHWVBOMG1uMFFQQlhnc0hKWXNjUUZwWWdoSjVZTlY1cnhP?=
 =?utf-8?B?RStNUXdMeS8xVlNtQmU5YXJzMStYam95SmMyTEJZdnpWNDhGcisvbVJScnA5?=
 =?utf-8?B?cFBwMmFON1Jja0V1am5YMnoyQ1RjT0xKSFEyNzJFbUFYWWpQT2V0cHlDMHY0?=
 =?utf-8?B?OHAxcUh5U0ErVllob3M0Nm9tQjRwNkhFSGRVZzZ1bnhJQlBiV0lrNjBFeFNF?=
 =?utf-8?B?OWRkaDkwV2Y0aUFNNWMzQ0RiZ1JZNGo4d1FFVmlpWnk5TVZLY3hNbXpkYjg4?=
 =?utf-8?B?d2JQTGtiU0hCMVFYa3R0bDMwSWpXRkY5UVRZYUlrdENSNUZEME5DdmswRVBS?=
 =?utf-8?B?YlVuQzRtSzNaeitLaHNTOUsvekVNTFppRkNYUWc3T09pMTB0QXpCN2VnM05H?=
 =?utf-8?B?OHQ3Tk5uNXUwNjl5eklQWEMxTHRlQzhDeGhiVkxwUkpKZm1uRUlSTHBYMnJ2?=
 =?utf-8?B?TTBnaGhVQ3Blc2ZGWi8vZ3ZYSXJBOXlvcXBiNE9aakpTZWRnVTBQSWZhNFVj?=
 =?utf-8?B?UUhCMDZlVklMUkFWYVNrMnd2dmFtd095WWxLK0VpMEZrd1d6LzFKa0NYRUZM?=
 =?utf-8?B?NSt0cXpqU3JEY3hHeTBvRTNBQmVRYVBFdkx4VkRtZlBPK1JwU2oyS20rUS9Z?=
 =?utf-8?Q?9zOru4ucDY9+ZVG2kj5w80dVC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7b0130-2930-41d3-89ba-08dc240169a6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:12:46.7455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szbxT3TRS/Cv8fqDyA4QkVaSqi0yJlwtOA0XKoPxWO7jsA3F859a6NPqh9ev6f8B06+wS11b7B01kOWdG73Y+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423

On 2/2/2024 07:13, Werner Fischer wrote:
> (adding Mario Limonciello in CC)
> 
> On Thu, 2024-02-01 at 17:14 +0100, Niklas Cassel wrote:
> 
>> This revives a patch sent out almost two years ago from Mario
>> Limonciello:
>> https://lore.kernel.org/linux-ide/20220524170508.563-1-mario.limonciello@amd.com/T/#u
>>
>> The reason why we did not merge it back then, is because LPM and
>> hotplug events are mutually exclusive.
>>
>> I've added a patch that checks if the port is external, i.e. either
>> hotplug capable or eSATA. For external ports, we never enable LPM, as
>> that will break hotplug.
>>
>> For ports that do not advertise themselves as external (typically
>> laptops), we set the LPM policy as requested.
>>
>> This matches how Microsoft Windows does things.
>> Thanks to Werner Fischer for suggesting something like this at last
>> year's ALPSS conference.
> Thank you for the discussions last year at the ALPSS and thanks a lot
> for implementing this now.
> 
>> There might of course be some platform firmware that e.g. incorrectly
>> marks its port as internal, even though it is external, but if we
>> find any such platforms we will need to deal with them using quirks.
> I plan some testing within the upcoming two weeks.
> I'll do testing with the Elkhart-Lake based system (0x4b63 SATA
> controller) to verify whether LPM is activated.
> And I'll reach out to colleagues to test with hot-pluggable servers.
> Especially I'll try for them to get a system with an AMD 0x7901 SATA
> controller like Supermicro H12SSL-NT, as the default
> "board_ahci_mobile" for this SATA controller - see commit 1527f69204fe
> ("ata: ahci: Add Green Sardine vendor ID as board_ahci_mobile") - lead
> to Hot-Plug not working with default Ubuntu or Proxmox Kernels [1].
> 
> As especially for AMD systems identical SATA controllers (like 0x7901
> in this case) can be used in both mobile systems and servers, Niklas'
> new patch series could could bring lasting improvement here.
> 
> [1] https://www.thomas-krenn.com/en/wiki/AMD_EPYC_Server_with_Ubuntu_-_Enable_SATA_Hot-Swap
> 
> --
> Best regards,
> Werner Fischer

Thanks for looping me in and also reviving the patch.  The series looks 
good to me.  I do think that after this baked a bit and everyone is 
happy we should also revisit changing the upstream default to match the 
distros again too.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
