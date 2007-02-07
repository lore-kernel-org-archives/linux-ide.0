From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/3] libata: add another IRQ calls (core and headers)
Date: Tue, 06 Feb 2007 19:33:02 -0500
Message-ID: <45C91E3E.2030402@garzik.org>
References: <200701260727.l0Q7R4Fs005076@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56852 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030456AbXBGAdI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Feb 2007 19:33:08 -0500
In-Reply-To: <200701260727.l0Q7R4Fs005076@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, benh@kernel.crashing.org, arnd@arndb.de, paulus@samba.org, linas@austin.ibm.com, alan@lxorguk.ukuu.org.uk

Akira Iguchi wrote:
> This patch is against the libata core and headers.
> 
> Two IRQ calls are added in ata_port_operations.
> - irq_on() is used to enable interrupts. 
> - irq_ack() is used to acknowledge a device interrupt.
> 
> In most drivers, ata_irq_on() and ata_irq_ack() are used for
> irq_on and irq_ack respectively. 
> 
> In some drivers (ex: ahci, sata_sil24) which cannot use them
> as is, ata_dummy_irq_on() and ata_dummy_irq_ack() are used.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>

applied


