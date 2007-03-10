From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata-acpi: allow _GTF on SATA, but disable on PATA for now
Date: Sat, 10 Mar 2007 16:40:59 +0000
Message-ID: <20070310164059.4ba68bcc@lxorguk.ukuu.org.uk>
References: <200703100559.l2A5x6kP017578@hera.kernel.org>
	<45F296B9.7000005@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44201 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161041AbXCJPhX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 10:37:23 -0500
In-Reply-To: <45F296B9.7000005@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: kristen.c.accardi@intel.com, len.brown@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

> Alan has been actively working on PATA ACPI, and we have been debugging 
> ACPI issues as well.  PLEASE coordinate with the maintainer, when 
> touching code outside of drivers/acpi!

ap->cbl is not a reliable way to tell SATA from PATA at the moment. We
need to fix the real crashes too - right now no non PCI controller
actually works at all (crash on boot) because of the ACPI crap.

Please drop this patch as it will cause regressions on systems that do
not need the extra methods. Instead merge the one that fixe the non PCI
crashes and we might get further.

> AFAICS this patch went in with zero appearance on LKML or another 
> related list, until submission.  This is /not/ how we do Linux development.

Agreed.

NAK the patch likewise.

Alan
