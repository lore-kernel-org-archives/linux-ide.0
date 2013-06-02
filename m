From: 'Tejun Heo' <tj@kernel.org>
Subject: Re: [PATCH] ata: use pci_{get,set}_drvdata()
Date: Sun, 2 Jun 2013 01:06:26 -0700
Message-ID: <20130602080626.GD8286@mtj.dyndns.org>
References: <005701ce5e74$a8414470$f8c3cd50$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:54537 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab3FBIG3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Jun 2013 04:06:29 -0400
Received: by mail-pd0-f180.google.com with SMTP id 14so4246081pdc.39
        for <linux-ide@vger.kernel.org>; Sun, 02 Jun 2013 01:06:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <005701ce5e74$a8414470$f8c3cd50$@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-ide@vger.kernel.org

On Sat, Jun 01, 2013 at 12:03:57PM +0900, Jingoo Han wrote:
> Use the wrapper functions for getting and setting the driver data using
> pci_dev instead of using dev_{get,set}_drvdata() with &pdev->dev, so we
> can directly pass a struct pci_dev.

The patch isn't converting any set_drvdata.  Also, does this actually
matter?  I'm not against it but if it's just cosmetic, please say so
in the patch description.

Thanks.

-- 
tejun
