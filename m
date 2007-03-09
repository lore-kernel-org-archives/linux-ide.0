From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_pdc2027x: Restore various updates done on the driver
Date: Fri, 09 Mar 2007 08:03:22 -0500
Message-ID: <45F15B1A.7000805@garzik.org>
References: <20070308233920.7371d07d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55893 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767256AbXCINDZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 08:03:25 -0500
In-Reply-To: <20070308233920.7371d07d@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> - Use of cable_detect method
> - ata_pci_default_filter needed on PATA100 ops
> - Filter for UDMA 133 errata from vendor (not enabled in this diff but
> added ready)
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied


