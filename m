From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [patch] PCI: disable MSI on more ATI NorthBridges
Date: Tue, 23 Oct 2007 01:48:54 +0200
Message-ID: <m3abqau2vt.fsf@maximus.localdomain>
References: <BLU112-W5125F6D8BEB3DF6359D53E29F0@phx.gbl>
	<20071019195749.GK29903@austin.ibm.com> <471911BE.2000405@garzik.org>
	<Pine.LNX.4.64.0710221555190.32497@iabervon.org>
	<471D0ADC.7000005@garzik.org>
	<Pine.LNX.4.64.0710221700120.32497@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:34964 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbXJVXs5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2007 19:48:57 -0400
In-Reply-To: <Pine.LNX.4.64.0710221700120.32497@iabervon.org> (Daniel Barkalow's message of "Mon, 22 Oct 2007 17:31:04 -0400 (EDT)")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: Jeff Garzik <jeff@garzik.org>, Linas Vepstas <linas@austin.ibm.com>, Shane Huang <chunhao.huang@hotmail.com>, davem@davemloft.net, gregkh@suse.de, htejun@gmail.com, brice.goglin@gmail.com, david.gaarenstroom@gmail.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, shane.huang@amd.com, linux-ide@vger.kernel.org, Brice Goglin <brice@myri.com>

Daniel Barkalow <barkalow@iabervon.org> writes:

> 00:05.0 Audio device: nVidia Corporation MCP61 High Definition Audio (rev a2)
>
> will have the same issue, and use a multi-vendor driver.

I think MCP55 HDA did not have such problem, though I may be wrong
(AFAIR it worked with shared IRQ and with MSI).
-- 
Krzysztof Halasa
