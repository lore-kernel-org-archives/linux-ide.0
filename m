From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SATA feature list available
Date: Thu, 15 Dec 2005 17:51:46 +0000
Message-ID: <1134669106.12421.67.camel@localhost.localdomain>
References: <43A1A37E.4070806@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750868AbVLORvr@vger.kernel.org>
In-Reply-To: <43A1A37E.4070806@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Iau, 2005-12-15 at 12:10 -0500, Jeff Garzik wrote:
> For people such as marketing types working on a distro, or users just 
> looking for quick answers, I've created a feature list for libata:
> 
> 	http://linux.yyz.us/sata/features.html
> 
> Let me know if there is anything missing.  This is just a quick list, 
> details can be found on other pages at that site.


Comments

IDE isn't really supported yet. EIDE/ATA is mostly.
PCI IDE legacy/native - yes but we don't handle mixed

"Full support for initializing PATA device, controller timings" -
Nowhere near until the indpendent timing stuff is merged

Under not supported might be worth adding HPA, simplex DMA, legacy ISA
devices.


Controllers: -ac patch now has (not all tested or by any means ready for
the mainstream!)

ALi (no MWDMA yet)
AMD
ATIIXP
CS5520 (no VDMA)
CS5530
CS5535
CS5536
EFAR
HPT343/363
HPT36x
HPT37x
HPT3x2N
IT8172
IT821X
MPIIX
early PIIX
OPTI
PIIX/ICH/ESB etc
RZ1000 workarounds
SC1200
SIS (no MWDMA on some versions)
Serverworks OSB4/CSB5/CSB6
SL82C105
Triflex
VIA

Big glaring holes in the PC world

CMD64x
ARTOP
Earlier Promise
