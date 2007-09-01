From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_via: write errors on PATA drive connected to VT6421
Date: Sat, 01 Sep 2007 06:52:36 -0400
Message-ID: <46D94474.7080905@garzik.org>
References: <200708202242.07290.linux@rainbow-software.org> <20070821132731.6bf10b50@the-village.bc.nu> <200709010055.22200.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56009 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739AbXIAKwm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Sep 2007 06:52:42 -0400
In-Reply-To: <200709010055.22200.linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Ondrej Zary wrote:
> Hello,
> I think that I've found and fixed the problem. There is a copy/paste bug in 
> vt6421_set_dma_mode() function which causes wrong values to be written to 
> PATA_UDMA_TIMING register.
> 
> 
> This patch fixes a copy/paste bug that breaks DMA modes on VT6421 PATA port.
> 
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

applied


