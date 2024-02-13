Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B36360907
	for <linux-ide@vger.kernel.org>; Tue, 13 Feb 2024 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848776; cv=fail; b=a+FWB8r5jBLfe4uLrkXElKacSCwFP6JEnntR85dDt+WMghfVp6B3f5B3b3HWPCLibhT8zWhE3khHFN9Q9hJTfRT2l5xCFs5sUsQuS+43GUbsf6lOU0ZsAPiDeQ0sYDIx1Ul9dQ7ZxofdgTmcWkqxDg+ggBDWMwgzVxY3lzlAlhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848776; c=relaxed/simple;
	bh=T2I6qmhuO0CQJyi0+al1NHO8sluB2S1pvyB/6aNCIQI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TnRQjnv+cRZL8sVkC+DtMEYkUadI7drWdnwMA5cl44haZTymCRJu6+3tpuTvg1lCBNEoEpBuBeMCmQcJgbY3FzwnuQF25woUDmVDZr+8BNm7BxpL6UtOE1N0wSMcJoscpl/KC9k0KUHKJiWS9yZU2b1n2Hqt9+0rmmYZNO0X0P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcNdIhB2; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcNdIhB2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707848775; x=1739384775;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=T2I6qmhuO0CQJyi0+al1NHO8sluB2S1pvyB/6aNCIQI=;
  b=dcNdIhB2/2J6fzP22ozcnimrUrK9W7sxyq8c5mC9UI8mh3mA/K8U2/dP
   5TV5lbrzfvfZIurZBwb/QXoXdxJ7y6eRfjaOeQmCWrkbGIQN2TQ5nH8cz
   fM43Y5fV2CBehUsbJicbHwzzM+qTOYay8qYhTNQgY/gKzYU3evvLW3aEL
   IjrW0ZhYo3gcg8pT8GJgmjp4gHsVAhhXLMk+dzeIlgnnp13b/CnbtG9Na
   LlMpBsqFZVf8xQcYVvbt0+5calqkeXMeJN+Z+ktNG/upp9ADm/CGqS+V/
   tkwnW5gsOjp6bv6gw7YBJDAy6J12uwyWjLxiOuRFpzR52kx3kqk2uU9b0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1723628"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1723628"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 10:26:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="2933819"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 10:26:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 10:26:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 10:26:13 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 10:26:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZ8J/cmyYtAcg3tdgp5vft99yUM5XHTuwB5WIWPwTOOH5Vw2viDY27SkRZKsFTnsx8FSSZ9O0HvXJopNN9Bm/m9SHQKfpBbgdlxdUTB+pordhjAMA9q+2evit9mn7uWjCpR7hstjbTojxjpGbPuGmVARHYb4q3wWwopDPhFINurCPuwrUq0Lu24RWn/708JYhLRHZWQ9ZoF94mwYCz9LQqEzgRRq77pj4pVI69/nFPIrxNMPMQ85CpqI5T3quc8R0fzFDO02/SbStYuH3BvPi07RcLmfRaeBuFruB437AmGR2VdBnQFMduc4M0R/ANx53HE3BCK4hq2hNJESVHH6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fp470TLkOiywN2wBbNb+kjRNq5zWqlPLjPiV19FzH9U=;
 b=dQvJGPAJrFabBryIOxvOk1dfZ0S0XkWo24zSn5AtxPr+FEY4bmjvU1zYc6rDnBLDEMh31ZrWWe3v67KUEDiSAbuKqRYzwf4XuHNvRtpIiQfNp4OU0VPD6e1FaWIeW3Q3e3L8hcouwFx6va1BzyMxF7t9tJwRjCFwSfBzv5FdW2Or/xevBVJPQokKETyjA26poBqls9PoWeFe+9uT65d5rjCQY0c1ElY4Bm7uuvxa50A6l27DKVhX00117xjYWNHq3Q09wv/Y3aLD5vjdxxbsEZn1daVvH89+LvCk4+XYymTy+gQRL+c1CddP6IKKoWfP6/fxZqQyK9KBqlLkoj2k+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6527.namprd11.prod.outlook.com (2603:10b6:8:8e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 18:26:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 18:26:11 +0000
Date: Tue, 13 Feb 2024 10:26:08 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>
CC: <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 0/2] ahci minor quirk cleanups
Message-ID: <65cbb4409ac3b_29b129422@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240213130733.819524-1-cassel@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240213130733.819524-1-cassel@kernel.org>
X-ClientProxiedBy: MW4PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:303:b6::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: caac434d-874b-466f-bc78-08dc2cc140d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MIHL5WNUGLHvjGIFDxUe5Th5mC4hKfUZsdnB2PXNEn7H7O4Iiaa8jLAmc3JTi9hHI/LZRYVIgNeqO1ikkmsW83CTflqbK1AXw1CpeDZuCpY43aDi2PtUdb96XJfWJcKdcrVgl5w5yqzyaSaanU7HS8o9oyLhSHem/uEnMTzEt/EtCi7Nj9bO2OEJzGc38uRah9ux3hf9jyLbBWDQDIy2AkbegYYq6nZkYhe6XxVzrQx2TiwCudNyuo006pJjIO4107lJ73CPurRPGZzbNAPcvnF1ITw3BChW0UDC9jl5wvmlEEvO9yQTu/BCEe+AXx+JyR8mDkgkDH404Ah1EbEdF1xXFZAgWNh27Tqvudnq9YLv2nr9vaUzw7M7PxSq9ua4D72ge0K0npQSFPOqmZhpl7UsbxwUSqo+uwgjVegLnBj3ss4GSeg7RpJ62r728H9thbP1vdQKYqST83q8cj0ym2OqsekFTa0/Tuz+yug5Wg6NPz2gswD1e+A02U7fqLAnrYxYGbpNsScbZ0MkFLtKHOoGMr/43MLEZ/RqcyFv4Bn/I/V1Uk78OWdlcQloWI02
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(8676002)(41300700001)(8936002)(83380400001)(66946007)(66556008)(6512007)(66476007)(6506007)(6486002)(4326008)(478600001)(316002)(9686003)(6666004)(110136005)(38100700002)(82960400001)(86362001)(26005)(2906002)(4744005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sx0dvsHPVut3kcccDvo1anykPYykIcWINbaXdO51p6UO+Bffu0xKC7twOLs+?=
 =?us-ascii?Q?xov8E/4EizxHgYkbKCLCLiHUdJRp9Hdzfiv7IOp8gX7zeuiZo+lulBR2CMl6?=
 =?us-ascii?Q?so+RjhHii3vNln7WxMnyGyQn/MxzuKims0DN49j1D60vcYyqcGKLmmRe3iQ8?=
 =?us-ascii?Q?Yzj8uzoQ3UqNvi3sq/EBo29DZHcAMzm95b0eEJWCyGXEyGUTLIP/TRvvtZaq?=
 =?us-ascii?Q?7xhiUNK4CfxLrEk0udjERkuem3Up74nKz4yp87awvDuXljOBUybwrqa2VNMR?=
 =?us-ascii?Q?Iq+4WQya7howmmKlg2nRcRiy//po9S5MfjwcI37clZZLQ7yqXr/0+uqHQRqz?=
 =?us-ascii?Q?HRSidNPmQQ/SwdovJVxENSGVCDtrN4Hw8TzoGh5fnJSdVHgNYazyGWREJIRv?=
 =?us-ascii?Q?ms+v5OawYE9zLFspSX16sk/FhIDutuNKIb3R9SH0hGlcNFtXVxqL6zEBgpUi?=
 =?us-ascii?Q?WYrQ2vu9NLboy2CTUO2BSKIINHFFG7HomlMGAA+yrAg+iiTwqNB+sAJc7P2v?=
 =?us-ascii?Q?+H5DISQZENvMB9w/ALwOUHO4iurx9VTTtWUNGC/yIFgJ/sbmwZfGteKDpz+q?=
 =?us-ascii?Q?+3LrQyatHFbmTvmCce8PEZKgKZBIuGYPx+juMy4+BzdpQ17oP7QbujGxXZvx?=
 =?us-ascii?Q?zBb8gcSurSm8B5ekaPp+Z0BmMiFp3J3XNRJngt+obMRdjBoy/Nsq8hdX+AFk?=
 =?us-ascii?Q?W+U5iyLe62VXUkSd5GiXKholPOh/euobe8RM513mtWpEDCbZGNx7Ofclb70O?=
 =?us-ascii?Q?OGJVWQ8AmHiBPs6dnQAtR4nJm0aHtw2209nbtZE8A/gs7sn60mRpJiLnpikI?=
 =?us-ascii?Q?Z3VuHFEkwK4T9AKCY1oFCbwDCRi1cm7rOks+CM/EFC9k5cSRKudek3J2rY9h?=
 =?us-ascii?Q?aJp3nCb+IJIs972JeaVr1L7IxHUt4EVlRJWfEB+JYZJ2bWIILxmKUBtLHM9F?=
 =?us-ascii?Q?a1DL8NNW36kj9uayTKtB8ZEruG9CepeXn/eStkDvVsZttRjDd/jZijW7rGj0?=
 =?us-ascii?Q?X72xsc9Q/BlAiiaiLZ26LD0J4v46HqmJF8XbshXKXKpTcLI3vl66fR8PSsr7?=
 =?us-ascii?Q?jd6sTwEDAuvAsoS1pAuSvWyXHBtc/6H8gQ3YwI2yfqq1IS8xJxltgBZ6PWs4?=
 =?us-ascii?Q?HJnB6L/v7SOqOhJmz1QRldVISEeOotrRjSVCG8iJR9PHBBjU2juok+66jjOs?=
 =?us-ascii?Q?arFu2gKXh7S3mgoqJbOBdFMuHB3swT2agJCjh6p5XGXeTEL87g5jwU4liJrA?=
 =?us-ascii?Q?6p7EJvf1FD8R+h2AsU0A8GlfTqQ/1Nk9CBkfI4BYapL5JBqQZZuoBs579FMu?=
 =?us-ascii?Q?T7RI4kra8VoTmt6xAIrwFdXupt5jMjdPB86bh9jhMTYoo5gG2Q0+Q1fhy3Sz?=
 =?us-ascii?Q?D5bqJbu7LaAQUpB2gwzFqFp2zHugq65A7j7C0JejsQ1a+OvKLeT52EQCGXNw?=
 =?us-ascii?Q?9jD6mfehgJhzwr4bRfc6hPFKigKcF90APCxGjoLFDk3wTndQFYEZxfgryIUk?=
 =?us-ascii?Q?NRiPRthg6twRtlVb3Zo22nqi4T8y+OeubmXRXPmvDQt51DqewgdjJN1PdmjS?=
 =?us-ascii?Q?5TanGORLPZjBSdE4aqUeZSst8ScMtaKRe23oMK4Ji0SWtIMT5LkoyYne82qX?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: caac434d-874b-466f-bc78-08dc2cc140d0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 18:26:10.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UokTMIvLbtbtlxwhu06II1Fs0OlDi3XP4pwEcmfj+R0w4nWO1xxFe90RuJbNbiMAJYxOQqBYUVBEb174JPvDgNYH1Xpi3NPlXEd5/MmalOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6527
X-OriginatorOrg: intel.com

Niklas Cassel wrote:
> Hello all,
> 
> Here comes some minor AHCI quirk cleanups.
> 
> 
> Kind regards,
> Niklas
> 
> 
> Niklas Cassel (2):
>   ahci: rename board_ahci_nosntf
>   ahci: clean up ahci_broken_devslp quirk
> 
>  drivers/ata/ahci.c | 32 +++++++++++++-------------------
>  1 file changed, 13 insertions(+), 19 deletions(-)

Looks good and net lines removed, nice.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
