From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] ahci: per-port msix support
Date: Sat, 31 Oct 2015 10:03:55 +0900
Message-ID: <20151031010355.GD3582@mtj.duckdns.org>
References: <20151030210924.8538.90627.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20151030210940.8538.97829.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33097 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351AbbJaBEB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Oct 2015 21:04:01 -0400
Received: by padhy1 with SMTP id hy1so82649933pad.0
        for <linux-ide@vger.kernel.org>; Fri, 30 Oct 2015 18:04:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151030210940.8538.97829.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>

Hello,

Generally looks good to me.  One nitpick.

On Fri, Oct 30, 2015 at 05:09:40PM -0400, Dan Williams wrote:
> +	if (flags & AHCI_HFLAG_MULTI_MSIX) {
> +		if (nvec < n_ports)
> +			return -ENODEV;
> +		else
> +			nvec = min(nvec, n_ports);

Maybe the following is easier?

		if (nvec < n_ports)
			return -ENODEV;

		nvec = n_ports;

Thanks.

-- 
tejun
