From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Using PATA Platform Driver to access Memory Mapped CF Card
Date: Sat, 1 May 2010 11:33:46 +0100
Message-ID: <20100501113346.29225519@lxorguk.ukuu.org.uk>
References: <4BDAE529.20903@gmail.com>
	<201005010524.40949.marek.vasut@gmail.com>
	<4BDBD4AB.8020200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43293 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751957Ab0EAK2K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 May 2010 06:28:10 -0400
In-Reply-To: <4BDBD4AB.8020200@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Graeme Russ <graeme.russ@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sat, 01 May 2010 17:13:47 +1000
Graeme Russ <graeme.russ@gmail.com> wrote:

> Hello,
> 
> I have a CF slot mapped to a GP bus on a board I'm porting linux to. It is
> wired in 8-bit Memory Mode only with only A0 - A3 mapped from the address
> bus (starting at 0x20000000). I know the arrangement works as this board is
> successfully accessing CF cards using existing proprietary firmware.

Our ATA/IDE driver stack only supports 16/32bit accesses for data. You
can override the data_xfer methods in a driver to do 8bit transfers. That
may be one problem you are seeing I guess.

> [    1.988931] scsi0 : pata_platform
> [    1.996940] ata1: PATA max PIO0 no IRQ, using PIO polling mmio cmd
> 0x20000000 ctl 0x2000000e
> ...
> [    2.168883] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
> [    1.995794] ata1.01: NODEV after polling detection
> [    2.013803] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
> ...
> [    7.146794] ata1.01: NODEV after polling detection
> [    7.164802] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
> [   12.297794] ata1.01: NODEV after polling detection
> [   12.315802] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
> [   17.448794] ata1.01: NODEV after polling detection
> 
> And similar with a 1G UltraII and 4G Extreme III but they do not generate
> the NODEV message. With no card inserted I get neither the NODEV nor the
> failed to IDENTIFY messages. It looks like something is at least partially
> working.
> 
> Can anyone tell me how to go about enabling an appropriate level of
> debugging options, and what I should be looking out for?

include/linux/libata.h

define these: 

#undef ATA_DEBUG                /* debugging output */
#undef ATA_VERBOSE_DEBUG        /* yet more debugging output */

and you should get a lot more info
