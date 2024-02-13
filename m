Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E05FDAD
	for <linux-ide@vger.kernel.org>; Tue, 13 Feb 2024 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839786; cv=none; b=YwNkRxw05QWqGlYRLsW25aCeAzAvO1BYu9X2+byoDipEn+Em5pShHd1Zs5A0fjQF55/mcuZ+u2CMhh7Aax6lLBEaUELzC4YbH3F4xf7iKCoS/S7vV/W/QJm/a5n8zCFknQFYGQEILmyOKfZQ53Gh7SB/YSqeCgWuC3eWIC8Yu68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839786; c=relaxed/simple;
	bh=XpLXI0LnBTNIqQNfJMeVnhf0ylUcgKeJkCbWR/RYJ5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lN8vEGXC05ZuJi6avedb3+iZnPu/JQqaocFOmEGu+kVaY+jWz+hBH2Yrpol/h2FjHGbDVSxftMumRiMVjK/RJGJDPJp7ku93FX+dRdWtci08kT38+65rA3O+29NuTVi59JzMn++A/0wCMWwphAV2uX4eCFRPJycNUpJsceoyzGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jBl9HbgU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jBl9HbgU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707839785; x=1739375785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XpLXI0LnBTNIqQNfJMeVnhf0ylUcgKeJkCbWR/RYJ5E=;
  b=jBl9HbgU2pPtkwZRqc4CpL/g3UlMceyjlAnqdhZAmruscQNL5+cu1MoC
   1Ej3zLtottMqkHdVgrGekt6FAacF/tCFMu92RA9YiXCfTFcsplyPZkSpu
   yCtZQ9Xu8a6npFjY2e+D8O/gz8Y2J9fuaJLTn9yEUUXKCk5dgX84Bkwti
   SZhjRJogQ1frp1CpfbZ3Rb6ZRyKwy1upq74toQjyRZcypHoPmiYnPv75X
   1US6aJBGYiKwKTbzpL2LAtTgL0o8nj4S6GMpb3S1WoX4vvZv/lM7M5ER5
   hhCnoGFCOIcXg37A1s0D24bgkkcnTarv/pEJdeMHoM1Vu6l0XRNmjlxMH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1975393"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1975393"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 07:56:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935375578"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="935375578"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2024 07:56:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 56634184; Tue, 13 Feb 2024 17:56:21 +0200 (EET)
Date: Tue, 13 Feb 2024 17:56:21 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH 0/2] ahci minor quirk cleanups
Message-ID: <20240213155621.GA8454@black.fi.intel.com>
References: <20240213130733.819524-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240213130733.819524-1-cassel@kernel.org>

On Tue, Feb 13, 2024 at 02:07:29PM +0100, Niklas Cassel wrote:
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

Both,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
