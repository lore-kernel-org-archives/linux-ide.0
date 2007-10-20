From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] PCI: disable MSI on more ATI NorthBridges
Date: Sun, 21 Oct 2007 08:03:26 +1000
Message-ID: <1192917806.6745.23.camel@pasglop>
References: <BLU112-W5125F6D8BEB3DF6359D53E29F0@phx.gbl>
	 <20071019195749.GK29903@austin.ibm.com>  <471911BE.2000405@garzik.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:33668 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbXJUBpm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Oct 2007 21:45:42 -0400
In-Reply-To: <471911BE.2000405@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linas Vepstas <linas@austin.ibm.com>, Shane Huang <chunhao.huang@hotmail.com>, davem@davemloft.net, gregkh@suse.de, htejun@gmail.com, brice.goglin@gmail.com, david.gaarenstroom@gmail.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, shane.huang@amd.com, linux-ide@vger.kernel.org, Brice Goglin <brice@myri.com>


On Fri, 2007-10-19 at 16:21 -0400, Jeff Garzik wrote:
> Take a look at tg3.c net driver change 
> 2fbe43f6f631dd7ce19fb1499d6164a5bdb34568 which is a similar situation.
> 
> However, it may turn out that removing the pci_intx() stuff as a
> general 
> rule is easier than quirking these devices, if enough of them turn
> out 
> to have this hardware bug.

We'd have to count how many have this bug vs. how many will emit both
intx and msi unless pci_intx is cleared, and then how many do that
regardless of pci_intx :-)

yuck

Ben.


