From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 04/10] Ata: pata_marvell, use ioread* for iomap-ped memory
Date: Wed, 03 Oct 2007 14:44:08 -0400
Message-ID: <4703E2F8.7090007@garzik.org>
References: <200710022053.l92Kr1GG021682@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36688 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754252AbXJCSoO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2007 14:44:14 -0400
In-Reply-To: <200710022053.l92Kr1GG021682@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, jirislaby@gmail.com, alan@lxorguk.ukuu.org.uk

akpm@linux-foundation.org wrote:
> From: Jiri Slaby <jirislaby@gmail.com>
> 
> pata_marvell, use ioread* for iomap-ped memory
> 
> read* on pci_iomapped memory is incorrect, fix it
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> Acked-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

applied


