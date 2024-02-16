Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33FE5C609
	for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2024 11:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082361; cv=none; b=WoCDNjN4mY8jfF8Je4Ks1r83cLrl37wzjmlos/+18dUWfwz9m7PS6OPxjNAaIuugom0lBdasQs/6mGVxvLk4RElrXNbRaPbhq5jfYmMM7xHrwhY7unSAqBnSrgdOGq+XTFEPLQ3LuLF7IP7ZWu+Q9xBJeev6KBbuzFQEHQqEYXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082361; c=relaxed/simple;
	bh=pdta+1mBKNZLqejav2pehFTUS/hJbv5cCLOpmGdZHS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEJ0+dJkEZid2sSRtIQlFaYWVAOUzQm820XfSbZx5TBoQtphSWp8pM2sasgUqA9EoJOlTyJGlhINjtIC/7QMbUPSGlYUt8Hhk6OlM/t5G058ys1acME7TZ6WKjZyfUAhA4HH2me+SIEqegGq1g7zRsxGbGm1i9efoH/S6m0gjr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aw1HlxLh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aw1HlxLh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708082359; x=1739618359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pdta+1mBKNZLqejav2pehFTUS/hJbv5cCLOpmGdZHS4=;
  b=aw1HlxLhVnxEPlMamhNnLhbURqN2SjTy3lQ4aqI4J9C5mI+oc0YOceTR
   nVsUJ+vFh7lQykxCkQsWDiuV87H1YS/cTiWwhPmcKHr1u0UlxiQag/cAJ
   Q6kr8J5MUSvJIiFmZIR+WOUc5bTqihlnmebib7qPClcqAlkGvPwlJbCZh
   DA4N30hosz8Hr00c+z/onf3EZqiW27CHP5R1Ducd6dEy9qZSntBwd2uYe
   8HqpWKKjez4LWjIbz08zyV3F8KiEt/xL4TWRqZjFpbYiX1+NrNxUaKwtu
   nDgdbk0MHb/aLxJ+NM5GZ9cgjPaimMr/7RrXnl2M0qeAv/ZP8aVncWTuN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5985136"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="5985136"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:19:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="935834704"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="935834704"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Feb 2024 03:19:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 96D6F268; Fri, 16 Feb 2024 13:19:16 +0200 (EET)
Date: Fri, 16 Feb 2024 13:19:16 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 0/4] ahci minor quirk cleanups
Message-ID: <20240216111916.GQ8454@black.fi.intel.com>
References: <20240214130015.952685-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240214130015.952685-1-cassel@kernel.org>

On Wed, Feb 14, 2024 at 02:00:08PM +0100, Niklas Cassel wrote:
> Hello all,
> 
> Here comes some minor AHCI quirk cleanups.
> 
> Kind regards,
> Niklas
> 
> 
> Changes since V1:
> -Renamed boards to start with board_ahci_pcs_quirk_* as suggested by
>  Damien.
> -Moved the entries futher down to keep them alphabetically with the new
>  names.
> -Changed the order of the HFLAGS for the boards to match the new names.
> -Added underscore in _no_sntf to make the name more clear and to match
>  board_ahci_no_debounce_delay.
> -Added new patches 3/4 and patch 4/4.
> -Dropped Reviewed-by tags because of too many changes.
> 
> 
> Niklas Cassel (4):
>   ahci: rename board_ahci_nosntf
>   ahci: clean up ahci_broken_devslp quirk
>   ahci: drop unused board_ahci_noncq
>   ahci: rename board_ahci_nomsi

All look good to me,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
