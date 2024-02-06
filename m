Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2D31C283
	for <linux-ide@vger.kernel.org>; Tue,  6 Feb 2024 21:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256464; cv=fail; b=j1SuOVoiY+ncVubpgauBdSiwkWFNjTtaTPKc1n+uU6umkM5RjHyqwI2Tj1anchIZxMPGrDnQ/dux8f7M3rjIe37EWXjKf167daMMnhwHwAaquIjk3krb2teWWfO9cfMBzQDZ7JJM54sQL0mu7NQ8tTqZMXEGFN/1QDjt4NNLXRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256464; c=relaxed/simple;
	bh=ICyYDRRQ8dJ1dEljq1KlclpwEWzJaLmyHvh9D6D6AFE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RAPHdkqwBa6uHgeNbwcklS4/Edu1v8Wn1Am3TYX6hx9kayfAB901OZE74QyDcQJ2W3z0gFbWcVpjwcBdavzooMhTLyI4A1tgEqrFvZOl7RtTXyE61K1Hj9YmMfYQ0fCbNHoVNVUON/zIJIYu6Pkau4BhmaPOT7ABwbW7nCAttIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H77mav08; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H77mav08"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsJHFqRMEVlISQv6TDMcoAaRltD4Ouzr2bDllkrtUQf2OGx+5WyzUT172DPcltVj4Uq8JpqprbTV4kuItZoWlZE8hS6SuppsTi3yI5/Er1kLIMsrCFTYkiPZKpYFygNkWI42f+c3ipGfV33rlghzonJ+mCiXiW33X8vxXzoHC2nV1LFIGpaq+A4srIGxzDhtO6yMMis0D6/RN6twtDhzoLFnwtGdagCyX9NOSiAph7RFFq8YJXJ+aIMStVD0s5eOk5MikZZ/o+pyveSKq+6mgl/CaBxXIPXFN9nlHwaP0UmItyyRgt2S1HPZ6hF+M7tjtGBT2lJ+9fQfO13iac7dAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up//0esYaUjMiqNxJyMS1wY6Hj1muJ4SEQDQwdtY6W4=;
 b=gq4wG7jzYYY8Nwp3sl7v+JoyKk9j7M1uW2MPM/+5rIGhOrfqejCUtOP/FbtMoOq5sU8e8wYr0qXyJcPyPX4CarUOD1iDJEKJEVZa1D9Av5U0eu+h6svE1OtriVLls0mlzL04L/ox1HfRevreYjkk6JPFWqW18C7tqgNZP9yOUz5l85PLpcOptXztu+394xr+KazBmTuDp4K+BvMe2yv5cM97EN7khhARqIPH1R9bQtbbvdz7Mao9c6MKwKY2nwc+kdG1GrMx+WGAsZlzUzdeLytLJj5i+8EM34vt8ZH7GoZOe/OW2EbQbIHCr1FqtxfFRfO6P/81/Db5FDJ+wgRwGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up//0esYaUjMiqNxJyMS1wY6Hj1muJ4SEQDQwdtY6W4=;
 b=H77mav08v2jzOofRzWS4swtnJPFKdzv6cwIz7awRNbNiM4+lcEzb6Oo/rwIdzle+Zxc+aC2cKiEOEYG2d39vOhDFwLB5M5IJiVFb4ADnJf+cwTMnXVCT1mv9mWW2vuxlxW1DGsR9TPc8pKnDMB+IUNiUrIhLgt4DMXAVD5oLPeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 21:54:16 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826%5]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 21:54:16 +0000
Message-ID: <6bf9d981-5dd5-4f74-af8d-e8eb637d569d@amd.com>
Date: Tue, 6 Feb 2024 15:54:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] drop low power policy board type
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>, Daniel Drake <drake@endlessos.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jian-Hong Pan <jhp@endlessos.org>, Dieter Mummenschanz
 <dmummenschanz@web.de>, linux-ide@vger.kernel.org
