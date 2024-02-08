Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F49E1DA2F
	for <linux-ide@vger.kernel.org>; Thu,  8 Feb 2024 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417449; cv=none; b=OCSkb9uG5Rq0zatIjKjAeGz/LFrRVQu6VvFzN581gaRmKH+0PBD4kdTN5dZds4AnJUNgEaYiUY/BylXycOUUNwq6lNbLAC2aSijvCxFWwoEhHTBdYF7uq5UtfIkSphh4/4gOkqdbqZRZFHlTNudxvI2uSKHLUB3yMBV3fwXYaF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417449; c=relaxed/simple;
	bh=TVM5yl0qA8js6hS+yKnK0nKrrOeE8hgR0HXZPV32EWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jM9zghO2bKaE4nxcTlDjI/38GYAmWftmiKdpNOgm7k7AFanks95+iBEY2Z46RDi9TcS5wceQHgUvyPFz/AHtvKVlnfpg7ZlPE1VYQx7cyjAUxnKCw1ubH+aiHvWwUrAMNKtDwJhM1rR6xyjr9PMeod3AsNnwGA2qV1x8J8VIEuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QinOxiS5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QinOxiS5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707417448; x=1738953448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TVM5yl0qA8js6hS+yKnK0nKrrOeE8hgR0HXZPV32EWs=;
  b=QinOxiS5blJCZV0meD6Hf3VsS+lZ8T66tAjknTWyeC2SEsTlYw+cfYKu
   Vuk8NHIkLP/g1Z5YhAMtCVyC4xEoTm/9juvodykx5CEIL3HYex7PfB6wQ
   1ve+WuKx7vUncydlOA1FRNUeAEgVNDwSXLVE0QCWVuts0c/Tr9qvfIh/w
   iHq2fHpqvU0b4QKyrKOoPi1IjyuySOhF78dP45F5vzkoDi5ANdmAFr+6G
   /sRgEvnY4bmpMGkXMzrzeSu4pHisFo4VKF+dhBKHT+GV+wOrjRptcasMM
   DvWrFfM/mFvVUMSsypVy6NUcgUV6AzVpXJaswA6NR+8DQwBFJaJfFGsi5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1183801"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1183801"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:37:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934213122"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934213122"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:37:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id B3E9586; Thu,  8 Feb 2024 18:09:20 +0200 (EET)
Date: Thu, 8 Feb 2024 18:09:20 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ahci: document and clarify unconventional intel quirk
Message-ID: <20240208160920.GT8454@black.fi.intel.com>
References: <20240207091054.1697236-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240207091054.1697236-1-cassel@kernel.org>

On Wed, Feb 07, 2024 at 10:10:53AM +0100, Niklas Cassel wrote:
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
> 
> While this quirk should definitely be cleaned up to be implemented like
> all other quirks, for now, at least document the behavior of this quirk.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217114
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Thanks!

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
