From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] sata_dwc_460ex: join messages back
Date: Tue, 24 Mar 2015 13:48:27 -0400
Message-ID: <20150324174827.GK3880@htj.duckdns.org>
References: <1425410518-15405-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33741 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932813AbbCXRsd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Mar 2015 13:48:33 -0400
Received: by qgfa8 with SMTP id a8so750973qgf.0
        for <linux-ide@vger.kernel.org>; Tue, 24 Mar 2015 10:48:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1425410518-15405-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-ide@vger.kernel.org

On Tue, Mar 03, 2015 at 09:21:58PM +0200, Andy Shevchenko wrote:
> It it better to have full message on one line. It simplifies to search for line
> in the code by message when debugging.
> 
> Note that the lines which will be removed by sequential patch are not fixed
> here.
> 
> There is no functional change.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to libata/for-4.1.

Thanks.

-- 
tejun
