From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.26.*] boot problem (ahci/irq related?)
Date: Tue, 12 Aug 2008 16:45:35 +0200
Message-ID: <200808121645.37539.rjw@sisk.pl>
References: <8db1092f0808111312x3baf819bxbb05030c05693065@mail.gmail.com> <20080812081632.303de380@lxorguk.ukuu.org.uk> <8db1092f0808120107k1f8a65f4sf406fa3a89125870@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756069AbYHLOnf@vger.kernel.org>
In-Reply-To: <8db1092f0808120107k1f8a65f4sf406fa3a89125870@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Yinghai Lu <yhlu.kernel@gmail.com>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, tj@kernel.org, andi@firstfloor.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-ide@vger.kernel.org

On Tuesday, 12 of August 2008, Maciej Rutecki wrote:
> 2008/8/12 Alan Cox <alan@lxorguk.ukuu.org.uk>:
> >> > +sr 4:0:0:0: Attached scsi CD-ROM sr0
> >>
> >> looks like you are using ata driver for pata device instead of ide driver.
> >>
> >> so could be caused by bug in ata_piix...
> >
> > See the original bug report - he tried both and got the same kind of
> > behaviour.
> >
> >
> 
> Yes I have similar behaviour, very often kernel stops on this message:
> http://unixy.pl/maciek/download/kernel/dupa/2.6.26.2_config_ide/img_0001.jpg

In both cases one of the last messages is

ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 17

and that comes from AHCI,  or rather from pci_enable_device() invoked by
AHCI.  Then, there are no more messages from AHCI, although there should
be at least 

ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x1 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq ilck stag pm led clo pmp pio slum part 
PCI: Setting latency timer of device 0000:00:1f.2 to 64

So, it seems like the enabling of AHCI interrupt causes the failure and since
that's not 100% reproducible, it indicates a timing issue.

Thanks,
Rafael
