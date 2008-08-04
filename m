From: the4hoffmans@earthlink.net
Subject: Re: Issue with AHCI driver
Date: Mon, 4 Aug 2008 16:56:49 -0400 (EDT)
Message-ID: <25908599.1217883409412.JavaMail.root@elwamui-milano.atl.sa.earthlink.net>
Reply-To: the4hoffmans@earthlink.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-spurfowl.atl.sa.earthlink.net ([209.86.89.66]:57631
	"EHLO elasmtp-spurfowl.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753751AbYHDU45 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Aug 2008 16:56:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, blward@micron.com

Jeff,

I changed line 53 of libata.h from "#undef ATA_DEBUG" to "#define ATA_DEBUG" and we got a bunch of compiler errors.  Was that not what you wanted?  Should I change ATA_VERBOSE_DEBUG instead?

Bob

-----Original Message-----
>From: Jeff Garzik <jgarzik@pobox.com>
>Sent: Aug 4, 2008 3:33 PM
>To: the4hoffmans@earthlink.net
>Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, blward@micron.com
>Subject: Re: Issue with AHCI driver
>
>the4hoffmans@earthlink.net wrote:
>> We do have the AHCI class code - PCI offset 09h = 010601h.  We are detected as an AHCI controller under Vista.  I even tried adding our vendor/device id to ahci.c but that didn't make any difference.  Is there something else I'm missing?
>> 
>> A little background...
>> 
>> We have a PCIe plug-in card that identifies itself as an AHCI controller as mentioned above.  We used a PCIe analyzer card to look at traffic as we booted Linux (build 2.6.19).  We saw various PCI reads & writes as the system initialized PCI resources but we never saw what would amount to an 'Identify Device' command which I'm assuming the libata driver should do.  Any ideas?
>
>Turn on debugging (top of include/linux/libata.h), and show us that output.
>
>As Tejun noted, every vendor that claims full AHCI compatibility works 
>with the Linux AHCI driver just fine.  A couple vendors that are not 
>fully compatible (Marvell, ACard) need some tweaks due to non-standard 
>register and operational differences.
>
>	Jeff
>
>
>

