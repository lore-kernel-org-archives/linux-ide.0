From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Issue with AHCI driver
Date: Mon, 04 Aug 2008 15:33:38 -0400
Message-ID: <48975992.4030003@pobox.com>
References: <30565143.1217877521998.JavaMail.root@elwamui-milano.atl.sa.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41280 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753707AbYHDTdn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Aug 2008 15:33:43 -0400
In-Reply-To: <30565143.1217877521998.JavaMail.root@elwamui-milano.atl.sa.earthlink.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: the4hoffmans@earthlink.net
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, blward@micron.com

the4hoffmans@earthlink.net wrote:
> We do have the AHCI class code - PCI offset 09h = 010601h.  We are detected as an AHCI controller under Vista.  I even tried adding our vendor/device id to ahci.c but that didn't make any difference.  Is there something else I'm missing?
> 
> A little background...
> 
> We have a PCIe plug-in card that identifies itself as an AHCI controller as mentioned above.  We used a PCIe analyzer card to look at traffic as we booted Linux (build 2.6.19).  We saw various PCI reads & writes as the system initialized PCI resources but we never saw what would amount to an 'Identify Device' command which I'm assuming the libata driver should do.  Any ideas?

Turn on debugging (top of include/linux/libata.h), and show us that output.

As Tejun noted, every vendor that claims full AHCI compatibility works 
with the Linux AHCI driver just fine.  A couple vendors that are not 
fully compatible (Marvell, ACard) need some tweaks due to non-standard 
register and operational differences.

	Jeff



