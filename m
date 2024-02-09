Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B4364D6
	for <linux-ide@vger.kernel.org>; Fri,  9 Feb 2024 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502992; cv=fail; b=XgxUANDwS0wQD0JjUsd2NumiTh+klWfN42PBBPYoshJteDLJKWJtw2Y+Hzlwrort6lqZE2Y3Vg560zaVplSc1LnH6lRmsFALKvXFX5PaLWyfmh9XlV6vko/YEFp71NV9zfMajDQ/PNwG/xUk1A2/vu8YWY75ygcJrpJMzAZMe4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502992; c=relaxed/simple;
	bh=rWsI3MjUBSmRe0c7+qZ5/3/TNTNBZjV3AZCNL5NRzs0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m7u1iwWgDG/OOXXq3xcVpWj8KLH3L93Dad4qUMStzi2212V/Y1d5LOY1u93LVOhoZ/55kJfSCaQY95MaT6VWhY+073Tvud1yugpCTPod7Gxyf1/xuwjTMlOrud1o/FpD+49KuqI8X4X6FqlWrC1/prcKDKf1EyMDnmXfTRSulN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwPI+u1X; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwPI+u1X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707502991; x=1739038991;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rWsI3MjUBSmRe0c7+qZ5/3/TNTNBZjV3AZCNL5NRzs0=;
  b=bwPI+u1X7GGUhMd9xc6r8Ddwl0QmE4OPkPJ383vze9mFygS1QjvVljbg
   iBx8qPFhlyRpFMiFUzcX/6vL+IaC3bSkAaO+91IuZGrOwhJzcLv+SKUQu
   aQMt/C5srIbA0rME/Qtdz2rvScxP7NFbBCeGa6/b7eQzMKd+bI9oX0hn5
   Ii/2ILceeKzSNgnapY41sM4XtlyWSu9inzvtM8vz7+vPMewsWaxylNA6S
   h9bAx70PhrOFAwf/CdplVstcoZrpBZJn1xo+GDsT/VRZSrPNG54WRfyGR
   FhQ4F/YbMkLVD14fEUgLJKtZkSkG48skFQe4BTPsjyrtjKorMAwj9ABbE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1612315"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1612315"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 10:23:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="6651891"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 10:23:09 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 10:23:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 10:23:08 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 10:23:08 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 10:23:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHT1QPwL4jT4jN/0gVa0sQYEv78kodZu4ZyzRlCuqlFt+KQnbohEznKhDp2fL4QQnQuHjR2nvQdBi0tlCz35ckB1Xd6wMGUFoNK6RJfFkyaUgUuYV4ObzeS5lMIbXUoDcGsTz9A43QB+Cf8Rx5PrNtQ+nVGM6PmDSUNr481kzaXGCNxsZdwS8/qwtuXBCUXziCc1bJ/x8kmGEcULCqbO/ClbE/66uDzauM5wU9rD6LHKQU14BWjLXIGWJmyFIXs2ZvIWTLtmgJ55JDtgw+4NzS2w2Yq9D86FCC+kqK7KF+7qo1yA1AhKhbyhl3fX0+CoZhotFMbD55X8cFE1l6kPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+K7KtP8eYYV5BmP56R3NDlATavNyMStUEPRh/wTgkwk=;
 b=mi1VFILtsY+ZFoIXzTf/Ngar6ir5PpZuftKor3ASy7n/Usamuk5Fb3oDR7V3jKi8KoPcdwhUFp2x37AvGl+FhLaOkbKFzn/JWAIaY1KHUSI6/iuORxGrDMQu7vuPskB+mEAYUSRKaGwXwssbp+wREUVuhizMjF6BO2gvAAKJqa0iq3xhzp9hEUH73qD96gOqDYiEfNpPLWX6K6iJOCuDI9mQcAQQaM8+35jB5qLRfNEcZAMTbsUp5lcKKtGdWpRYfwcfp3PiE83QjcQ9lLROlkOCDW8L8I/GkBk5THfuYcS9p0vLFNwVvPYvtHuv7bqWbg1XZqXbi07gR1WNLzM8HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7152.namprd11.prod.outlook.com (2603:10b6:303:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Fri, 9 Feb
 2024 18:23:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Fri, 9 Feb 2024
 18:23:03 +0000
Date: Fri, 9 Feb 2024 10:23:01 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-ide@vger.kernel.org>
Subject: RE: [PATCH v2] ahci: clean up intel_pcs_quirk
Message-ID: <65c66d85d0a67_afa42948b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240209130307.39113-1-cassel@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240209130307.39113-1-cassel@kernel.org>
X-ClientProxiedBy: MW4P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 15cc0c0c-857a-44f0-1615-08dc299c27ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFsPe77gbfprR5QFOV2XbPZAaY8JprHIn2XYySYLVXemutkCFrmfUJ3vzM9jbrrk0aXvynKLgz7V8dPvNJWqdSp6Cb2AsNbU8YpBC+airzTRyRIjiGexeN83zzOy8/rGDaYQHErPSLn85KDhwVbvT/0qZWsNVgPM18AwWFMnKMwuMx2dD0Eps1JFzfSpI7R7MrXydfQL6fQBmXXgIibwoWiJ6VIJ75eeBptlrwZJMtfg2Z+X8HXWFKZq1MQPZhdSSVkesLagfe5sd1u5RA/xxs2VBet2kRE6WMeLqeKCx7T4bk4WJ51X9HrY3uRsQzvNzvqTevVnz8MCgAVt1LWWjs4xg3k31SjFehuR18LdWz4UDZibN5Aua1XchKYXASf3/0NnRkSQUy5fim6+SQM/2O6d6Fk5n4Y7LI6Yb5SlgFY24JkI3afZ8gy1XrFqABD1ERxKhtt9H0vUn7TOcdQQgLY6Gmxv4rI5q6ozLUQsKEvO0gRcJVpgHjLxvTlX/wjrt/aX+WSpi+iHkLr72yD3WZ8Qi8/DW7iCz57uxzW6RT4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(86362001)(54906003)(66946007)(966005)(41300700001)(6486002)(6506007)(9686003)(110136005)(66476007)(478600001)(316002)(66556008)(8676002)(83380400001)(4326008)(82960400001)(6512007)(8936002)(38100700002)(26005)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?czbwiIv/iTy6iLxakg0lo88V9yXqjIpQ7m22gNac4uWtodcWv0UTXhrlEJHv?=
 =?us-ascii?Q?IO3OL8OcxMVsH4DYdXgov8Nw7s1qEc+VpDZT2oBhucIP8a1FWa2b25jLFvvR?=
 =?us-ascii?Q?ObSsDH1WD7DfQnnt+TLb+YyN8Cb0EEUt8ce1Cym98ldwhrWUsQCkXG4cIrXi?=
 =?us-ascii?Q?LDGwygZ+abqEfB1QmCoBi8OSzOoxJB3fk8/3ln6Bhg+EQRDEXYD/OCik1GAe?=
 =?us-ascii?Q?nlKHSjUIf+a50++92mvDAMdb3nqIzn7E+7fIBL5lJXkepDE3aOfQroFeM13d?=
 =?us-ascii?Q?lHUHdYnEhUlJhbXpaQ+O5WHu36TxSwLF9cvlxvY5lbykP1VReY/joVskkS+6?=
 =?us-ascii?Q?dDhB9qM1Vr/zo7p9QuMpgammGxBrrJ6TN1N0M8Zlx09MMeYCuTQcR7n+lRca?=
 =?us-ascii?Q?ugKf87TwBCYp+LheDlUMlKKGqd5zcn6CARCbsUtneT2JWeyBW4JuPTrCYMAA?=
 =?us-ascii?Q?bEByXay4pYHALAmvsKvHTohzVKD7hrF1dpbLnRmaycR+VYzRTvOmo9Dja2Cg?=
 =?us-ascii?Q?Tu9WBDC/9lVgcU7mkY50YN+HdJnlaXYvlfqDSL7J0XdzRuqwpUsankZu/sIV?=
 =?us-ascii?Q?brN5X2qJfRTw9Dhz8IQeBlFEZFi0SzBV20Gyk26zNC/tuDjwQ4kU7bkC81Pb?=
 =?us-ascii?Q?0imv20tg2dW9vg8VCKOZ8QrDetrytXF1SgBxVK2jO//mee7Gxz+ZW8kqRi3o?=
 =?us-ascii?Q?U/xg7zb1v/NkGUnsoimxPZvV3FyCD4N87KA9PtIoUiWJrx6lyk/MAZqcHbbr?=
 =?us-ascii?Q?qJheRMP9oZRB6eyXf1Ggs3CLthzmzKO7NUyFidrhzpIiNmg9EaAL+vx5dsdj?=
 =?us-ascii?Q?VZqzAZAO5zkSSiPiIX+yBAIuG5Pgt63ggSMGgJj3Zy4dGtO1+BHBetcCErpS?=
 =?us-ascii?Q?h5DRjfXmTP+LjvVI7A62BF/nmBMr29TpFw0WfoTFPyY+koMCjvenFomp/H5X?=
 =?us-ascii?Q?6JhJFd/Mk3CpPhVNxfAGbfjb0CdedPt+Ni05QzXLsNj38qCtC3JKovr6bceI?=
 =?us-ascii?Q?UlHZoVN0P0/HcqMKX+TKYP7eI24OifWtmbRnZaEf719JDN6VgtE7TT4clEcD?=
 =?us-ascii?Q?rBBiHh6wE6bqZOnB7kpcZK9DpQIVcHpJUoJIx7N36rX3/9jIdeqMX25iQ+Yx?=
 =?us-ascii?Q?JTZ9jvSqHnh6LuICaR0dCpgpWRe0vNCwJde51kmNbEktRxLRReMw9yuF2V0c?=
 =?us-ascii?Q?GX+4c8OMlPlHh9AIHA6VeUK4xz0i7YzVB0S1h0HnnEvvnb3/ZKy9xZbQA1QS?=
 =?us-ascii?Q?CShp+4PKs9iTUwiaM66Cs9yKSZfw0rYA6mhkxHMZ+SwHd3P73IPS93E3mN/A?=
 =?us-ascii?Q?mpxbS9abVT1efy/qFbsoxPYBfEUUDN5PLDcUv8FzVyvZnpsx1URWHMfgKWaw?=
 =?us-ascii?Q?5uUThGUQRjFjk959O3wTv2VyVJDEMVINPVQIbLm12Cxa2GOc+1zPadm4OT7l?=
 =?us-ascii?Q?mIyYtkk23KnSnkfxZBT0cwcluAgZUF2px4vH7j3rHw+4ij/AtJkOk6vYGxWL?=
 =?us-ascii?Q?fAfu86VQtfvzvcS8I3vo//ifY7qyi7Y9QWdGtg4V9B/pkNhd9ovStquCzMWk?=
 =?us-ascii?Q?fSqi8tL5G2bRIL/Nfr5sUkLKkQaHS1woGhDNMakruLmxPcWAPk7SbRxPBqbO?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15cc0c0c-857a-44f0-1615-08dc299c27ad
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 18:23:03.8027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmcMJDloa1rBd/djTcBgKhhpYE28KFuwBWJBGW3rdyn+GYVuB9kNTVD8Z8n50c8WDqxX60N5joy1XMJnJt2Z4VRTTVJ4OIZE2kYfB24Ltc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7152
X-OriginatorOrg: intel.com

Niklas Cassel wrote:
> The comment in front of board_ahci_pcs7 is completely wrong.
> It claims that board_ahci_pcs7 is needing the quirk, but in fact,
> the logic implemented in ahci_intel_pcs_quirk() is the exact opposite,
> only board_ahci_pcs7 is _excluded_ from the quirk.
> 
> This way of implementing a quirk is unconventional in several ways:
> First of all because it has a board ID for which the quirk should _not_ be
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
> 
> Clean up the quirk so that it behaves like other quirks, i.e. define a
> board where the quirk is applied. Platforms that were using
> board_ahci_pcs7 are converted to use board_ahci, this is safe since the
> boards were identical, and board_ahci_pcs7 did not define any custom
> port_ops.
> 
> This way, new Intel platforms can be added using the correct "board_ahci"
> board, without getting any unexpected quirks applied.
> 
> This means that we currently have some modern platforms defined that are
> using the Intel PCS quirk, but that is identical to the behavior that
> was there before this commit.
> 
> No functional changes intended.

*crosses fingers*

> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217114
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v1: Just do the actual cleanup instead of documenting how
> weird the existing quirk is. (Simply documenting the quirk would not have
> stopped people from encountering the same problem as we encountered when
> trying to add support for Tiger Lake.)
> 
>  drivers/ata/ahci.c | 361 ++++++++++++++++++++++-----------------------
>  drivers/ata/ahci.h |   1 +
>  2 files changed, 180 insertions(+), 182 deletions(-)

It's large, it's noisy, but I see no lies here. I think this is the way.

Acked-by: Dan Williams <dan.j.williams@intel.com>

...I wanted to give a reviewed-by, but this patch does not apply to
current mainline so I can double check the result, can you share the
baseline for this diff?
