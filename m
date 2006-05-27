From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
 fails: libata issue
Date: Sat, 27 May 2006 15:06:27 -0400
Message-ID: <4478A333.20500@garzik.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org> <4477CEF5.9000908@garzik.org> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <4478A1F5.6030406@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:18830 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964929AbWE0TGe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 15:06:34 -0400
In-Reply-To: <4478A1F5.6030406@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mark Lord <liml@rtr.ca>, Jens Axboe <axboe@suse.de>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Linus Torvalds wrote:
>> What's the layering violation in just having ATA resume make sure it's 
>> not ATA_BUSY? 
> 
>> Why are you guys fighting over this?
> 
> As soon as we start powering on the SATA phy (code exists, 2.6.18), or 
> dealing with port multipliers (code exists, 2.6.19), the "working patch" 
> stops working.

so basically when the SCSI and libata suspend is used for any controller 
other than ata_piix, really :)

	Jeff


