From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Merging libata PATA support into the base kernel
Date: Thu, 10 Aug 2006 13:37:44 +0100
Message-ID: <1155213464.22922.6.camel@localhost.localdomain>
References: <1155144599.5729.226.camel@localhost.localdomain>
	 <p733bc5nm5g.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17045 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030552AbWHJMRz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 08:17:55 -0400
In-Reply-To: <p733bc5nm5g.fsf@verdi.suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Ar Iau, 2006-08-10 am 08:24 +0200, ysgrifennodd Andi Kleen:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > - No support for host-protected-area yet
> 
> Even the support in the old one for that wasn't complete. It didn't
> redo the HPA disabling on resume-from-ram, which made parts of the
> disk not accessible anymore after wakeup. So at least on laptops it
> always had to be disabled anyways.

drivers/ide does not support power management yet. Never has. Some
people are brave and use it as it is rather than fix it.

Alan
