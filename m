From: 'Tejun Heo' <tj@kernel.org>
Subject: Re: [PATCH] ata: use platform_{get,set}_drvdata()
Date: Fri, 24 May 2013 10:26:40 +0900
Message-ID: <20130524012640.GA16882@mtj.dyndns.org>
References: <003001ce57a2$10bbbaa0$32332fe0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:51879 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759450Ab3EXB0s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 May 2013 21:26:48 -0400
Received: by mail-pb0-f42.google.com with SMTP id uo1so3608107pbc.15
        for <linux-ide@vger.kernel.org>; Thu, 23 May 2013 18:26:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <003001ce57a2$10bbbaa0$32332fe0$@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-ide@vger.kernel.org, Viresh Kumar <viresh.linux@gmail.com>

On Thu, May 23, 2013 at 07:41:21PM +0900, Jingoo Han wrote:
> Use the wrapper functions for getting and setting the driver data using
> platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
> so we can directly pass a struct platform_device.
> 
> Also, unnecessary dev_set_drvdata() is removed, because the driver core
> clears the driver data to NULL after device_release or on probe failure.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to libata/for-3.11.  Thanks.

-- 
tejun
