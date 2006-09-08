From: Jeff Garzik <jeff@garzik.org>
Subject: Re: PCI SATA controllers on embedded, no-BIOS targets
Date: Fri, 08 Sep 2006 08:00:18 -0400
Message-ID: <45015B52.3000800@garzik.org>
References: <44EB32E4.8080706@mvista.com> <44EB33BB.4090101@gmail.com> <44EB3650.1080404@mvista.com> <44EB3E2F.4040504@gmail.com> <44EB3F70.6000702@gmail.com> <44EB40DA.3010904@mvista.com> <44EB4658.3060207@gmail.com> <44EB7E13.5090807@mvista.com> <44EBCA7D.60808@gmail.com> <4500A5D4.50606@mvista.com> <4500CB75.6050504@garzik.org> <45011B44.3060101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:22201 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750822AbWIHMA2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Sep 2006 08:00:28 -0400
In-Reply-To: <45011B44.3060101@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Kevin Hilman <khilman@mvista.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> IIRC, Kevin's platform can't do any MMIO.  Also, although sata_sil can 
> be made to use 32-bit address space exclusively, I think having PIO 
> access in the meantime can be helpful to many newer ATI mips platforms 
> out there.  Please note that w/ ioread/write change, the modified code 
> is isolated into init_one(), so the added complexity is small.

Having PIO but not MMIO is _highly_ irregular, especially for non-x86 
platforms.  MMIO is much more common because it is easier to implement 
in hardware than PIO.

As an aside:  We should add a 32-bit variant of ->data_xfer hooks, and 
use where appropriate.

	Jeff


