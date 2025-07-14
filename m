Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D461F4E34;
	Mon, 14 Jul 2025 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477170; cv=none; b=TGH9NSySZgv61GN7P4+fHJrFltqZm/x2Mc0RE689U8vfkwE+K6qnBa0c1Hypbpdpxb/xF6dSctwpt7mjJ7spdJsVj7zxdaATzy2AvJszPihVg8P0vemzTaXqenkOIJlCn2CStF28iCKof88bVuYhAundLcIV9yLoMrOm8wdc6lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477170; c=relaxed/simple;
	bh=UN5v9nySUWtkObzc9E8/ogyFIDTHRn5I1zV4VR/x9Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWQoQjJpPFYkEXPu3UJ+Df07EMc1HATf9EGmyK58jVEtf0P4aIh4zec+ouyQ1qb4e6zig+HiMpnf7r3dP93wtPJs/rIbDvax2/J2WYs/R8rHbis1pg9LjszJOXaUMPvVRzEL0OqYQ5UKMJ0GasPtDet0FE5jTVEhQfCL9f7WMXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJR/up+x; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJR/up+x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752477169; x=1784013169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UN5v9nySUWtkObzc9E8/ogyFIDTHRn5I1zV4VR/x9Ro=;
  b=QJR/up+x8ja1AfdLHn1JQWa061sEWFWLwHV5tdLdlcEfH68DAy0wT7pT
   VaTI/xTahhOFox1ej4devnQK0YjsRoQzTyIfMHvo0Vd8BbC8cpvXdNRpE
   FfM+RkP3H58kFsursTQjWcucvg3rYCZW8g3167VXwOW1trqx4xmIT1190
   +BxGNZATg88mVq9bXIHWtkRjjAtjapWo6e0fxN6VJAlYijxxnPduUHs5J
   CwIDl8fbZyge+FURj9VQa+4si98vVkECmMjcpz33X+Qrcp5pJ3Kmmk4te
   WpLU+hIVtKv+27YCYYInzEx+fwqPya2gNEeOd0mXN55BWWBD5oQ4s7vBc
   A==;
X-CSE-ConnectionGUID: jnsFga+kRSSH3vUnxrcIjA==
X-CSE-MsgGUID: /MwQtVoaQEqyaYrCiUIcFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="64921782"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="64921782"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 00:12:48 -0700
X-CSE-ConnectionGUID: hsxKGJgQS92GjJT/NtGh0A==
X-CSE-MsgGUID: 0M/stg90QZqnEpyaGA44eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="160879331"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 00:12:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ubDMi-0000000FI1V-0Et2;
	Mon, 14 Jul 2025 10:12:44 +0300
Date: Mon, 14 Jul 2025 10:12:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v1 1/1] pata_rdc: Use registered definition for the RDC
 vendor
Message-ID: <aHSt65bhITAzN_2x@smile.fi.intel.com>
References: <20250711113650.1475307-1-andriy.shevchenko@linux.intel.com>
 <6d0b19d8-fb1a-4a3f-9a21-7c696df880c0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d0b19d8-fb1a-4a3f-9a21-7c696df880c0@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 14, 2025 at 09:32:09AM +0900, Damien Le Moal wrote:
> On 7/11/25 8:36 PM, Andy Shevchenko wrote:
> > Convert to PCI_VDEVICE() and use registered definition for RDC vendor
> > from pci_ids.h.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Commit title needs "ata: " prefix. Niklas, can you add it when applying ?

I took the output of

$ git log --oneline --no-merges -- drivers/ata/pata_rdc.c

and tried to deduct what will be the driver specific prefix, there are no
ata: pata_rdc: prefixed changes, so it appears that I made wrong assumption.

> Reviewed-by: Damien Le Moal <dlemoal@wdc.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


