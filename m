From: Henning Schmiedehausen <hps@intermeta.de>
Subject: Re: PCI Constants Update for SATA Driver
Date: Sun, 27 Feb 2005 20:20:02 +0100
Message-ID: <1109532002.19325.4.camel@forge.intermeta.de>
References: <1109526163.19325.2.camel@forge.intermeta.de>
	 <42220CAA.90702@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from babsi.intermeta.de ([194.77.152.163]:5580 "EHLO
	mail.intermeta.de") by vger.kernel.org with ESMTP id S261470AbVB0TUI
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Feb 2005 14:20:08 -0500
In-Reply-To: <42220CAA.90702@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE Mailingliste <linux-ide@vger.kernel.org>

Hi Jeff,

then what sense does it make to have pci_ids.h at all?

	Regards
		Henning

On Sun, 2005-02-27 at 13:08 -0500, Jeff Garzik wrote:
> Henning Schmiedehausen wrote:
> > Hi,
> > 
> > having the various constants in pci_ids.h is a really good thing for
> > grepping through the kernel source. And if they were used, it would be
> > even better (if you e.g. are looking for which driver claims an SIImage
> > 3112 card...). However, the sata_xxx.c files in the drivers/scsi
> > directory are notorious for not using the PCI Ids but just hard coded
> > numbers.
> > 
> > This patch tries to fix this. It is against the 2.6.10 tree from Fedora
> > Core 3 but should apply to a regular 2.6.10 too.
> 
> "Notorious", heh.  This is quite intentional.
> 
> PCI device ids are just random numbers that vendors pick out of thin 
> air.  Device id symbolic constants have little value, and creates churn 
> whereby every kernel hacker is patching include/linux/pci_ids.h.
> 
> 	Jeff
> 
> 
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

      RedHat Certified Engineer -- Jakarta Turbine Development
   Linux, Java, perl, Solaris -- Consulting, Training, Engineering

"Now you can start with implementation and integration and do the
requirements later".  -- Prof. Dr. Dr. h.c. Manfred Broy about the new
german federal software development standard "V-Model XT"
(found at http://de.biz.yahoo.com/050207/299/4en0t.html)

