From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v1 4/4] sata_dwc_460ex: fix most of the sparse warnings
Date: Thu, 8 Jan 2015 08:28:24 -0500
Message-ID: <20150108132824.GA9402@htj.dyndns.org>
References: <1420637062-15450-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1420637062-15450-4-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150107153632.GD4395@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:38109 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255AbbAHN2e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jan 2015 08:28:34 -0500
Received: by mail-qa0-f43.google.com with SMTP id v10so2165357qac.2
        for <linux-ide@vger.kernel.org>; Thu, 08 Jan 2015 05:28:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150107153632.GD4395@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Miesfeld <mmiesfeld@amcc.com>, Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org

On Wed, Jan 07, 2015 at 10:36:32AM -0500, Tejun Heo wrote:
> On Wed, Jan 07, 2015 at 03:24:22PM +0200, Andy Shevchenko wrote:
> > There are a lot sparse warnings. Most of them related to __iomem keyword which
> > sometimes absent when it's needed and vise versa.
> > 
> > The patch fixes most of the warnings.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Applied 1-4 to libata/for-3.19-fixes.  One nit below.

Moved 2-4 to libata/for-3.20.

Thanks.

-- 
tejun
