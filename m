From: Mark Lord <kernel@teksavvy.com>
Subject: Re: XT-PIC interrupts blocked by usbserial ? [Was Re: Intel ICH9M
 bug : sata unusable with usbserial]
Date: Thu, 03 Mar 2011 16:48:35 -0500
Message-ID: <4D700CB3.10101@teksavvy.com>
References: <Pine.LNX.4.44L0.1103031502100.1669-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:64002 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752628Ab1CCVsi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Mar 2011 16:48:38 -0500
In-Reply-To: <Pine.LNX.4.44L0.1103031502100.1669-100000@iolanthe.rowland.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Philippe De Muyter <phdm@macqel.be>, Greg KH <greg@kroah.com>, Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org

On 11-03-03 03:11 PM, Alan Stern wrote:
> On Thu, 3 Mar 2011, Mark Lord wrote:
> 
>> Okay, dug out a UHCI 1.1 spec, and the indication from there
>> is that uhci_irq() can return IRQ_HANDLED in some cases where IRQ_NONE
>> is more appropriate.
> 
> What cases are those?
> 
>> Also, it is not masking the "Reserved" bits from the status register.
>> Presumably most implementations "read zero" for those bits,
>> but perhaps not all do.
> 
> Perhaps not, but I've never come across one that does.  This
> essentially amounts to saying that the only reasons a UHCI controller
> generates an interrupt request are the documented ones.
> 
> Suppose the driver did mask out the reserved bits and return IRQ_NONE 
> when none of the defined bits were set.  An implementation that did set 
> one of the reserved bits would then create an interrupt storm.

You mean, like, the "error -71" storms that I *still* get from time
to time, ever since the early 2.6.2x kernels?

Yeah, perhaps.

Cheers
