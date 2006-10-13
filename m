From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Generic platform device IDE driver
Date: Fri, 13 Oct 2006 08:46:49 -0400
Message-ID: <452F8AB9.20100@pobox.com>
References: <20061004074535.GA7180@localhost.hsdv.com> <1159972725.25772.26.camel@localhost.localdomain> <20061005091631.GA8631@localhost.hsdv.com> <200610111450.41909.matthias.fuchs@esd-electronics.com> <20061012061348.GA7844@linux-sh.org> <20061013075219.GA28654@flint.arm.linux.org.uk> <20061013122824.GA26705@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42464 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751664AbWJMMq6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Oct 2006 08:46:58 -0400
In-Reply-To: <20061013122824.GA26705@linux-sh.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Matthias Fuchs <matthias.fuchs@esd-electronics.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Paul Mundt wrote:
> On Fri, Oct 13, 2006 at 08:52:19AM +0100, Russell King wrote:
>> On Thu, Oct 12, 2006 at 03:13:48PM +0900, Paul Mundt wrote:
>>> Yes, that's one thing I was thinking of as well.. Here's a patch that
>>> makes an attempt at that, can you give it a try and see if it works for
>>> you? This applies on top of the earlier patch. None of the ARM, SH, or
>>> H8300 cases need to do the remapping at least.
>> It's likely that ARM will switch over to using the MMIO resources if
>> this patch makes it in.  There's certain ARM platforms which would
>> benefit from this change (since inb() and friends are more complex
>> than they necessarily need to be.)
>>
>> However, one issue needs to be solved before we could do that - how do
>> we handle the case where the IDE registers are on a 4 byte spacing
>> interval instead of the usual 1 byte?
>>
> We could solve this in the driver, but it sounds like this is something
> that libata should have some visibility of directly.
> 
>> I notice that this driver is calling ata_std_ports() which handles
>> the standard setup.  Maybe that needs to become a little more inteligent?
>>
> If we go this route, I suppose the easiest option will be simply to have
> a private structure with a few function pointers for these sorts of
> things, or we can simply have an element for the spacing interval if you
> don't forsee needing to change the ioaddrs in any fashion beyond the
> register spacing.. Which approach would you be more comfortable with?
> Are there any other items that you're concerned with in the current
> driver?


Here's the decision matrix for libata:  Will the hardware use the 
standard taskfile push/pull functions like ata_tf_load(), ata_tf_read(), 
ata_exec_command(), etc.?  If yes, simply replace ata_std_ports() call 
with a call to your own function, written similarly to 
pdc_ata_setup_port() in sata_promise.c.

If the hardware requires non-standard I/O accessors, or the register 
sizes themselves changed, then you must implement your own taskfile I/O 
functions, similar to k2_sata_tf_load(), k2_sata_tf_read(), and 
k2_bmdma_setup_mmio() in sata_svw.c.  For this case, data in struct 
ata_ioports is largely up to you to manage, or ignore.

If there are special command setup or teardown operations, there are 
other standard hooks to override as well.

	Jeff


