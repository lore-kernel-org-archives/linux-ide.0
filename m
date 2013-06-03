From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH V2] ata: use pci_get_drvdata()
Date: Mon, 03 Jun 2013 13:55:14 +0900
Message-ID: <001f01ce6016$8938c870$9baa5950$@samsung.com>
References: <001b01ce6011$fcc96290$f65c27b0$@samsung.com>
 <20130603043356.GF6071@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:31407 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab3FCEzQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jun 2013 00:55:16 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MNS001DTWBSE5J0@mailout3.samsung.com> for
 linux-ide@vger.kernel.org; Mon, 03 Jun 2013 13:55:15 +0900 (KST)
In-reply-to: <20130603043356.GF6071@mtj.dyndns.org>
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

On Monday, June 03, 2013 1:34 PM, Tejun Heo wrote:
> On Mon, Jun 03, 2013 at 01:22:41PM +0900, Jingoo Han wrote:
> > Use the wrapper functions for getting the driver data using pci_dev
> > instead of using dev_get,set_drvdata() with &pdev->dev, so we can

I will fix this typo:
dev_get,set_drvdata() -> dev_get_drvdata()

> > directly pass a struct pci_dev.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> > Changes since v1:
> > - Fix the commit message from pci_{get,set}_drvdata() to pci_get_drvdata()
> 
> Ummm... wouldn't using pci_set_drvdata() make things more consistent?

Usually, both pci_set_drvdata() and pci_get_drvdata() are used.
But, I cannot find where pci_set_drvdata() can be used in ./drivers/ata/*.

> Also, what about the other comment that I made?  Is this purely
> cosmetic or is there some other change which is gonna depend on it?

This is purely _cosmetic_. There are no other changes.

Best regards,
Jingoo Han

> 
> Thanks.
> 
> --
> tejun

