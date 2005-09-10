From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] include: pci_find_device remove (include/asm-i386/ide.h)
Date: Sat, 10 Sep 2005 16:55:10 -0400
Message-ID: <4323482E.2090409@pobox.com>
References: <200509102032.j8AKWxMC006246@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932298AbVIJUz0@vger.kernel.org>
In-Reply-To: <200509102032.j8AKWxMC006246@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
List-Id: linux-ide@vger.kernel.org

Jiri Slaby wrote:
> diff --git a/include/asm-i386/ide.h b/include/asm-i386/ide.h
> --- a/include/asm-i386/ide.h
> +++ b/include/asm-i386/ide.h
> @@ -41,7 +41,12 @@ static __inline__ int ide_default_irq(un
>  
>  static __inline__ unsigned long ide_default_io_base(int index)
>  {
> -	if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) == NULL) {
> +	struct pci_dev *pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, NULL);
> +	unsigned int a = !pdev;
> +
> +	pci_dev_put(pdev);


Looks like we need to resurrect pci_present() from the ancient past.

	Jeff
