From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: What is the correct way to indicate an unassigned PCI resource
	?
Date: Wed, 06 Dec 2006 07:19:01 +1100
Message-ID: <1165349941.5469.1.camel@localhost.localdomain>
References: <20061130165202.GA23205@aepfle.de>
	 <20061204123854.GA28159@aepfle.de>
	 <FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
	 <4574197A.2020204@ru.mvista.com>
	 <4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
	 <45741DDE.4080509@ru.mvista.com>
	 <20061204132124.4f7c50a9@localhost.localdomain>
	 <45742253.1000807@ru.mvista.com>
	 <20061204142201.68d9621f@localhost.localdomain>
	 <1165293679.29784.39.camel@localhost.localdomain>
	 <20061205081557.GA8483@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:46343 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031567AbWLEVVs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Dec 2006 16:21:48 -0500
In-Reply-To: <20061205081557.GA8483@aepfle.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linuxppc-dev@ozlabs.org, greg@kroah.com, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz

On Tue, 2006-12-05 at 09:15 +0100, Olaf Hering wrote:
> On Tue, Dec 05, Benjamin Herrenschmidt wrote:
> 
> > Olaf, can you give me a dump of /proc/ioports ? What is sitting at 0 on
> > that PCI bus ?
> 
> with IDE=y
> 
> ==> /proc/ioports <==
> 00000000-0000001f : dma1

So it's indeed colliding with the cruft above.

I reckon it's a bug in the firmware of this machine.

Add to pseries/pci.c a quirk for that chipset (don't forget to test for
machine_is(pseries) in the quirk as they get called for all platforms in
a combo kernel. The quirk shall check if resource 6 has a 0 base and
clear the size as Alan suggested (possibly setting the UNSET flag as
well).

Ben.


