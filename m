Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4084716439
	for <linux-ide@vger.kernel.org>; Fri,  9 Feb 2024 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514349; cv=fail; b=gtRrYJyzaN1EJBzlFnO1K9NbXuqGoYDOf+RHFl/MUU3N9cxPqkLUw/ewZqhoVwSjkw7y9pEpSE1QCwaZwtv5uZUC+eb+0pOFgwD2oW9Ca21Czrv9A87uhe05f9n6QPRJERYh7A7lmMFdDIt1dkLzWvQ4ygPRuH0o4eNO8ZSN+6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514349; c=relaxed/simple;
	bh=G9NlEXdBmsHa7EuE17YY9R6Gf9ZAySRBaIZjzlR/Z0I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NzgBF0ky0xhUuoxh7ZeVpRDvjZGQIy9usyaC6R9nuvkOt+W9iW+fMRZ8OOuQeg/N9cG2zVLSOCBOuyoTfj5Vgz1Wyl87BfcxMTp0BaLMZX3tYUllNpuus1V6ZgHEIpZMlExpQNIp6hfRbHcLg1wGb3PwYoBFTDTIrUvm1wAATaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JlYwTtSj; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JlYwTtSj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707514347; x=1739050347;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G9NlEXdBmsHa7EuE17YY9R6Gf9ZAySRBaIZjzlR/Z0I=;
  b=JlYwTtSjUIyMG55M2jK2al/c6zBxjxprM8BjN16+ztt9hkobdIGK/qQ7
   yJvhrCay1cMCNRML0k3NCRSs/Czz/C0w/AqKSdQ619o+XLpBIcEvLg71X
   DaYr4bVXJiWGT06mpI3FXgxfjxDtPw3r3yRtknUbYPXM/U/XBZ3T9J00u
   mlaZK0Xg278qtEVCoZ1q3S0BstM42A8ud1pTGlHHuF63d7TFEIb79O+C3
   VzXdGPnV268Ve+5nsan/0UDjXS6zMm/D+HHxCBELuk8S1vdf9zf2RguDx
   K/ugtzAZ0HNW037j1hvH3XWEXG6PhO+NX2okbNRxrpeQgiG9rkxBbsHWJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="19009250"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="19009250"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 13:32:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="934529265"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="934529265"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 13:32:26 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 13:32:25 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 13:32:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 13:32:25 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 13:32:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6CBBp85p1+yGhQRp/WWLLc/RKxDE5thRQbSY4DCCUenoU9nMGuIJlUVfTYgVOP53vNIl+kdIWAB18wqJlY+mxlU9NbySvkK0N1Q7GIByHKd4acBy6C5QFbz/HBx+47IjBLPRyq2VB/b8JYyNO3u1mlZ0FDUOJPdawCE6MeGgB5Q4aokeeRMnL6QGHLJj/R+8mphqAZw6r6HGHbt5eIBV1bdcomWfZm1ilYHY5X1AjH9IO+DZwKnGB7SIPOp73to9NyVdHonRXeYj6XoVV/a8uVFDXoxvh2LMUem/RD55mZgmwog5xVGLe77smOoJDQ61AsrauGtcXwFRo6Va4voEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TA335u7mw7M0AsiQFlIimI04/WyuUWBMw/KnRamSLKE=;
 b=UqamDO6MG2vKe8klmEXdqO0EJBTNGcfHZqNRXCQyl3hkpDNirkRTF/i2gLvJmmYcYwC2RTvd857S0Yy5AOPIQC/o7JXR0/ayw96xixAxo7lA+q0R5cOTSQgqY5G5yQXepQC7wy2SOH3L7sNwu5xz/79XBF1rVL+cE2PgqV2PmBrXELBhACSB07ohFYhJMtpgOWm5fUCXWKwNNABPPJbPJPqB0pIVhjeO67jOj2J8yH9h5Gr2fnpDXyyu3Y42qRqC0UbnNi+doJg3lUsF4LsaP2ISErwgZ74v7rnvC4KB8taaMy0yJs6zk7k+AU+UNpWl8biLIsb6wJ5s6LD+d1uMNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Fri, 9 Feb
 2024 21:32:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Fri, 9 Feb 2024
 21:32:23 +0000
