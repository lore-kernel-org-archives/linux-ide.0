From: Mark Lord <liml@rtr.ca>
Subject: SATA Target mode & libata
Date: Thu, 08 Nov 2007 15:49:17 -0500
Message-ID: <4733764D.80203@rtr.ca>
References: <025c01c82016$fbcf3810$d400a8c0@laurence> <025001c82067$d76c04c0$6200a8c0@jameshsu> <20071107221355.GB15784@havoc.gtf.org> <001f01c821b0$20b6c9f0$6200a8c0@jameshsu> <02d301c821e2$25dc01c0$d400a8c0@laurence> <005e01c821fb$502be120$6200a8c0@jameshsu> <20071108162229.GB31492@havoc.gtf.org> <473368FA.4030603@rtr.ca> <20071108200920.GB4895@havoc.gtf.org> <47336F68.2080601@rtr.ca> <20071108203127.GC4895@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2041 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761075AbXKHUtT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Nov 2007 15:49:19 -0500
In-Reply-To: <20071108203127.GC4895@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Jeff Garzik wrote:
> On Thu, Nov 08, 2007 at 03:19:52PM -0500, Mark Lord wrote:
..
>> MMmm..  I wonder what the most common use case is for target mode?
>>
>> Everybody I've dealt with thus far uses it as a high-speed local comms 
>> interface,
>> which would suggest that it might be done as a network interface (ethernet 
>> emulation).
>>
>> But that would confusingly go across driver subsystems,
>> despite that this is how it actually is used.
> 
> The low-level driver itself will just be a dumb DMA send/receive engine,
> with submit/completion APIs highly similar to the existing ones.  Then
> you can easily provide a network interface interface (not a typo) on top
> of that.
..

The obvious BIG difference is that in host mode, *we* initiate communcations,
whereas in target mode, it has to just sit there waiting for a host to say something.

That's a pretty big change from how libata operates today,
in just about every respect.

> The biggest use case I've seen is in the embedded space, where you
> really are creating a SCSI (or ATA) target, that appears to the
> initiator/client to be a real SCSI-or-ATA device.
> 
> There are certainly other uses:  networking, creating a cheap SATA bus
> analyzer, creating a cheap SATA bridge, ...
> 
> My main goal is to ensure that the low-level driver is as simple as
> possible, which permits upper layers to actually figure out what
> purposes it shall use.
> 
> Modern SATA is just a DMA engine with PHY control anyway (just like
> networking), so we really just need to be sure to abstract away
> initiator-mode (aka host mode) specifics in drivers that support target
> mode.
