From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_sl82c105 can not reserve IO region
Date: Sun, 3 Dec 2006 23:39:02 +0000
Message-ID: <20061203233902.4550e39f@localhost.localdomain>
References: <20061130165202.GA23205@aepfle.de>
	<20061130171049.7b80a40c@localhost.localdomain>
	<20061130184748.GA24071@aepfle.de>
	<20061201183355.GA9701@aepfle.de>
	<45707CF8.3090106@ru.mvista.com>
	<1165010029.22108.10.camel@localhost.localdomain>
	<20061201221525.7a741062@localhost.localdomain>
	<1165011583.22108.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27526 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1759739AbWLCXcF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Dec 2006 18:32:05 -0500
In-Reply-To: <1165011583.22108.17.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Olaf Hering <olaf@aepfle.de>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On Sat, 02 Dec 2006 09:19:43 +1100
> We don't have a choice but to trust the firmware on those machines. We
> can't assign things ourselves on most of them for various reasons (in
> many cases, the hypervisor won't let us).
> 
> So you suggest that I clear resource->flags in that case ?

That will do the trick yes.
 
> I think part of the problem is a firmware bug in that the firmware data
> actually decodes to BAR 5 is assigned to address 0 ... I suppose we can
> consider that address 0 is never valid on those machines and consider
> that as unassigned 

The core PCI code already "knows" that zero in a resource_start() is
unassigned
