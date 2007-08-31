From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Switch most of the remaining SFF drivers to ata_sff_port_start
Date: Fri, 31 Aug 2007 05:29:07 -0400
Message-ID: <46D7DF63.7090006@garzik.org>
References: <20070822225541.380ce097@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49287 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753651AbXHaJ3L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Aug 2007 05:29:11 -0400
In-Reply-To: <20070822225541.380ce097@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> This avoids allocating DMA buffers if not needed but at the moment is
> mostly just a neatness item.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied sans pata_acpi change, which is because pata_acpi is not in 
libata-dev.git#upstream


