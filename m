Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F4976C9D
	for <linux-ide@vger.kernel.org>; Wed,  7 Feb 2024 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313342; cv=none; b=oWk2WAIRCR9o9P2b+rqRkiw8FWoyQjvYgZFvdvJc4fvhulCVsd6ywyiaXCFlVNEaphp3O5MrzrwNPMWmJTW5PZ8Tzf/a20Is3MI5z7ArFBHBTBLS1F3AJ2MFuhJ767uU3TS3o+/MiiJuslw9sZ0Y0GJ2LacCuVtfKKFYnsLMXwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313342; c=relaxed/simple;
	bh=XhGHWUT4UYfVip2ITziNa2gAEigwHRWG/KnIPbeEFCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cL/7VAhmJtlHtzcgbOghDBiK7D6Hu9pHB/aIFMx+DSQyPXxct/vuY2DO8UF0nsGQf0y76KVzZ46OOZ6Xo+/yGFBtexxfMpd9Tq9l06f9dhecEJ3jfe1F+eUoUa1qhgMYKkmwxZxeWYSLBQHv0oYBlBmdeym3zU1hPkbBZKNP9XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZBvh803; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZBvh803"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707313341; x=1738849341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XhGHWUT4UYfVip2ITziNa2gAEigwHRWG/KnIPbeEFCM=;
  b=hZBvh803PVTlF7eREg3zEswyTHR4Ps1JZNwq0WfgJYpBwKoZp8sfqiXg
   hv+/7+q5xdd44kM14fDYQyOmI/kkhYfoBraTSKy29Ja39e6EP5OArHxyW
   U+R4sRKcD5jxjqHbGTKbSHh8y6ErTHKyNElhvlAbGd7nDbaNrclBwRqDA
   +pdbQJp0jH5WZjkFHPrMWy6uvgzYHm4esbVSaeBIJcRE4+MFVvcAUNIQk
   0pYkpYxSlKeO0IpeFsbAWErzsVs3CCYl6E791OQmQrd/F6kTIDp/qW2kd
   n4WKjUlpK+AjFe+WikH/1h8dxVd/INSlXZa4DP7hZ39+rShrJLFg9743O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="12346397"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="12346397"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 05:42:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="909996621"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="909996621"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 07 Feb 2024 05:42:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 7414B86; Wed,  7 Feb 2024 08:35:56 +0200 (EET)
Date: Wed, 7 Feb 2024 08:35:56 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Werner Fischer <devlists@wefi.net>,
	Daniel Drake <drake@endlessos.org>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 0/5] drop low power policy board type
Message-ID: <20240207063556.GO8454@black.fi.intel.com>
References: <20240206211352.1664816-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206211352.1664816-1-cassel@kernel.org>

Hi Niklas,

On Tue, Feb 06, 2024 at 10:13:41PM +0100, Niklas Cassel wrote:
> Mario Limonciello (1):
>   ata: ahci: Drop low power policy board type
> 
> Niklas Cassel (4):
>   ata: ahci: move marking of external port earlier
>   ata: ahci: a hotplug capable port is an external port
>   ata: ahci: drop hpriv param from ahci_update_initial_lpm_policy()
>   ata: ahci: do not enable LPM on external ports

Looks good to me. Thanks for looking into it!

For the series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
