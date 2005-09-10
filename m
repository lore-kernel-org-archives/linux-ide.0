From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] include: pci_find_device remove (include/asm-i386/ide.h)
Date: Sat, 10 Sep 2005 17:39:52 -0400
Message-ID: <432352A8.3010605@pobox.com>
References: <200509102032.j8AKWxMC006246@localhost.localdomain> <4323482E.2090409@pobox.com> <20050910211932.GA13679@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:19861 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932325AbVIJVj7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Sep 2005 17:39:59 -0400
In-Reply-To: <20050910211932.GA13679@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

Greg KH wrote:
> On Sat, Sep 10, 2005 at 04:55:10PM -0400, Jeff Garzik wrote:
> 
>>Jiri Slaby wrote:
>>
>>>diff --git a/include/asm-i386/ide.h b/include/asm-i386/ide.h
>>>--- a/include/asm-i386/ide.h
>>>+++ b/include/asm-i386/ide.h
>>>@@ -41,7 +41,12 @@ static __inline__ int ide_default_irq(un
>>>
>>>static __inline__ unsigned long ide_default_io_base(int index)
>>>{
>>>-	if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) == NULL) {
>>>+	struct pci_dev *pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, NULL);
>>>+	unsigned int a = !pdev;
>>>+
>>>+	pci_dev_put(pdev);
>>
>>
>>Looks like we need to resurrect pci_present() from the ancient past.
> 
> 
> Heh, ick, no :)
> 
> Jiri, any other way to do this instead?

Look at what the IDE code is trying to do.  All it cares about is 
whether -any PCI device at all- is present, a boolean value.

	Jeff


