From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Set transfer sizes properly for ATAPI
Date: Fri, 21 Sep 2007 23:14:16 +0100
Message-ID: <20070921231416.795da300@the-village.bc.nu>
References: <20070920150144.4772e18d@the-village.bc.nu>
	<46F2DC54.8040908@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:44954 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761646AbXIUWHV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Sep 2007 18:07:21 -0400
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

NAK your version on testing. Mine works, yours doesn't.
