From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 0/2] ahci per-port msix support
Date: Mon, 2 Nov 2015 14:23:02 -0500
Message-ID: <20151102192302.GD9553@mtj.duckdns.org>
References: <20151101184335.23222.22225.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:33464 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbKBTXF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Nov 2015 14:23:05 -0500
Received: by ykft191 with SMTP id t191so149532247ykf.0
        for <linux-ide@vger.kernel.org>; Mon, 02 Nov 2015 11:23:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151101184335.23222.22225.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org

On Sun, Nov 01, 2015 at 01:43:35PM -0500, Dan Williams wrote:
> Changes since v1 [1]:
> 
> 1/ Clean up "nvec = min(nvec, n_ports);" statement (Tejun)
> 
> 2/ Drop threaded interrupt handling option for now.
> 
> [1]: http://marc.info/?l=linux-ide&m=144623970817213&w=2

Applied to libata/for-4.4.

Thanks.

-- 
tejun
