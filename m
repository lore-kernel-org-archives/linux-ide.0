From: 'Tejun Heo' <tj@kernel.org>
Subject: Re: [PATCH V2 2/2] ahci_platform: use dev_info() instead of printk()
Date: Mon, 7 Oct 2013 15:25:02 -0400
Message-ID: <20131007192502.GH27396@htj.dyndns.org>
References: <001501cec15f$f7bbffb0$e733ff10$%han@samsung.com>
 <001601cec160$11b0e570$3512b050$%han@samsung.com>
 <20131007191310.GF27396@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:60398 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954Ab3JGTZG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Oct 2013 15:25:06 -0400
Received: by mail-qc0-f177.google.com with SMTP id x12so5097316qcv.8
        for <linux-ide@vger.kernel.org>; Mon, 07 Oct 2013 12:25:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20131007191310.GF27396@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-ide@vger.kernel.org

On Mon, Oct 07, 2013 at 03:13:10PM -0400, 'Tejun Heo' wrote:
> On Sat, Oct 05, 2013 at 09:15:59AM +0900, Jingoo Han wrote:
> > Change "raw" printk() call to dev_info() to provide a better
> > message to userspace so it can properly identify the device
> > and not just have to guess.
> > 
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> 
> Applied to libata/for-3.13.

Strike that.  Applied to libata/for-3.12-fixes.

Thanks.

-- 
tejun
