From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH] include: pci_find_device remove (include/asm-i386/ide.h)
Date: Fri, 7 Oct 2005 00:24:51 +0200
Message-ID: <4af2d03a0510061524m4611d75bn5b1ce6a4e3ebddf1@mail.gmail.com>
References: <200509102032.j8AKWxMC006246@localhost.localdomain>
	 <4323482E.2090409@pobox.com>
Reply-To: Jiri Slaby <jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.198]:27616 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751108AbVJFWYw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Oct 2005 18:24:52 -0400
Received: by wproxy.gmail.com with SMTP id 57so290925wri
        for <linux-ide@vger.kernel.org>; Thu, 06 Oct 2005 15:24:51 -0700 (PDT)
In-Reply-To: <4323482E.2090409@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>

On 9/10/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Jiri Slaby wrote:
> > diff --git a/include/asm-i386/ide.h b/include/asm-i386/ide.h
> > --- a/include/asm-i386/ide.h
> > +++ b/include/asm-i386/ide.h
> > @@ -41,7 +41,12 @@ static __inline__ int ide_default_irq(un
> >
> >  static __inline__ unsigned long ide_default_io_base(int index)
> >  {
> > -     if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) == NULL) {
> > +     struct pci_dev *pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, NULL);
> > +     unsigned int a = !pdev;
> > +
> > +     pci_dev_put(pdev);
>
>
> Looks like we need to resurrect pci_present() from the ancient past.
So, what was the result of this debate? I can't see any solution in
that thread, not even in 2.6.14-rc2-mm2.

thanks,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
