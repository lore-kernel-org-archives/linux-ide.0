Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A86419A2A3;
	Tue, 10 Jun 2025 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749586558; cv=none; b=l7oTwC0jyrWlphL0ZRovOa0EAQJWKdMz9JsE0c5dT7mPUHNTBA92dAoGdSfFMDAKWEndUb4eua0SH7dgZ+xLyGfMMLKBCh8WA3JJjA7q3kLiy6LR6rLxS0S+6xL4YD6YEH4dl9nRswp4+LGnrXSATajGz5de5smSCACGCxkIf0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749586558; c=relaxed/simple;
	bh=9gGfWHcaNgUF3A8N/3MOiGR92oCfOmG18YPh4yHFylw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/3ZXHTBoYcbRujYaIV8QdbETrkKE4VUm3lg7AxX+Ksg9bzlcqDf4dw+NkZjNi3dbrn7ID819tJARRwz0TsDA5JeZPd/+jsaDKAqPPXvCV3fPfwma0h+XuEH3aLhGXHNV3eGTW9nPXbG0CMzY2dQQNfv2sbTxjSZt3fNC6lokdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gSyyXrnq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gSyyXrnq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749586557; x=1781122557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9gGfWHcaNgUF3A8N/3MOiGR92oCfOmG18YPh4yHFylw=;
  b=gSyyXrnqRxDTQj84WeyvHIJhvpTWh/hJ1h1T7GVP2QPLv5WQDw7djYvy
   mSzFSr0IsSWCJhoFqk0k8Gu8fIrKEqYYWivHXvDL/SOD2K/6GbK29r7l8
   mPEMidifFvp8XCmgoMtM2z9b8b+UnERXPshHUcOHw29AJfoJCmo053fs5
   0RuNwyW+pbwyQv3ed+wZakn/JIdv2iQHpmq4upG25q7tKne+1L8ad1bN7
   Pk+w5oAGTONVuLt3hvuRFohhvnmgmC+hmqZ/mUU1xEH7NWOZjdh514pHj
   LnYmkRXi4St7/eoHaaC9AxSjBB71paec4DCS6RTPumneHEBqiQ8WtKtTR
   w==;
X-CSE-ConnectionGUID: v3bQbKplSQa4RuP1MPY2yQ==
X-CSE-MsgGUID: 9OAreQX/QM2hNIQu116hsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="54343269"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="54343269"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 13:15:57 -0700
X-CSE-ConnectionGUID: K+3jvcguTBOdrodDu33UnQ==
X-CSE-MsgGUID: UUIALR6MQ/aU2Ub2oCeL+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="150794979"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 13:15:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uP5Nw-00000005RTJ-3LlM;
	Tue, 10 Jun 2025 23:15:52 +0300
Date: Tue, 10 Jun 2025 23:15:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: phasta@kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ata: pata_macio: Fix PCI region leak
Message-ID: <aEiSeFkgbmOY7ZVN@smile.fi.intel.com>
References: <20250610135413.35930-2-phasta@kernel.org>
 <aade5fcc5bae0e2a04441388fd7f248704a33ae3.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aade5fcc5bae0e2a04441388fd7f248704a33ae3.camel@mailbox.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 10, 2025 at 04:01:43PM +0200, Philipp Stanner wrote:
> On Tue, 2025-06-10 at 15:54 +0200, Philipp Stanner wrote:
> > pci_request_regions() became a managed devres functions if the PCI
> > device was enabled with pcim_enable_device(), which is the case for
> > pata_macio.
> > 
> > The PCI subsystem recently removed this hybrid feature from
> > pci_request_region(). When doing so, pata_macio was forgotten to be
> > ported to use pcim_request_all_regions(). If that function is not
> > used,
> > pata_macio will fail on driver-reload because the PCI regions will
> > remain blocked.
> > 
> > Fix the region leak by replacing pci_request_regions() with its
> > managed
> > counterpart, pcim_request_all_regions().
> > 
> > Fixes: 51f6aec99cb0 ("PCI: Remove hybrid devres nature from request
> > functions")
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> 
> Forgot Damien's Reviewed-by.

Then put it here, if maintainers use `b4`, it will automatically harvest them.

-- 
With Best Regards,
Andy Shevchenko