Date: Fri, 9 Feb 2024 13:32:21 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Niklas Cassel <cassel@kernel.org>, Dan Williams <dan.j.williams@intel.com>
CC: Damien Le Moal <dlemoal@kernel.org>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, <linux-ide@vger.kernel.org>
Subject: Re: [PATCH v2] ahci: clean up intel_pcs_quirk
Message-ID: <65c699e539ae7_afa429433@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240209130307.39113-1-cassel@kernel.org>
 <65c66d85d0a67_afa42948b@dwillia2-xfh.jf.intel.com.notmuch>
 <ZcZ9Qg2NNVZXt3if@x1-carbon>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZcZ9Qg2NNVZXt3if@x1-carbon>
X-ClientProxiedBy: MW4PR04CA0385.namprd04.prod.outlook.com
 (2603:10b6:303:81::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5ed057-3623-4549-a5e6-08dc29b69a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Or4h6F+uEcibmXhO5LNDTbFeGyP2m8h01acgGmVH0Vpi6qLyKr4z2vXxdsR6pS7xp+GFFPy1Dq98bQnH9Ij61R3nlS+m6ecjRNbwFyarDjWYQDOqzGMI77/kmEtsy6ev/Mx25rekWc9TJ6z6gSDaBchcCZHDjVjApbjEsDP4IHOxj/oKFV8ByFwZGRxx4BU5O/FiB2iYXXFQ7gLjpBlyIw7ukIjsht2ORVhDuJe9o/Nu7xphhTAN6qOZmGnH4440S7KmKWwK7Bg/dW/wNLU/GsM0XI5N5Ev+cP3h9TucEB0T4S9AcCaGvCZX5MSwutGVmBOz2sciuw54bKwI0a174NZXc9ak0/ypnl9qJyLzgpUXeEKGFUFkJrFyc9lqqZ6ohgMbyMkzWO+U6rsXKd269sNIlCI/vXH5d/p38XlyFTrtMvL4RQ59EjEZfJrM0xbrTEiG5Ts5w6EeKQ37N27qMJQd4rvI6aGXiNSPqlNFLx00pPLzAf2cTJ/VwRddXL9cDD7FjV6xqj1IzPqz0L9N3XLW/wWRj+mH9WDwmXfVjyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(366004)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(110136005)(54906003)(316002)(41300700001)(2906002)(83380400001)(26005)(82960400001)(38100700002)(86362001)(8676002)(6486002)(8936002)(4326008)(66946007)(66476007)(66556008)(6512007)(478600001)(6506007)(9686003)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l0G5qC800BZgQy6gzsLM0uqQXEhS1BcIXwFzgjB/ebV8T/Z+6Jmo22BNIdv8?=
 =?us-ascii?Q?yKt64gYU2kkMMaQP9J6cBO/1x0SnOhweZd5eDiQnyl0ZgOQepnjPO5qPHZWB?=
 =?us-ascii?Q?7WOtnp1NnkN88cui8whJmKgCBCowZGtITWMVISNtAVIplATZlBDdAfFuMv/J?=
 =?us-ascii?Q?KMsPAw2jLSgEe0j6hdxuHHQDIKtPsyXLK7GQC2sySMhw1hrXO7653tw7jArM?=
 =?us-ascii?Q?BoOgDkwN9O5pR6Jm3cONcEg/aSBWi2ljtVgukWkL/Tc/02XLvQyE8kJOYFwK?=
 =?us-ascii?Q?bEX71kMkmK0NOdaBGU/hQZF/h0InuuGGL//mNj49lrtJF0ELz/XL48eRx/dH?=
 =?us-ascii?Q?bhj+PRKBRfp6wPzES3STyjAuiYcSJOOw3NFd6CoVdSFvOut+/VpJQ+QSyJl5?=
 =?us-ascii?Q?6RlgNrDKrURGcm+HFe/PK5aXlycyqz0423CUPnWjqAdEx4jyIJ5N7cyXiIEi?=
 =?us-ascii?Q?eIcQU80iQexBiTQBKkGgvMs2SnoIBcZO4AIc8qbdyvIULryEvSzDsS/2yojH?=
 =?us-ascii?Q?aUeNMMkMG241VR0diobDmfhMF7rA5aez+MfpM4OuflFeHzCJZ+0viePUN8OZ?=
 =?us-ascii?Q?4c9h/dN9dwtjHmloGQ4KcBtryjF54gC7Mmy/k/d3jfysiYUcTHIECd6xJ0NS?=
 =?us-ascii?Q?8aSgdmZS8nn84YAuBel6Go9NedoNJq5rZ6FhhGA9RhOKjuYf5f0bvA5QPb+o?=
 =?us-ascii?Q?I0pOTowsKumd2lotXrQDu9A1inzQWSFBAxUJ3wxTOzlx7Hxc4R6MsCobF/sa?=
 =?us-ascii?Q?SOdjXO041PCA3zeGWDtRlfK8Ybl45HZCXXiFeFaGPE/m3F13GEfWgC+p98es?=
 =?us-ascii?Q?mg1trQhFJU6xloiLVo3DdwtUfNbx7y2Zci7eGtnGnUHKU4cItwTGPapQ9ts2?=
 =?us-ascii?Q?mo9L87xAaak2slc6Qq1YAzhPOssJwGbqM+aEiVq6gz8Bw5Yh0HEKtTmZcjNQ?=
 =?us-ascii?Q?hd6ML8Frwfntjj3n3EvHMtnIijrnUzl6RUBO9eIMmFR/YF6FxRcdl6QJkntn?=
 =?us-ascii?Q?OIeO3tgqAfYlfKjnrC0MhcaJj4Zp9G+jakZMaftwzu5J7VprFx7cS9Q61EX0?=
 =?us-ascii?Q?BL4RJicZoOCAa4OIknyCbENStycJbethxh6dqGdjEATsW78DoHNI8IKhzlOL?=
 =?us-ascii?Q?4vVhmnXLG00w1nqqxG7sXNsxyg12nJWXjIxnuhH35HOeKGDf3mTNJWT4WnzC?=
 =?us-ascii?Q?phNbtv7GoFAUYhrruVUv6hcwn7/L4atpIC5vECHPYtcPs2zmR05jWSiUepr2?=
 =?us-ascii?Q?dOOItVj/551V3QaKm19xRaiZwDyXo+rGX66wRWuStbYxJoz0ftP0oiHqc02U?=
 =?us-ascii?Q?bM3WRf6KW3TSgUTromb55uPgrIiHdyWfSKvqK6Mi6TeazQcn9iKjS/c3zNZK?=
 =?us-ascii?Q?oJuCXxp0wbULQF1Zg1AUw+roB6OSLRVyidK3ztvO5b7yT+AAOJevYkgGOBrI?=
 =?us-ascii?Q?s/mBqUcdPc8FHXKHXqR9LzEcsQX8dneFIGsdVzYQQVToaHUeOZvwlmOsej4t?=
 =?us-ascii?Q?kMAnXhGURTTaIPDMvBZiTzjzDMdysE0/YM9uFH7+Y/7WjWOdbc6kdZSoVQ1K?=
 =?us-ascii?Q?zsH9MUFP11MWZVfoPWGDe6LhO9clzV76GHQhVcuH+BMHRn+x83gyKH6gb58n?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5ed057-3623-4549-a5e6-08dc29b69a38
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 21:32:22.9493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W21yNt5lEvCPGwCaAA21c+mBtpZaSQIXfO7l/9nTwhPT7PVsz3GZuiRRdvRuf4PVd2CBLxZW/ABiTMYF/kgwWiyVtnP/PnypUljTOwmczcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5987
X-OriginatorOrg: intel.com

Niklas Cassel wrote:
> Hello Dan,
> 
> On Fri, Feb 09, 2024 at 10:23:01AM -0800, Dan Williams wrote:
> > Niklas Cassel wrote:
> > > The comment in front of board_ahci_pcs7 is completely wrong.
> > > It claims that board_ahci_pcs7 is needing the quirk, but in fact,
> > > the logic implemented in ahci_intel_pcs_quirk() is the exact opposite,
> > > only board_ahci_pcs7 is _excluded_ from the quirk.
> > > 
> > > This way of implementing a quirk is unconventional in several ways:
> > > First of all because it has a board ID for which the quirk should _not_ be
> > > applied (board_ahci_pcs7), instead of the usual way where we have a board
> > > ID for which the quirk should be applied.
> > > 
> > > The second reason is that other than only excluding board_ahci_pcs7 from
> > > the quirk, PCI devices that make use of the generic entry in ahci_pci_tbl
> > > (which matches on AHCI class code) are also excluded.
> > > 
> > > This can of course lead to very subtle breakage, and did indeed do so in:
> > > commit 104ff59af73a ("ata: ahci: Add Tiger Lake UP{3,4} AHCI controller"),
> > > which added an explicit entry with board_ahci_low_power to ahci_pci_tbl.
> > > 
> > > This caused many users to complain that their SATA drives disappeared.
> > > The logical assumption was of course that the issue was related to LPM,
> > > and was therefore reverted in commit 6210038aeaf4 ("ata: ahci: Revert
> > > "ata: ahci: Add Tiger Lake UP{3,4} AHCI controller"").
> > > 
> > > It took a lot of time to figure out that this was all completely unrelated
> > > to LPM, and was instead caused by an unconventional Intel quirk.
> > > 
> > > Clean up the quirk so that it behaves like other quirks, i.e. define a
> > > board where the quirk is applied. Platforms that were using
> > > board_ahci_pcs7 are converted to use board_ahci, this is safe since the
> > > boards were identical, and board_ahci_pcs7 did not define any custom
> > > port_ops.
> > > 
> > > This way, new Intel platforms can be added using the correct "board_ahci"
> > > board, without getting any unexpected quirks applied.
> > > 
> > > This means that we currently have some modern platforms defined that are
> > > using the Intel PCS quirk, but that is identical to the behavior that
> > > was there before this commit.
> > > 
> > > No functional changes intended.
> > 
> > *crosses fingers*
> > 
> > > 
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=217114
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > ---
> > > Changes since v1: Just do the actual cleanup instead of documenting how
> > > weird the existing quirk is. (Simply documenting the quirk would not have
> > > stopped people from encountering the same problem as we encountered when
> > > trying to add support for Tiger Lake.)
> > > 
> > >  drivers/ata/ahci.c | 361 ++++++++++++++++++++++-----------------------
> > >  drivers/ata/ahci.h |   1 +
> > >  2 files changed, 180 insertions(+), 182 deletions(-)
> > 
> > It's large, it's noisy, but I see no lies here. I think this is the way.
> > 
> > Acked-by: Dan Williams <dan.j.williams@intel.com>
> > 
> > ...I wanted to give a reviewed-by, but this patch does not apply to
> > current mainline so I can double check the result, can you share the
> > baseline for this diff?
> 
> The for-next branch of:
> git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-next

Thanks, you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Now, one of the implications of doing this proper fixup might also be
that some of the other open-coded quirks want to move into ahci_pci_tbl,
like ahci_broken_devslp(). Otherwise, I concur with your "No functional
changes intended" assertion and this looks much less error prone for the
next person that wander in here.
