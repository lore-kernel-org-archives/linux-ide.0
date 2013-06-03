From: 'Tejun Heo' <tj@kernel.org>
Subject: Re: [PATCH V2] ata: use pci_get_drvdata()
Date: Sun, 2 Jun 2013 21:33:56 -0700
Message-ID: <20130603043356.GF6071@mtj.dyndns.org>
References: <001b01ce6011$fcc96290$f65c27b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:62295 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab3FCEd5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jun 2013 00:33:57 -0400
Received: by mail-qa0-f48.google.com with SMTP id ih17so1561586qab.7
        for <linux-ide@vger.kernel.org>; Sun, 02 Jun 2013 21:33:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <001b01ce6011$fcc96290$f65c27b0$@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-ide@vger.kernel.org

On Mon, Jun 03, 2013 at 01:22:41PM +0900, Jingoo Han wrote:
> Use the wrapper functions for getting the driver data using pci_dev
> instead of using dev_get,set_drvdata() with &pdev->dev, so we can
> directly pass a struct pci_dev.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> Changes since v1:
> - Fix the commit message from pci_{get,set}_drvdata() to pci_get_drvdata()

Ummm... wouldn't using pci_set_drvdata() make things more consistent?
Also, what about the other comment that I made?  Is this purely
cosmetic or is there some other change which is gonna depend on it?

Thanks.

-- 
tejun
