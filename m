From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: LIBATA: pata_ali.c misplaced pci_dev_put()
Date: Thu, 24 Jul 2008 16:34:01 +0100
Message-ID: <20080724163401.56e5d674@lxorguk.ukuu.org.uk>
References: <20080724153806.633927699@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60866 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751027AbYGXPvK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 11:51:10 -0400
In-Reply-To: <20080724153806.633927699@fluff.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>

On Thu, 24 Jul 2008 16:38:06 +0100
Ben Dooks <ben-linux@fluff.org> wrote:

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

Ooops...

Acked-by: Alan Cox <alan@redhat.com>
