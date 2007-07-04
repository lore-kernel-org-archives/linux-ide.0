From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata1: soft resetting port
Date: Thu, 05 Jul 2007 03:01:17 +0900
Message-ID: <468BE06D.4010507@gmail.com>
References: <1182260902.14805.60.camel@localhost>	 <4689EF48.8090506@gmail.com> <1183545657.22999.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758588AbXGDSBe@vger.kernel.org>
In-Reply-To: <1183545657.22999.15.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Soeren Sonnenburg wrote:
> On Tue, 2007-07-03 at 15:40 +0900, Tejun Heo wrote:
>> Soeren Sonnenburg wrote:
>>> Dear List,
>>>
>>> since the switch to 
>>>
>>> CONFIG_ATA=y
>>> CONFIG_ATA_ACPI=y
>>> CONFIG_ATA_PIIX=y,
>>>
>>> the ATA_PIIX driver manages both, internal sata disk aswell as cd/dvd
>>> rom. However I am being flooded with the error messages below (well they
>>> appear from time to time, dominating dmesg). 
>>>
>>> This happens on kernel 2.6.22-rc5, I am copying relevant parts from dmesg:
>> Does 2.6.22-rc7 fare better?
> 
> Yes indeed. The only thing I've seen in the last two days was the
> following on resume:
> 
> pci_express 0000:00:1c.2:pcie03: resuming
> sr 0:0:0:0: resuming
> sd 2:0:1:0: resuming
> sd 2:0:1:0: [sda] Starting disk
> ata1.00: configured for UDMA/33
> ata3.01: revalidation failed (errno=-2)
> ata3: failed to recover some devices, retrying in 5 secs
> ata3.01: configured for UDMA/133

Hmmm... That's NODEV_HINT being triggered after resume.  Probably the
device isn't ready to respond yet at that point.  How reproducible is
the problem?

-- 
tejun
