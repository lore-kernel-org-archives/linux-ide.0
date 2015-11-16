From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: kill 'intr_status'
Date: Mon, 16 Nov 2015 11:30:40 -0500
Message-ID: <20151116163040.GI18894@mtj.duckdns.org>
References: <20151112003613.10105.35435.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:33586 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbbKPQan (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Nov 2015 11:30:43 -0500
Received: by ykdv3 with SMTP id v3so247862810ykd.0
        for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2015 08:30:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151112003613.10105.35435.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org

On Wed, Nov 11, 2015 at 04:37:12PM -0800, Dan Williams wrote:
> This field in achi_port_priv was only used to support threaded
> interrupts.  Now that we are hardirq only it can be deleted.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Applied to libata/for-4.5.

Thanks.

-- 
tejun
