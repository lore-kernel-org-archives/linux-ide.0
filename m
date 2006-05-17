From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [RFT] major libata update
Date: Thu, 18 May 2006 00:25:43 +0900
Message-ID: <87ves44qrs.fsf@duaron.myhome.or.jp>
References: <20060515170006.GA29555@havoc.gtf.org>
	<3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>
	<446914C7.1030702@garzik.org>
	<3aa654a40605152036h40fa1cd0x8edd81431c1bd22d@mail.gmail.com>
	<44694C4F.3000008@garzik.org>
	<3aa654a40605152133x516581f9w62c7cb7709864fb0@mail.gmail.com>
	<Pine.LNX.4.64.0605160755170.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750702AbWEQPZw@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605160755170.3866@g5.osdl.org> (Linus Torvalds's message of "Tue, 16 May 2006 07:57:36 -0700 (PDT)")
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Avuton Olrich <avuton@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
List-Id: linux-ide@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 15 May 2006, Avuton Olrich wrote:
>
> diff --git a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
> index 06dab00..49b9fea 100644
> --- a/arch/i386/pci/irq.c
> +++ b/arch/i386/pci/irq.c
> @@ -880,6 +880,7 @@ static int pcibios_lookup_irq(struct pci
>  	((!(pci_probe & PCI_USE_PIRQ_MASK)) || ((1 << irq) & mask)) ) {
>  		DBG(" -> got IRQ %d\n", irq);
>  		msg = "Found";
> +		eisa_set_level_irq(irq);
>  	} else if (newirq && r->set && (dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) {
>  		DBG(" -> assigning IRQ %d", newirq);
>  		if (r->set(pirq_router_dev, dev, pirq, newirq)) {

I like it. I'd like to put this type stuff (fixes setting of 8259,
APIC, chipset, etc.) into pci...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
