From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 3/3] libata: PATA driver	for Celleb
Date: Tue, 20 Feb 2007 10:47:22 -0500
Message-ID: <45DB180A.5020302@garzik.org>
References: <200701260727.l0Q7Rovv019682@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43980 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965171AbXBTPra (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Feb 2007 10:47:30 -0500
In-Reply-To: <200701260727.l0Q7Rovv019682@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, benh@kernel.crashing.org, arnd@arndb.de, paulus@samba.org, linas@austin.ibm.com, jeff@garzik.org, alan@lxorguk.ukuu.org.uk

Akira Iguchi wrote:
> This is the patch for PATA controller of Celleb.
> 
> This driver uses the managed iomap (devres).
> 
> Because this driver needs special taskfile accesses, there is
> a copy of ata_std_softreset(). ata_dev_try_classify() is exported
> so that it can be used in this function.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>

applied


