From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: Invalid use of writel/readl with iomap
Date: Fri, 23 Nov 2007 19:35:31 -0500
Message-ID: <474771D3.5060101@garzik.org>
References: <20071119142828.4fe4ee55@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34131 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440AbXKXAff (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 19:35:35 -0500
In-Reply-To: <20071119142828.4fe4ee55@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

Alan Cox wrote:
> Should use ioread* as discussed previously
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied to #upstream-fixes, after s/ahci/ata_piix/ in subject line


