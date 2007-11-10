From: Jeff Garzik <jeff@garzik.org>
Subject: Re: cd/dvd inaccessible in 2.6.24-rc2
Date: Sat, 10 Nov 2007 18:28:52 -0500
Message-ID: <47363EB4.4030008@garzik.org>
References: <1194668831.3436.14.camel@Athas>	<20071110144923.beb7bbae.akpm@linux-foundation.org> <20071110230553.1a935ec6@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53096 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753563AbXKJX3I (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Nov 2007 18:29:08 -0500
In-Reply-To: <20071110230553.1a935ec6@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Will Trives <will@trivescon.com.au>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Alan Cox wrote:
>>> ata9.00: qc timeout (cmd 0xa0)
>>> ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>>> ata9.00: cmd a0/00:00:00:02:00/00:00:00:00:00/a0 tag 0 cdb 0x5a data 2
>>> in
>>>          res 51/54:03:00:02:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
>>> ata9.00: status: { DRDY ERR }
> 
> Could be an IRQ/ACPI regression, and in fact to me it looks more like
> that, than an IDE one. Probably worth trying the various IRQ routing
> options and seeing if they help.


Agreed, though the output is indeed signalling an error...  IMO the EH 
should handle the error if the device is signalling an error, upon 
timeout, rather than just going ahead and resetting the device.

Its similar to where ATA devices on PCI SFF controllers signal DMA error 
via timeout, where EH must inspect BMDMA Status register to determine if 
it's a DMA error signalled by hardware, or something that requires 
additional autopsy.

EH for ATAPI is quite different from EH for ATA, so there may be some 
areas where we don't handle things the right way for ATAPI.

Decoding the error message we have:

cdb 0x5a ==
	MODE SENSE(10)
status 0x51 ==
	DRDY
	command-specific flag (aka SERV, in !overlap case)
	CHK (check condition, aka error)
error 0x54 ==
	ABRT (command aborted or command parameter invalid)
	sense key 0x5 (illegal request)
ireason 0x3 ==
	the hardcoded values (bits 0 and 1) remain hardcoded, all good

Since BSY is not set in the Status register, and given the other 
information derived from the decoded values, it looks like the device is 
otherwise happy and ready to accept additional commands.

It appears to have chewed on an ATAPI command, spit it out, but failed 
to send a completion interrupt.

So its an open question whether it's a device not completing this 
errored-out command, or whether its IRQ/ACPI stuff infecting libata.

	Jeff


