From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: pata_it821x completely broken
Date: Sun, 6 Jul 2008 23:46:59 +0200
Message-ID: <200807062347.01200.linux@rainbow-software.org>
References: <200807042153.56644.linux@rainbow-software.org> <200807062303.05994.linux@rainbow-software.org> <20080706215146.63d9dfd2@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.atlantis.sk ([80.94.52.35]:36237 "EHLO mail.atlantis.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754188AbYGFVrH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Jul 2008 17:47:07 -0400
In-Reply-To: <20080706215146.63d9dfd2@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Sunday 06 July 2008 22:51:46 Alan Cox wrote:
> > Maxtor 7270 AV - is detected by firmware but oopses in Linux:
> >
> > pata_it821x: forcing bypass mode.
> > pata_it821x: controller in pass through mode.
> > ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
> > ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKC] -> GSI 11 (level, low)
> > -> IRQ 11
> > irq 11: nobody cared (try booting with the "irqpoll" option)
> > Pid: 1, comm: swapper Not tainted 2.6.25.3-pentium #5
> >  [<c012f48f>] __report_bad_irq+0x24/0x69
> >  [<c012f496>] __report_bad_irq+0x2b/0x69
>
> Please file a bug for this - that's upsetting the core libata code
> somewhere, perhaps from a left over floating interrupt.

Here it is: http://bugzilla.kernel.org/show_bug.cgi?id=11047

>
> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
Ondrej Zary
