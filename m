From: Henning Schmiedehausen <hps@intermeta.de>
Subject: Re: PCI Constants Update for SATA Driver
Date: Sun, 27 Feb 2005 21:05:06 +0100
Message-ID: <1109534706.19325.6.camel@forge.intermeta.de>
References: <1109526163.19325.2.camel@forge.intermeta.de>
	 <42220CAA.90702@pobox.com> <1109532002.19325.4.camel@forge.intermeta.de>
	 <4222250C.6060302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from babsi.intermeta.de ([194.77.152.163]:7889 "EHLO
	mail.intermeta.de") by vger.kernel.org with ESMTP id S261260AbVB0UFL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Feb 2005 15:05:11 -0500
In-Reply-To: <4222250C.6060302@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE Mailingliste <linux-ide@vger.kernel.org>

Let me rephrase:

What sense does it make to have PCI_VENDOR_ID and PCI_DEVICE_ID
constants if using them is optional/discouraged?

	Regards
		Henning



On Sun, 2005-02-27 at 14:52 -0500, Jeff Garzik wrote:
> Henning Schmiedehausen wrote:
> > Hi Jeff,
> > 
> > then what sense does it make to have pci_ids.h at all?
> 
> pci_ids.h does not only contain PCI_DEVICE_ID_xxx constants.
> 
> 	Jeff
> 
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

