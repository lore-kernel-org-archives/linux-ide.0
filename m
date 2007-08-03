From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.23-rc1: pata_via cable detection differs from via82cxxx
Date: Fri, 3 Aug 2007 23:32:17 +0100
Message-ID: <20070803233217.54c82022@the-village.bc.nu>
References: <200708031828.l73ISdY9022725@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35584 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758100AbXHCWZC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Aug 2007 18:25:02 -0400
In-Reply-To: <200708031828.l73ISdY9022725@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

On Fri, 3 Aug 2007 20:28:39 +0200 (MEST)
Mikael Pettersson <mikpe@it.uu.se> wrote:

> The machine is an Athlon64 laptop with a K8T800 chipset. With the IDE
> VIA driver the disk is detected as udma/100:

Currently old IDE via driver has a hack in it which goes 'did the BIOS
set UDMA3+' then I guess the cable is 80 wire regardless. libata doesn't
do that as it breaks with hotplug, breaks with suspend/resume before the
driver is loaded and other bits.

Instead we have two things - an ACPI snoop and a table of wonky laptops
(eg those that use 40 wire ultrashort cables which are valid for UDMA133
but not detected as 80 wire). If your laptop is done that way then it
just needs adding to the magic list and/or 2.6.23-rc1-mm should spot it
by ACPI. I'd prefer the table entry anyway as I don't like relying on ACPI
so an lspci -vvxx would be appreciated
