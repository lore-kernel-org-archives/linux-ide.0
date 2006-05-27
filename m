From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)
    fails: libata issue
Date: Sat, 27 May 2006 18:23:56 -0400
Message-ID: <4478D17C.2050300@rtr.ca>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <Pine.LNX.4.64.0605271444200.5623@g5.osdl.org> <4478CD4E.4000506@rtr.ca> <Pine.LNX.4.64.0605271515050.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:34772 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965008AbWE0WX6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 18:23:58 -0400
In-Reply-To: <Pine.LNX.4.64.0605271515050.5623@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jeff@garzik.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 27 May 2006, Mark Lord wrote:
>
>> Note that the second set are for the DVD-RW drive,
>> which (being ATAPI) doesn't assert ATA_DRDY.
> 
> Neither of them do. 80 is just your old ATA_BUSY (that you needed to wait 
> a long time for to disappear).

Yeah, I know that.  Just pointing it out because the original
discussion suggested we might want the code to also wait for DRDY,
which would be correct only for ATA disks.

> Can you move the two new lines to *after* the ata_busy_wait? I'd like to 
> see if ATA_DRDY ever comes on (it quite possibly will not, just humor me)

Okay.  rebooting now..
