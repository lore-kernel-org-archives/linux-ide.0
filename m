From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Thu, 11 Aug 2005 16:56:15 -0400
Message-ID: <42FBBB6F.1030306@pobox.com>
References: <200508111424.43150.bjorn.helgaas@hp.com> <42FBB6C5.2070404@pobox.com> <200508111445.41428.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:51880 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932452AbVHKU4U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 16:56:20 -0400
In-Reply-To: <200508111445.41428.bjorn.helgaas@hp.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org

Bjorn Helgaas wrote:
> On Thursday 11 August 2005 2:36 pm, Jeff Garzik wrote:
> 
>>Bjorn Helgaas wrote:
>>
>>>IA64 boxes only have PCI IDE devices, so there's no need to blindly poke
>>>around in I/O port space.  Poking at things that don't exist causes MCAs
>>>on HP ia64 systems.
>>>
>>>Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>>>
>>>Index: work-vga/drivers/ide/Kconfig
>>>===================================================================
>>>--- work-vga.orig/drivers/ide/Kconfig	2005-08-10 14:57:47.000000000 -0600
>>>+++ work-vga/drivers/ide/Kconfig	2005-08-10 14:58:02.000000000 -0600
>>>@@ -276,6 +276,7 @@
>>> 
>>> config IDE_GENERIC
>>> 	tristate "generic/default IDE chipset support"
>>>+	depends on !IA64
>>
>>hmmmmmmmmm.  Are you POSITIVE that the legacy IDE ports are never enabled?
>>
>>In modern Intel chipsets, this still occurs with e.g. combined mode.
> 
> 
> I don't know about combined mode.  If the legacy IDE ports are
> enabled, shouldn't they be described via ACPI, and hence usable
> via the ide_pnp - PNPACPI - ACPI path?

No idea...  that's more for platform IA64 people to answer :/

	Jeff



