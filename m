Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C9836E
	for <linux-ide@vger.kernel.org>; Fri,  9 Feb 2024 00:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707440317; cv=fail; b=ckcJck8q2JRoJYxk/VJ0HoCHz5Yub6WNF1+2OeEwOJ7zhdEjl+clBvy8yvxEjQcdAUBZOkU40//hGPU9QRI9BWRYGKjvvpm2xGcnts3sbkX+8/By+SOwFY99zo4LuxT3wGqOjSWQxSYhKqoLizCfkn1SM9eQgeNtEclQVlx2hD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707440317; c=relaxed/simple;
	bh=4AZWbmzuFXo4kwlBrcA458zqVSSD8LRd3ZPs15IJYLA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OcKj6CRZI/aac2a1EjY0mZxu7VhOpxCC/qXfMj+Al1yp7/E/BdnlN4UsE8Wm+24HedTP8aPWMzT0linaEXLJX6zBIwLaP/zDu26xX1mJi1+aMYl4HBaorfeP5LNkc8C/SwQO3csP3eGfvBSEfzHvx/s6Xd+YNkQsRBJPBh+OLSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBeqy16b; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBeqy16b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707440316; x=1738976316;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4AZWbmzuFXo4kwlBrcA458zqVSSD8LRd3ZPs15IJYLA=;
  b=CBeqy16bL9aZMnmRkYrdAu328oUAajrAnf3t9xKNbHOZb6SWJGbigA+/
   T/Yn8awu3MZZDVAaNgvgca6+sSUO9ycCjxOkrp3xKkSJ1eQVMh6pKbA6P
   yX0nal5u1GFQWKflqpBMQx4R/fQXlhhnlrmuJAXkWkce1DUWzjPO1IpUC
   Hr2JUFso5XC7gXbW/XzWn8WgdFzOQW3X4lrKiDgX4rIvzyWSURFFWrEIL
   Ra1r4oa7895krRnVdQhZlifHve6OnpWHReNHqsGmjIgCRKfi01nB7FYyb
   f2i9pIoNBTRXOGYWlH6JS2M/NhJ/jqsK35sys/VLnOrkwQqwGbPo3jD0b
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1231653"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1231653"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 16:58:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="6439525"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 16:58:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 16:58:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 16:58:33 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 16:58:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8SLDNGp6Z/to8JGm9Q9nKiEK5fIbDgViZqs5gCGTMaHR3HztmlGrt4pLDORn9l4ksoFBTaxremixnXKIPf5vfwvaFGU9bvSiAWNQ78uNICjz3nnAQrmralXXrfmUDroj1/xSFYgXZnEpcTm7vXdRtWvVpaLSEixuXDzO0ULacBMHblX7G+CpL78l8XUCC+EmKs1fzbJfAQ3gSjDZbg2/apv+EFesRQH39tABICKFpER0X8VhYof8BXSbPxzc1EpgOXHRZ20DK6CgYCYZ9/P99nEvMjvVJFY5lEVEwWrU/98ZUA/9EMrKjEX7fWOoROhXrMM14aKJAGLC4RgDM3jaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1s75iLpupFaLD2/GDHC6GEcUZhvT/qA7Yuipx4iJLwk=;
 b=bRjvQ0hQIEAetX5j86WVT0AL6AtbNO42xp3lb7R3VKCfxI5fxIl+pT3QaZn5O6AHtkAdbkSKJ6ziqggSIQY//MD9xjXyIdP0ZpR0E1rYKfq6EMSu16fpkjw8dRgUFidha85qNmMxlyLBsg4KU82hm+XYT5Om1zhzVUNF+XjuWMSZ/tWg+fq813x/28qQZGPPKbxI7X+vl5Pw/QW3bFyREkAabbj335tLRlbORrE4ilTXNKP3Etp56lSmLzeW2NTojYCdVLF1KnhqJ0msHS0JhZbfPttPPEH2XtQ9FjpIxoXhscQBoMHkzVg2LBUpwBsMgpummoTZgjN12dYONNoL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5266.namprd11.prod.outlook.com (2603:10b6:610:e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Fri, 9 Feb
 2024 00:58:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Fri, 9 Feb 2024
 00:58:26 +0000
