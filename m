From: Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: PMP and Smart Enclosure ...
Date: Tue, 29 Mar 2011 17:39:10 +0200
Message-ID: <20110329153910.GB25397@MAIL.13thfloor.at>
References: <20110322145440.GA15541@MAIL.13thfloor.at> <20110322152529.GB15541@MAIL.13thfloor.at> <20110328085211.GD16530@htj.dyndns.org> <20110328123623.GD25384@MAIL.13thfloor.at> <20110328160136.GC6736@htj.dyndns.org> <20110328224642.GJ25384@MAIL.13thfloor.at> <20110328234729.GK25384@MAIL.13thfloor.at> <20110329080321.GG6736@htj.dyndns.org> <20110329144906.GN25384@MAIL.13thfloor.at> <20110329150104.GD29865@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from MAIL.13thfloor.at ([213.145.232.33]:41388 "EHLO
	MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab1C2PjM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Mar 2011 11:39:12 -0400
Content-Disposition: inline
In-Reply-To: <20110329150104.GD29865@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Tue, Mar 29, 2011 at 05:01:04PM +0200, Tejun Heo wrote:
> On Tue, Mar 29, 2011 at 04:49:06PM +0200, Herbert Poetzl wrote:
>> PS: any thoughts on how/where I should add the device 
>>     interface for the SATA PMP?

> One way would be adding a device node for the PMP device but I don't
> have much idea how it should look like.  The thing is that PMP isn't a
> completely separate device.  It's more of a dummy hub and an extension
> of the host SATA bus rather than a separate device.  Maybe it's best
> to just put it together on the host itself.

well, as I see it, there is a bunch of options here, with 
various advantages and of course certain limitations/drawbacks

 1) we could simply add an SCSI device for the PMP
    e.g. if there is 8:0:0:0 - 8:4:0:0 we could add 8:15:0:0

    pro: probably the most flexible interface as one can
         send whatever PMP messages they like, but I'm
         not sure how to handle the replies here
    con: might need special security etc, but OTOH, you
         can mess up a disk as well ...

 2) we could add some special IOCTL, based on the existing
    devices

    pro: could be limited to certain well defined commands
         and there is no need for new interfaces
    con: not really associated with the PMP, i.e. more a
         hack which needs special handling for non PMP
         attached disks

 3) we could have some specific sysfs interfaces doing
    certain parts of the communication

    pro: easy to add, well known interface and could be
         structured and associated with the host controller
    con: very limited and needs kernel code for each new
         PMP message, also request/reply type of commands
         get really ugly soon and finally we need to handle
         more than one PMP per host

 4) create an i2c module which 'attaches' to the PMP(s)

    pro: no problem with request/reply and basically the
         proper interface between SEMB and SEP
    con: only a subset of the PMP messages are related to
         SEMB/SEP stuff, so that would only solve this
         particular problem and not e.g. PMP GPIO

I'd lean towards 1, because it will give the most flexibility
and will allow fast prototyping in userspace, my second choice
would be 4) as I'm mainly interested in the SEMB/SEP stuff
right now, but I definitely want to avoid adding something
with almost zero chance to go upstream :)

thanks,
Herbert

> -- 
> tejun