References: <20240206211352.1664816-1-cassel@kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240206211352.1664816-1-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:806:122::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 0686f9bc-b76c-4840-5ff2-08dc275e29b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oPbm//Mcv+Gh5SPSG4BSFzYqCz8cFOEz52imuwqmdUzEmVSPYiTMpmlQMeU91/X0Hl0LCMrVuEoonr8Xm60lKvYgAfcWGxGPgYSr8j2fJ4KT8c1R5Xslie0knVc+PSurPveN2Bvcwm2EDXCVPl/jdkfZScYy1ToV0erTgkM+/uKjCETz6QT8qD0fuIiUHV/8jXx9fcJZZu3GtbavrZQUvVvmcL0WH453xWe0vD0iJUOpSVJJtPgMlooemroudcAUQIYnZftL9nIQjCWPGMMr0MMzxE0jzBxqbNSFnu30yoWGXXXssfPX/+gdx+sNWe6y2libMMbkiJMhbpVkcX1aqwPgvE/qABpkBzUN5hdk8nPS+OAeZu7bhJ666yzhJPwAv9EepluyiYpTKPP32nt9XFdzXxDflAAxnlNhpJRIov6Ey27lmiBDPHYGK0pgOD2I6HaVxquiiwA43DReaNHFzsT7ckmRKSavREFRFZj37gZtlh3uUj/ecJx6vJ1JcuYnWGUK9VhcUbioK8qCAjRMrhEC2LEI3wRHt6Hgtrdsiq7ZYbGHNknRth7hMWtzvVtHW+fUQgb8LILqWRffH4Q1p1Opvw+oU7Onqhyt175NvKCHcZZYxvULliVeysEzjMJivK/hP2iBBj6a8oFx4ds14yN3hukyo7apIwdQC34fztg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(230273577357003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(36756003)(66899024)(66556008)(478600001)(4326008)(8936002)(44832011)(8676002)(66946007)(6486002)(966005)(31696002)(110136005)(2906002)(316002)(5660300002)(86362001)(38100700002)(6512007)(6506007)(54906003)(2616005)(45080400002)(53546011)(26005)(83380400001)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2k3SnVWS3JMVDQ3dFB6aFIwVUlyU2owY1g3OVpQSk9KOEZ6UU1ZV0FPVmtD?=
 =?utf-8?B?dmJXeHAyN2VsNlJxb3JFV0dEb2FMZUcwWEZoV1U2R3RLU0gyUDdqYXF3OVhG?=
 =?utf-8?B?eUk5QmpUTGhobmFiYXNVeTJXR1AwVnlzQWJsNEs1dlJZYVhUNmhEWmkwT20y?=
 =?utf-8?B?SlFxaGNEMkxIbCtmTkxZbHdHNjVPNk4yeGhHSFFyZGdjMXBKSXEwajJRSk9x?=
 =?utf-8?B?ZXdydmN4amEwejlIVVhxYzZlVVAxNGxSV1ZuODRrRkZDUHJzVGU1Q2lHQm9O?=
 =?utf-8?B?NDJkSTdyOVIveWxsd3YzcWZ4cXYvSFFNWjJCdERvQUV2bGNIRzg3aGdob3Z6?=
 =?utf-8?B?RE01NFhBdmNzcDkzK3JvMzIrYjhydVNFbi96QWdmZGNkem9rQ0VNajJLQjRQ?=
 =?utf-8?B?RStTdXJkcjgvVVZyOG5UQWFOL0FIV3ZjTDRPREYwVG9VSzZSZ0JxcTNiUE8x?=
 =?utf-8?B?QWJsY1YyZU1LY2pYRXRoM0FBcnFhazFFUFZCVld5UUllTUNmTFI1cmpFeW9S?=
 =?utf-8?B?YU1tUllmekNNNHl0aXIxSEE0cVl3ZlJjOWFZYUhBNWhNVDg3akxaT0RpSFUr?=
 =?utf-8?B?RFlTaHNVdkxPQ3JvbU1RQ2NJbkJTNVo4M0VZcmFrK3hyL2dkQzgyc2w1MWRB?=
 =?utf-8?B?M3RDTzlNR0tLbXdpNEJ5dU9QZG94Q2M4Nys5Tlp5WFZpc3dGeFNEazY3RkRO?=
 =?utf-8?B?RUNac1hrMXRjRTdOVEhUSE81MUpSTHcvQlpCUGtyY3JQYU93M2tmS3c5QkhR?=
 =?utf-8?B?T2R0Y0c0VC9kMlZmeDdwUVQxN09mWEh1ZmxZVEw2Vm13RjI3VHJxLzZJd2JX?=
 =?utf-8?B?NmhRbjhSbWxNdytVd25rYWNNT1FJMFBRbEo3NTUvY1F3S21xdmxGTmI4b1ZY?=
 =?utf-8?B?TTZrOHlJbmxKM3R2WjIzZitwM0xhOUZqK3dFbWUrd0VUZFZxRDgrSGl6NHN5?=
 =?utf-8?B?UnUwRVJtQkFLYlc1dHhicXo2MXFkV3pDNUM4eGFuVTlFNU1zV2xDWDZWNnVz?=
 =?utf-8?B?OGJ1S09BeklURnFsNTZiaVN5c2RuZkNzaW1HNDZuZ2FDK3JJL1FsMXZxa3hM?=
 =?utf-8?B?blFvVG9lVGFucDUzK01KL1lhSHk3QXJmR05tWVRUTHhlSVA0RENkYW9FaW9u?=
 =?utf-8?B?ZmMxcFltbzZvT1pNajdVQ3ExWUNmazhWKzBvT1JxNUxsZDI0Y0dKcUc4TFJI?=
 =?utf-8?B?NmRnZUZiSFdvY29HWWhkaUdqbklEMEdMTTJmTGlZTnptaHhnUmdnaXpVSHcr?=
 =?utf-8?B?TjlIK3dHNXdFSlBwM1A3WWs5aGFnMHBsbld4V09mQUt2Tk15Z05ycWFJZ3Bu?=
 =?utf-8?B?SXhkZExGc1BIK2lSditBY0hpOEp3MmZFVVZiTzl3SnR0M3p4LzBrWEdISXZr?=
 =?utf-8?B?K0NON1lYYUpMYUhsOXU5LzFlOG5FS0Z4dE5VREJhYVJ3dHdNaUJtbitFcFRB?=
 =?utf-8?B?RTkzL04xQ1ZadjlJdFBFbmxTRWtWMWFJZHMwZHdKOWtHaTJ0ZmtUZ214bDFl?=
 =?utf-8?B?WHV5UEFSTU1IZkozWWZBWXF0QU5GbkhrelNaVkt3VnNKUUZ3cGdpelp1K3dS?=
 =?utf-8?B?Y3hkWkg4di9Wajk1MFZoRzFGSCtIWlFOTldCZkV5UnJja0JjMVlEZnExYVhX?=
 =?utf-8?B?ZE92UUFqbUhlRnJEdzA3VGlsaHFFSU1WRHBvZzhvNjNVYlpTeVIvYVBHUm9p?=
 =?utf-8?B?a05WZ1kvSk1kSCs2Y0I1WGYzeEczaUpET1dCMkFuS3J5VitWQnplc0E0OXVD?=
 =?utf-8?B?Ry9yMEUvTE5zWGxvWUlySlJ2Skl0azRKTGlxY0lKVFBWaFIrZEJnZkQrbm5D?=
 =?utf-8?B?V3BhQ21oNCs0MUYxUWt6WDNwc3RjUGUrZjA5NzVPWXpEUXRYdHdZaG1hZzAw?=
 =?utf-8?B?Wjk0cWpCRithYmg5cGIvOEJaUVdlQUxnL1VNeWhUL0VRRVQ5ZktjeitGUXZI?=
 =?utf-8?B?Y3ZQVUdPRWlZOHU2dWtoY3I2cmE1UjRzaFpZRGtJRlB4blRzcVNZOWx5Z290?=
 =?utf-8?B?citGN0UxZllUQ21UaUxtSHVkQTlsNEtoWGsrMmxaa1lsWHJQRUJVOHZpc1NK?=
 =?utf-8?B?RkJmMzV5TlVlUHpYUVRFL0JkbnA0T1RWUDFpa0gxOXF2cVVQOHhYRkFENmtp?=
 =?utf-8?Q?Mi2/QJMlS6gM2zaJtxGXozuwZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0686f9bc-b76c-4840-5ff2-08dc275e29b4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 21:54:16.1495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wR32u5/l+N9cS58nhgPyHoVAEvwJHuPB70b7BLcsOA4JnfyQbsTw37a3pdhhZEzLaYXWoylkeqBmtt6G3UxUBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753

