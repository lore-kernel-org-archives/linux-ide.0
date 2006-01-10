From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Adaptec 1420SA issues with MSI
Date: Tue, 10 Jan 2006 01:31:16 -0500
Message-ID: <43C354B4.2070505@pobox.com>
References: <1136667984.2799.0.camel@obelisk.thedillows.org> <20060109221323.65f6987d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:49093 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932077AbWAJGbW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2006 01:31:22 -0500
In-Reply-To: <20060109221323.65f6987d.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Dillow <dave@thedillows.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andi says "It's more likely a hardware bug that needs to be handled by the
> driver maintainer.  sata_mv has an pci_enable_msi().  Hardware that reports
> MSI capability but breaks when it's actually used is not unheard of."


> It seems strange that pci_enable_msi() succeeded if the device is not
> MSI-capable?

Unfortunately this is not strange :(  People have been coding interrupt 
tests into MSI drivers -- shades of the early 90's -- because 
pci_enable_msi() does not fail for systems that do not support MSI. 
-Sometimes- it will fail as expected, if system does not support MSI, 
sometimes not.

For this case -- 32bit non-Intel mobo chipset -- the cause of the 
failure is likely the poor pci_enable_msi() test.

However, I know of at least one MSI-related sata_mv hardware bug that 
needs working around, but that only affects 64-bit.  Given that MSI 
works with this chip on other systems, I'm leaning towards blaming the 
system.

The following are reasonable workarounds:

* Add pci=nomsi kernel parameter... we really need this
* Add 'msi' module option to sata_mv

I'll try to get around to committing the errata to source code. 
Marvell's triple-layered vendor driver is GPL'd, so anyone can steal 
this task from me...

	Jeff


