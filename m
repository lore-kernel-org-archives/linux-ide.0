From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] driver/ata: PATA driver	for Celleb
Date: Wed, 24 Jan 2007 20:20:33 -0500
Message-ID: <45B805E1.1030906@garzik.org>
References: <200701170924.l0H9OsdG002754@harpo.it.uu.se> <45AE539E.2040600@garzik.org> <17838.34747.222649.93821@alkaid.it.uu.se> <200701180055.l0I0tl6M021051@toshiba.co.jp> <200701180129.l0I1TL48013407@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60923 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965031AbXAYBUj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Jan 2007 20:20:39 -0500
In-Reply-To: <200701180129.l0I1TL48013407@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: Mikael Pettersson <mikpe@it.uu.se>, alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, arnd@arndb.de, kou.ishizaki@toshiba.co.jp, linas@austin.ibm.com, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org

Akira Iguchi wrote:
> This is the patch for PATA controller of Celleb.
> It depends on the previous "add another IRQ calls" patch.
> 
> Because this driver needs special taskfile accesses, there is
> a copy of ata_std_softreset(). ata_dev_try_classify() is exported
> so that it can be used in this function.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>

The driver looks OK, the only thing I wonder is:  can you use the iomap 
interface to eliminate the rest of the duplicated code?

See Tejun's latest patchset "[PATCHSET] Managed device resources, take 
#3" which completes the conversion of libata to using the lib/iomap.c 
interface.

	Jeff



