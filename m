From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Set transfer sizes properly for ATAPI
Date: Thu, 20 Sep 2007 22:44:58 +0100
Message-ID: <20070920224458.411a78c3@the-village.bc.nu>
References: <20070920150144.4772e18d@the-village.bc.nu>
	<46F2DC54.8040908@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47466 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751102AbXITVhw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 17:37:52 -0400
In-Reply-To: <46F2DC54.8040908@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Thu, 20 Sep 2007 16:47:16 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Alan Cox wrote:
> > In theory this isn't needed. In practice it seems to matter now and then
> > and was also done by the old IDE DMA layer.
> > 
> > Signed-off-by: Alan Cox <alan@redhat.com>
> 
> applied a modified version (attached)

Can you guarantee our transfer size never exceeds 63Kbytes (see the spec
for what occurs after that - its not intuitive)
