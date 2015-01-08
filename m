From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v1 3/3] sata_dwc_460ex: convert to devm_kzalloc in
 ->probe()
Date: Thu, 8 Jan 2015 08:31:11 -0500
Message-ID: <20150108133111.GB9402@htj.dyndns.org>
References: <1420714214-16950-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1420714214-16950-3-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:43195 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757002AbbAHNbQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jan 2015 08:31:16 -0500
Received: by mail-qc0-f180.google.com with SMTP id i8so1814661qcq.11
        for <linux-ide@vger.kernel.org>; Thu, 08 Jan 2015 05:31:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1420714214-16950-3-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rupjyoti Sarmah <rsarmah@amcc.com>, linux-ide@vger.kernel.org

On Thu, Jan 08, 2015 at 12:50:14PM +0200, Andy Shevchenko wrote:
> The patch converts ->probe() to use devm_kzalloc that simplifies error path.
> Note that ata_host_alloc_pinfo() has been using device resources already.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied 1-3 to libata/for-3.20.

Thanks.

-- 
tejun
