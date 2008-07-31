From: Jeff Garzik <jeff@garzik.org>
Subject: Re: LIBATA: pata_ali.c misplaced pci_dev_put()
Date: Thu, 31 Jul 2008 01:40:21 -0400
Message-ID: <48915045.2050608@garzik.org>
References: <20080724153806.633927699@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44878 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035AbYGaFkZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 01:40:25 -0400
In-Reply-To: <20080724153806.633927699@fluff.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-ide@vger.kernel.org

Ben Dooks wrote:
> The ali_init_one() function does a search for an isa_bridge,
> but then fails to release it if the revision information was
> not correctly found.
> 
> the problem comes from:
> 	isa_bridge = pci_get_device(...);
> 	if (isa_bridge && ...) {
> 		pci_dev_put(isa_bridge);
> 	}
> 
> where the pci_dev_put() is never called if isa_bridge
> was valid but the extra checks on the chip-revision
> fail to match.
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>

applied


