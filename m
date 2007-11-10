From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: cd/dvd inaccessible in 2.6.24-rc2
Date: Sat, 10 Nov 2007 23:05:53 +0000
Message-ID: <20071110230553.1a935ec6@the-village.bc.nu>
References: <1194668831.3436.14.camel@Athas>
	<20071110144923.beb7bbae.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45972 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755067AbXKJXGV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Nov 2007 18:06:21 -0500
In-Reply-To: <20071110144923.beb7bbae.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Will Trives <will@trivescon.com.au>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Sat, 10 Nov 2007 14:49:23 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sat, 10 Nov 2007 15:27:11 +1100 Will Trives <will@trivescon.com.au> wrote:
> 
> > 
> > Hello,
> > 
> > Motherboard: Gigabyte GA-P35-DS4 (rev. 1.1)
> > Chipset: Intel P35 + ICH9R 
> > PATA port runs off JMicron controller
> > CD/DVD Device: BENQ DW1640 16X
> > 
> > I cannot access my dvd burner under 2.6.24-rc2, I have no problems under
> > 2.6.23. Basically the drive is detected OK, everything looks ok but as
> > soon as I go to use it errors like this occur:

Guess what - jmicron hasn't changed in this tree for ages 8(

> > ata9.00: qc timeout (cmd 0xa0)
> > ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> > ata9.00: cmd a0/00:00:00:02:00/00:00:00:00:00/a0 tag 0 cdb 0x5a data 2
> > in
> >          res 51/54:03:00:02:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
> > ata9.00: status: { DRDY ERR }

Could be an IRQ/ACPI regression, and in fact to me it looks more like
that, than an IDE one. Probably worth trying the various IRQ routing
options and seeing if they help.


Alan
