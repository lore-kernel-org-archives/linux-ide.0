From: David Sims <dpsims@virtualdave.com>
Subject: Re: 31244 & sata_vsc.c & Dell Powervault
Date: Fri, 4 Feb 2005 08:24:48 -0600 (CST)
Message-ID: <Pine.LNX.4.21.0502040810050.22258-100000@ernie.virtualdave.com>
References: <4203756F.5010109@scannet.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from ernie.virtualdave.com ([198.216.116.246]:11022 "EHLO
	ernie.virtualdave.com") by vger.kernel.org with ESMTP
	id S264613AbVBDOY6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Feb 2005 09:24:58 -0500
In-Reply-To: <4203756F.5010109@scannet.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: A/S ScanNet - Dan Faerch <dan@scannet.dk>
Cc: linux-ide@vger.kernel.org

Hi,

YES!! You must build a kernel with (at least) the following options:

Processor type and features -> Local APIC support on uniprocessors
Processor type and features -> IO-APIC support on uniprocessors
General setup -> Power Management support -> ACPI Support

and I have successfully built and run a monolithic kernel with the
following options selected:

Network device support -> Ethernet (1000 Mbit) -> Intel(R) PRO/1000
Gigabit Ethernet support

and of course:

SCSI support -> SCSI low-level drivers -> Serial ATA (SATA) support ->
sata_vsc

I have successfully used both the 2.4.29 kernel tree for this as well as
the 2.6.10 kernel tree... The magic is in the PCI interrupt steering of
the APIC and IO-APIC... But these two really aren't doing their things
unless you have APCI enabled and working.... Once you have got it going
the right way, you can look in /proc/interrupts and see:

root@dell:/proc# more interrupts
           CPU0
  0:   21934005    IO-APIC-edge  timer
  1:          2    IO-APIC-edge  keyboard
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 18:     197698   IO-APIC-level  eth0
 22:         14   IO-APIC-level  aic7xxx
 25:      79029   IO-APIC-level  libata
NMI:          0
LOC:   21932615
ERR:          0
MIS:          0

                   ^^^^^^ This tells you that IO-APIC is steering the
interrupts also, note the interrupt 18, 22, and 25... Usually you only see
PIC interrupts to 15.... This is what made it work....

Regards and best of luck.

Dave Sims
***************************************************************************
On Fri, 4 Feb 2005, A/S ScanNet - Dan Faerch wrote:

> Hia..
> 
> I saw your mailings on the linux-ide mailinglist today, and just wanted 
> to ask if you found a solution..
> Im sitting with the same smelly powervault and with no working driver 
> ;). Did you find out anything else (that is not in your mailings to the 
> linux-ide list)
> 
> 
> Regards
> - Dan Faerch
> 

