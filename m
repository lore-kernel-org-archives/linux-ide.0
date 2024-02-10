Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B421079B
	for <linux-ide@vger.kernel.org>; Sat, 10 Feb 2024 06:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707545107; cv=none; b=ID/rBcrqu5KyK9VssAgBhnjcFCZGQ6cuOLRIVAnaxRlX962QcjJeQ7dhIBdTTheHXOi4gzzFgvuIDuZ4oqQ1EuhOtCbNyZ2GDFKAfG91bDfDtvhIHPre/uWD9uUwWWbHO3khmGKk0QY0toQkQJiqiRGInL1bU96kitlxW66oiQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707545107; c=relaxed/simple;
	bh=ta09q+hu+Hqub/Q0DBr7kiVCx7jV8fhw74qTrnk/apc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWvC/R7e/42go/QAbMhcs+3sNnO/7Vqe1rxu2GAidgiqfjH2f4g7wMvMECCI0SMkwY6YoNrcZxroks4LZcJGXzNc8WZa5mbcpFgMA313KsipvqUdeVpWE1zTxLYqwdWvVCNwuJGHD9mI75cB/GVlkjvFD+wbTrWoz5nX68Oz55o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NyT9SgVs; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NyT9SgVs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707545105; x=1739081105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ta09q+hu+Hqub/Q0DBr7kiVCx7jV8fhw74qTrnk/apc=;
  b=NyT9SgVsdvkpVHKUB/QrlMraEzlj5lbmwV//HWQsdSp/RkJIqmpVgH4O
   dPU4K9aPq4ugyyrVA1n330rstF1EzIIF9seQ1ta3wP/SCGtxWaihy6Zmw
   z3W+aq1unweTODluUa17SDUwx+fX1uP9Of3HbumXFFhy/YxIhPri+InO6
   u139zWpelaykv4cKCCSMsiZwIMTfOC+JiZuqn8roN7n60siaQYf3ghFpm
   FFMiPsL/eZHeVd3Ot1dBR51Uue9ZSY6Z/Qxv7sjpenLkD1K8mODztwy5v
   2Y2bKFAmJsZrgPwxs/OfwVfGeMHLiefPK8YxOvTZQPyrokpthxPzfusgi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1427878"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="1427878"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 22:05:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="934615672"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="934615672"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2024 22:05:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 4845B17D; Sat, 10 Feb 2024 08:05:02 +0200 (EET)
Date: Sat, 10 Feb 2024 08:05:02 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ahci: clean up intel_pcs_quirk
Message-ID: <20240210060502.GW8454@black.fi.intel.com>
References: <20240209130307.39113-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240209130307.39113-1-cassel@kernel.org>

Hi,

On Fri, Feb 09, 2024 at 02:03:06PM +0100, Niklas Cassel wrote:
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

Right, I think with this one we can actually just drop those "modern"
entries and use the SATA PCI class since that is also "board_ahci",
therefore there is no need to add any new PCI IDs to the driver (unless
it requires some special quirks).

> No functional changes intended.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217114
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
