From: Tejun Heo <htejun@gmail.com>
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Tue, 15 Apr 2008 11:37:26 +0900
Message-ID: <480414E6.2090205@gmail.com>
References: <200804021524.27222.elendil@planet.nl>	<200804021820.04610.elendil@planet.nl>	<20080402194938.GI24237@csclub.uwaterloo.ca>	<200804031947.07674.elendil@planet.nl>	<48017248.4030600@gmail.com>	<20080414134734.GB7385@csclub.uwaterloo.ca> <20080414145302.4239b0b9@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764210AbYDOChr@vger.kernel.org>
In-Reply-To: <20080414145302.4239b0b9@core>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Frans Pop <elendil@planet.nl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:
>> If a driver supports a device with dual interfaces, then it better
>> reserve both sets of ports to prevent the generic driver from trying to
>> use them.
> 
> That isn't the problem. The generic driver doesn't know if there is
> another valid driver for the ports - how can it - and the other driver
> may not be loaded first so cannot reserve the ports. If you load the
> generic driver last then you should be fine, and the link order for IDE
> and libata puts acpi, pci generic and legacy at the end for good reason.
> 
> Libata pata_legacy has some smarts in this area but they are only good
> for the common cases.

Always loading generic or ata_generic used to be safe.  It's still 
pretty safe but not as much as before.  Nowadays, there are good number 
of controllers which have dual interfaces.  Usually an ahci interface 
and a legacy one but there are other controllers which also implement 
dual interface.

Because PCI BARs usually contain IO regions for legacy interface in PCI 
BAR 0-4, the native driver can work it out by claiming all PCI BARs on 
attach, which I learned the hard way after seeing the generic driver 
borking the native one on certain configurations.  The thing I'm worried 
about is that there are a lot of vendors making this type of controllers 
nowadays and a lot of BIOS implementations for each of them.  And of 
course each BIOS implementation has its own many ways of configuring the 
dual mode (or more thanks to fake RAIDs) controller.

I wouldn't be too surprised if one of those plethora of configurations 
gets the compatible IO port and BAR configurations mismatched. 
Especially when the controller is put into native mode.  It's entirely 
possible to leave the compatible IO ports enabled while not setting the 
PCI BARs accordingly.  Some of them might even think that's better to 
prevent IDE drivers from attaching to it.

So, I don't really want to depend on that.  I don't know.  Do I sound 
paranoid?

-- 
tejun
