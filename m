From: "Christian Pernegger" <pernegger@gmail.com>
Subject: Re: "Many lost ticks" while writing DVD-RAM
Date: Tue, 11 Jul 2006 22:26:40 +0200
Message-ID: <bb145bd20607111326p3b779cc2v92e51d97d3e0ee84@mail.gmail.com>
References: <bb145bd20607111046g2514265hd28049c533185bc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:25769 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751239AbWGKU0m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Jul 2006 16:26:42 -0400
Received: by ug-out-1314.google.com with SMTP id a2so4513942ugf
        for <linux-ide@vger.kernel.org>; Tue, 11 Jul 2006 13:26:40 -0700 (PDT)
In-Reply-To: <bb145bd20607111046g2514265hd28049c533185bc5@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> generic                 9860  0 [permanent]
> ide_generic             5632  0 [permanent]
> piix                   15876  0 [permanent]

Hmm, none of my other machines load 'ide-generic'. They only have
'generic' + a chipset specific module. And then there's this:

> [...]
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> pnp: the driver 'ide' has been registered
> Probing IDE interface ide0...
> hda: _NEC DVD_RW ND-4570A, ATAPI CD/DVD-ROM drive
> Probing IDE interface ide1...
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
> [...]
> ICH7: chipset revision 1
> ICH7: not 100% native mode: will probe irqs later
> ICH7: port 0x01f0 already claimed by ide0
> ICH7: neither IDE port enabled (BIOS)
> [...]

I admit to having no clue about what the 'ide-generic' and 'generic'
modules even do - but could it be that the wrong driver is "grabbing"
the port?

On that hunch I moved the 'ide-generic' module out of the way, and get
the following:

[...]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
pnp: the driver 'ide' has been registered
[...]
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x30b0-0x30b7, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: _NEC DVD_RW ND-4570A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[...]

In this config I could complete the transfer at a little over 500KB/s,
which seems awfully slow but at least completed, and without errors at
that.

Am I on the right track?

Thanks,

Christian
