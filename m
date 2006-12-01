From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_sl82c105 can not reserve IO region
Date: Fri, 1 Dec 2006 22:15:25 +0000
Message-ID: <20061201221525.7a741062@localhost.localdomain>
References: <20061130165202.GA23205@aepfle.de>
	<20061130171049.7b80a40c@localhost.localdomain>
	<20061130184748.GA24071@aepfle.de>
	<20061201183355.GA9701@aepfle.de>
	<45707CF8.3090106@ru.mvista.com>
	<1165010029.22108.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48555 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1162058AbWLAWIm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Dec 2006 17:08:42 -0500
In-Reply-To: <1165010029.22108.10.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Olaf Hering <olaf@aepfle.de>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On Sat, 02 Dec 2006 08:53:49 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> In fact, the driver doesn't actually use that BAR 5... Only 0 to 4
> afaik.
> 
> I think the libata code shouldn't request the BARs it doesn't need or
> that problem will hit us in other circumstances. It should only request
> 0 to 4 and let the drivers request 5 themselves if they need it.

I don't think that is the problem. pci_request_regions() handles all
this internally. It is incorrect for me to not request BAR 5
if present as nobody else should use that resource with my driver loaded.

The underlying problem appears to be that PPC64 isn't setting up the
resources properly (at least as viewed by the pci core code). If a
resource is not set up then pci_request_resource() correctly handles
it .. except on PPC64. You have a resource at zero with a length and
type. PPC64 is not reporting to the upper layers that the resource was
not allocated. It is reporting that the resource *was* allocated, and at a
bogus address of zero.

If you trust the firmware that is fine, but you need to report the truth,
at which point pci_request_resources() will work correctly.

Alan