On 2/6/2024 15:13, Niklas Cassel wrote:
> The series is based on top of:
> https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-next
> 
> 
> Hello all,
> 
> This revives a patch sent out almost two years ago from Mario Limonciello:
> https://lore.kernel.org/linux-ide/20220524170508.563-1-mario.limonciello@amd.com/T/#u
> 
> The reason why we did not merge it back then, is because LPM and hotplug
> events are mutually exclusive.
> 
> The difference with this series compared to what was sent out back then:
> I've added a patch that checks if the port is external, i.e. either
> hotplug capable or eSATA. For external ports, we never enable LPM, as
> that will break hotplug.
> 
> For ports that do not advertise themselves as external (typically laptops),
> we set the LPM policy as requested.
> 
> This matches how Microsoft Windows does things, see:
> https://studylib.net/doc/10034428/esata---microsoft-center
> 
> Thanks to Werner Fischer for suggesting something like this at last year's
> ALPSS conference.
> 
> There might of course be some platform firmware that e.g. incorrectly marks
> its port as internal, even though it is external, but if we find any such
> platforms we will need to deal with them using quirks.
> 
> 
> Also note that we even if the user requested a certain policy, there is
> no guarantee that he will get all the features for that policy, see:
> https://github.com/torvalds/linux/blob/master/drivers/ata/libata-sata.c#L403-L414
> 
> However, I'd rather we not try to map all the combinations of
> partial/slumber/devsleep in to a single policy represented by a single
> integer, thus I do not try to "change" the requested policy.
> The user will get all the features that are included in the requested
> policy AND supported by the HBA.
> 
> Another difference (compared to an earlier version of Mario's series)
> is that we do not try to change the default CONFIG_SATA_MOBILE_LPM_POLICY
> value from 0 to 3, it will continue to be 0.
> If you really don't want LPM even if your HBA supports it, and your port
> is internal, one option is to leave the Kconfig set to the default value.
> 
> Damien: considering that the Intel VMD + ahci_intel_pcs_quirk() bug turned
> out to have nothing to do with LPM, it was simply the fact that the
> ahci_intel_pcs_quirk() was only applied if there was an explicit entry in
> ahci_pci_tbl. So since that bug is totally unrelated to LPM, I no longer
> think that this series need to wait for a fix for that bug.
> 
> 
> Link to v1:
> https://lore.kernel.org/linux-ide/20240201161507.1147521-1-cassel@kernel.org/
> 
> Changes since v1:
> -Picked up tags from Damien.
> -Moved the comment in front of ahci_mark_external_port() to inside the
>   function.
> -Modified the comment in patch 4/5 to more clearly state hotplug removal
>   events.
> -Rewrote the commit message for patch 4/5 to be more detailed.
> 
> 

For the series:
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> Kind regards,
> Niklas
> 
> 
> Mario Limonciello (1):
>    ata: ahci: Drop low power policy board type
> 
> Niklas Cassel (4):
>    ata: ahci: move marking of external port earlier
>    ata: ahci: a hotplug capable port is an external port
>    ata: ahci: drop hpriv param from ahci_update_initial_lpm_policy()
>    ata: ahci: do not enable LPM on external ports
> 
>   drivers/ata/Kconfig   |   5 +-
>   drivers/ata/ahci.c    | 135 +++++++++++++++++++++++-------------------
>   drivers/ata/ahci.h    |   9 +--
>   drivers/ata/libahci.c |   7 ---
>   4 files changed, 78 insertions(+), 78 deletions(-)
> 

