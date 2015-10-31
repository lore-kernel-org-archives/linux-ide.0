From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/4] ahci: cleanup ahci_host_activate_multi_irqs
Date: Sat, 31 Oct 2015 09:59:51 +0900
Message-ID: <20151031005951.GC3582@mtj.duckdns.org>
References: <20151030210924.8538.90627.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20151030210935.8538.54059.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34077 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320AbbJaA76 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Oct 2015 20:59:58 -0400
Received: by padhk11 with SMTP id hk11so88728080pad.1
        for <linux-ide@vger.kernel.org>; Fri, 30 Oct 2015 17:59:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151030210935.8538.54059.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org

On Fri, Oct 30, 2015 at 05:09:35PM -0400, Dan Williams wrote:
> With devm there is no need to explicitly free irqs on error.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Applied 1-2 to libata/for-4.4.

Thanks.

-- 
tejun
