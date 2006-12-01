From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pata_sl82c105 can not reserve IO region
Date: Sat, 02 Dec 2006 08:53:49 +1100
Message-ID: <1165010029.22108.10.camel@localhost.localdomain>
References: <20061130165202.GA23205@aepfle.de>
	 <20061130171049.7b80a40c@localhost.localdomain>
	 <20061130184748.GA24071@aepfle.de> <20061201183355.GA9701@aepfle.de>
	 <45707CF8.3090106@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:12453 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S967709AbWLAVyU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Dec 2006 16:54:20 -0500
In-Reply-To: <45707CF8.3090106@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Olaf Hering <olaf@aepfle.de>, linux-ide@vger.kernel.org, Alan <alan@lxorguk.ukuu.org.uk>, linuxppc-dev@ozlabs.org

On Fri, 2006-12-01 at 22:05 +0300, Sergei Shtylyov wrote:
> Olaf Hering wrote:
> 
> >>The printk in pci_request_region has 'bar + 1', so 6 should be possible
> >>if i becomes 5.
> 
> > Does the IO region of the last bar look correct?

I think BAR 5 is unassigned by the firmware, though when OF does that,
it often means that an OF driver for that chip decided that the BAR
wasn't useful.

In fact, the driver doesn't actually use that BAR 5... Only 0 to 4
afaik.

I think the libata code shouldn't request the BARs it doesn't need or
that problem will hit us in other circumstances. It should only request
0 to 4 and let the drivers request 5 themselves if they need it.

Ben.