Date: Thu, 8 Feb 2024 16:58:24 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-ide@vger.kernel.org>
Subject: RE: [PATCH] ahci: document and clarify unconventional intel quirk
Message-ID: <65c578b054868_5a7f294a5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240207091054.1697236-1-cassel@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240207091054.1697236-1-cassel@kernel.org>
X-ClientProxiedBy: MW4PR04CA0112.namprd04.prod.outlook.com
 (2603:10b6:303:83::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5c7ffd-5c48-4f70-66d4-08dc290a3908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OzhQMJ47PEb4vdQNtU3RzCIaN0kbemoq2AfzFSzas2BWN6mOcF3+lsjocMrmsPCCPgIRTV9+pu9xA8iWFndakelKw0JLUTYIJySMWeUV5ZBF6wzYUtqBd+UzSHUcwrho+nSskqSzJ3ljKDeP9bLEg2Vcc9ZpiTnK+xrxxFofwnsY+hVaUduTrSXGTcs3i8nDILkof5LtvTqTwT+NSuVv9ZYyYLa1LTOW7A1dpeXi/ZklFhlhW7EpbfOW5+wukoMnnPF9rCVnhnmzRoHiN08XfyJT1CMQimpoWOAlUVZv4A6rl7gRBOfV/Jp7rwJsefpKExA8ICG27gIoB6aFI+s7wN9spbuyEBUoMWXD+291RwRSCkeMXkd+o4n3QWzC5jfZgngzErZ+fpSNQYMp+LIbH4ZD45tz6X9txGWNrJRbBrP3YadxBl8aZZT+/HsWj+OYBvwywgeFLyGJVp8OS/HWUiJsOHAzsiiE0nbUH3XIATCVHvvlN089MzknIwhamPSSeZm0rX/8yk43AeMymNzRAH5+OEX7A2Qr8upefKvzmOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(346002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2906002)(5660300002)(41300700001)(83380400001)(86362001)(82960400001)(38100700002)(26005)(6512007)(54906003)(66946007)(9686003)(110136005)(6506007)(66556008)(478600001)(966005)(66476007)(6486002)(8936002)(8676002)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bUToKdL20WpLW7mvb0o1IWQavYrtWPqRQmGITXJN1safw3fQakUvFxMspanh?=
 =?us-ascii?Q?PImDWfzArZSg+VY/8vvdmYVtgFpdzBKOa0WrM9tN3qKRyptcJsheLz9HRsWw?=
 =?us-ascii?Q?AeXRqgMEatURV0harFjfn9ocVqkr5Vr6A1g2dYQNyQeZgp1Y9a4Dl+8Waqzv?=
 =?us-ascii?Q?PF7r7oPiQff6RT3CDFP9rxvoXAK+jpLu8yC46mXArsl7+asjRMje1SRN9vk3?=
 =?us-ascii?Q?hS2jxdozKpRL749C/y8EveZeX84u/PAWRsr+rWDmVQn/CB1Hb5wUkG1sN/B1?=
 =?us-ascii?Q?UyFsxVoLN8v8SqNpvQJzulO6RH0kA2QAtoUvbMe++7F7WlI+1W7r4i2iI9Ko?=
 =?us-ascii?Q?T/8NnCklTL5pK/cBHj5CUb7zgM9LCJmTv7ltkawXmtYqSwJwMrd2TEh87xRI?=
 =?us-ascii?Q?vF7ECoKk6nhSVg7q/sqSN9p/h7xzQ4qWC18Z3a5MJHAFb/yyU1Czhf8ltJPI?=
 =?us-ascii?Q?5VGXjytFmkF+QG/EdVtgqptASX/U1wxBxTspcHYqrI+y0BGIAlnF8kuRxTSX?=
 =?us-ascii?Q?tIk3pX9zB23n5WIjwGoO1BYd8Rj9QKQ3G5cI1Wa95eVvUbDuYuED3KL57h4o?=
 =?us-ascii?Q?id6YDgl/FF3EFW+8X9d8lHFCzy8+chUlOvSw7yKxUpK1ASkeWwepN4m7VYxA?=
 =?us-ascii?Q?K2KfS2YUiu21/aBPKEmseEWZIKL13dAT+IbPSDL+T509pmZwM3CNbaFsBOjh?=
 =?us-ascii?Q?7PdPK9+zpiYQh6s1l+U7kltzI/3w0dIs9DJRHOjVKazYKHpVPNl3HCjIJvEz?=
 =?us-ascii?Q?yTzFkaXFD3MG77A7DG0DCMuvlyjD3Z50oFJgRUfsxfXQYz3kP7gMnXTy5Zw5?=
 =?us-ascii?Q?buuSBxStt2nGj9hAkAceD9rxIXVQU1EgGtYE361V6b4Xv+pzAvqX0EwLddgm?=
 =?us-ascii?Q?WYbEGEz4wcgedJUlz1wvGfAuxSEd4kfRCGNxuwAxkApi5Aw89C/YOKtPBabu?=
 =?us-ascii?Q?cxPHtcXti0VDm4uBetYQy5BPGTvfFTaidAUAkzs4DtOzFFc4ZGHcFHwG6LdS?=
 =?us-ascii?Q?a8AZWVJQXzpQ7wxpHcFaex0YLjmBbom6GJKQZ7dQcw4Wc2YnsCuCQPi0SOjk?=
 =?us-ascii?Q?l/aKWR2h+Dy+Jw0FqsMz9dboeqtGr+IYANhEW6x1kkgJIzi36hNXkBKTh77b?=
 =?us-ascii?Q?x+wNpLrZm2k4WDY5IAmIbWg6STl8oyFZ1Qdalm8ZFytAfuqRANDURrTcu2GY?=
 =?us-ascii?Q?zdC5Ju7KNzYhRVN6nYhSKI0xzBqZKHwvvEKXxZs2Ip478wZ99LEpJOit0sF/?=
 =?us-ascii?Q?0OFyQE3yS0X+yoRdW6NYFIpVpSL8K+KU0OvV6gkVdWuasIqG/pRlgOPeDYC5?=
 =?us-ascii?Q?S7NggrP12MyENFfJF3EDIzhlj9S1f53LlcLk9ur8AseZJ6q2JZ6YGKNt4MBi?=
 =?us-ascii?Q?dzcGY96Cy9aulJo1guvLyXz5iNc3hp7cmCYb3TvOosCakowgRfgVxBiGnBVX?=
 =?us-ascii?Q?UdFOoEd1+asMUOhZjhhrr/nzIePijR/IbVYLHLwABKDEgGvDqp1O0BtErpGb?=
 =?us-ascii?Q?YFeC3f2uxkdInd+ehcu3IODo0DSvrLKgavzsKdJXY5DG1dhpUL6x2sl5e0SP?=
 =?us-ascii?Q?eU9V+Kdquxb9ERoZRDcvlt8iRwwk0V1zPqiOmRTGXQA/7ObrCGwLllT+PUI8?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5c7ffd-5c48-4f70-66d4-08dc290a3908
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 00:58:26.3960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvbEV5AZ4ghdGd6opLixksoNO5UJIoyokGRcImiIY15GlcQ2ftzOgePbiRj+rD9Uyan5RP2LC0FJomXuzqDDUrmqzrDzM3N1l2bIHf9JcrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5266
X-OriginatorOrg: intel.com

Niklas Cassel wrote:
> The ahci_intel_pcs_quirk is unconventional in several ways:
> First of all because it has a board ID for which the quirk should NOT be
> applied (board_ahci_pcs7), instead of the usual way where we have a board
> ID for which the quirk should be applied.
> 
> The second reason is that other than only excluding board_ahci_pcs7 from
> the quirk, PCI devices that make use of the generic entry in ahci_pci_tbl
> (which matches on AHCI class code) are also excluded.
> 
> This can of course lead to very subtle breakage, and did indeed do so in:
> commit 104ff59af73a ("ata: ahci: Add Tiger Lake UP{3,4} AHCI controller"),
> which added an explicit entry with board_ahci_low_power to ahci_pci_tbl.
> 
> This caused many users to complain that their SATA drives disappeared.
> The logical assumption was of course that the issue was related to LPM,
> and was therefore reverted in commit 6210038aeaf4 ("ata: ahci: Revert
> "ata: ahci: Add Tiger Lake UP{3,4} AHCI controller"").
> 
> It took a lot of time to figure out that this was all completely unrelated
> to LPM, and was instead caused by an unconventional Intel quirk.

Ugh, sorry about that.

> 
> While this quirk should definitely be cleaned up to be implemented like
> all other quirks, for now, at least document the behavior of this quirk.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217114
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/ahci.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index da2e74fce2d9..122278438092 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -69,8 +69,8 @@ enum board_ids {
>  	board_ahci_vt8251,
>  
>  	/*
> -	 * board IDs for Intel chipsets that support more than 6 ports
> -	 * *and* end up needing the PCS quirk.
> +	 * board IDs for Intel chipsets that should NOT have the
> +	 * ahci_intel_pcs_quirk applied. Yes, this is not a typo.

I am not sure if this wording helps the next person without the context
of this patch. How about this?

/*
 * NOTE NOTE NOTE this board id is identifying a point in history where
 * the "PCS Quirk" from 2007 should *stop* being applied to more modern
 * platforms. So this is a "stop-quirk" point and board_ids >= to this
 * value do not run the quirk, see ahci_intel_pcs_quirk() for details.
 */


>  	 */
>  	board_ahci_pcs7,
>  
> @@ -1670,14 +1670,33 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap,
>  		ap->target_lpm_policy = policy;
>  }
>  
> +/*
> + * NOTE: this quirk is applied for all board IDs in ahci_pci_tbl, where
> + * the PCI vendor ID == PCI_VENDOR_ID_INTEL (except for board_ahci_pcs7).
> + *
> + * This quirk causes some Intel AHCI controllers (e.g. Intel Tiger Lake)
> + * to not get a link up when Intel VMD is enabled, see:
> + * https://bugzilla.kernel.org/show_bug.cgi?id=217114
> + *
> + * Since the quirk is only applied for explicit entries in ahci_pci_tbl
> + * (it does not apply to the generic entry in ahci_pci_tbl that matches on
> + * AHCI class code), if your Intel AHCI controller does not get a link up
> + * because of this quirk, try to remove the explicit entry from ahci_pci_tbl.
> + */
>  static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_priv *hpriv)
>  {
> -	const struct pci_device_id *id = pci_match_id(ahci_pci_tbl, pdev);
> +	const struct pci_device_id *id;
>  	u16 tmp16;
>  
> +	/* If the detected PCI device is not an Intel device, skip. */
> +	if (pdev->vendor != PCI_VENDOR_ID_INTEL)
> +		return;
> +
>  	/*
> -	 * Only apply the 6-port PCS quirk for known legacy platforms.
> +	 * See if there is an explicit entry for this PCI device in

Perhaps:

s/explicit entry/explicit Intel-vendor entry/

?

> +	 * ahci_pci_tbl, if there is not, do not apply the quirk.
>  	 */
> +	id = pci_match_id(ahci_pci_tbl, pdev);
>  	if (!id || id->vendor != PCI_VENDOR_ID_INTEL)

Otherwise you can add:

Acked-by: Dan Williams <dan.j.williams@intel.com>
