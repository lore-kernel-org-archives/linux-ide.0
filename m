From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC 0/2] libata: legacy mode fixes
Date: Fri, 26 May 2006 20:02:10 -0400
Message-ID: <44779702.5070407@pobox.com>
References: <20060524165006.GC12022@harddisk-recovery.com> <4476947A.3020003@tw.ibm.com> <4476991E.5060506@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60128 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751148AbWE0ACU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 May 2006 20:02:20 -0400
In-Reply-To: <4476991E.5060506@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Erik Mouw <erik@harddisk-recovery.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, rene.herman@keyaccess.nl, Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Albert Lee wrote:
> Dear all,
> 
> Description:
> This is the revised patch by Unicorn and I for legacy mode fix.
> 
> patch 1/2: make both legacy ports share one host_set.
> patch 2/2: remove the unused ap->hard_port_no.

Unfortunately, NAK.

While it would be nice to eventually share one host_set, your patch 
demonstrates the hacks that must be added to the hot path, to deal with 
two separate interrupt handlers trying to share the same host_set.

Additionally, neither this email nor the two patches describes the 
problem you are trying to fix, and how these changes fix that problem.

The correct solution, long term, is
1) move the irq registration (request_irq, free_irq) out of 
ata_device_add().  The current design was convenient initially, but I 
have known since I wrote the code that it was insufficient, long term.

The best solution is to give each LLDD the ability to register an 
interrupt handler in a manner best suited to the hardware.  Consider, 
for example, how poorly the current design will work on PCI MSI-X hardware.

2) For legacy mode hardware, one should pass struct ata_port* to 
request_irq(), rather then struct ata_host_set*.  Thus in the legacy ATA 
interrupt handler, obtain the host_set via ap->host_set.

	Jeff



