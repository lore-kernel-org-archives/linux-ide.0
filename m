From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 07/20] pata_pcmcia: recognize 2GB CompactFlash from Transcend
Date: Fri, 11 May 2007 18:16:17 -0400
Message-ID: <4644EB31.1010204@garzik.org>
References: <200705110548.l4B5mmj0007633@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43671 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754239AbXEKWQX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 May 2007 18:16:23 -0400
In-Reply-To: <200705110548.l4B5mmj0007633@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, Fabrice.Aeschbacher@siemens.com, alan@redhat.com, bzolnier@gmail.com, stuge-linux-pcmcia@cdy.org

akpm@linux-foundation.org wrote:
> From: "Aeschbacher, Fabrice" <Fabrice.Aeschbacher@siemens.com>
> 
> Allow the pata_pcmcia driver to automatically detect 2GB CompactFlash cards
> from Transcend.
> 
> Signed-off-by: Fabrice Aeschbacher <fabrice.aeschbacher@siemens.com>
> Cc: "Peter Stuge" <stuge-linux-pcmcia@cdy.org>
> Acked-by: Alan Cox <alan@redhat.com>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/pata_pcmcia.c |    1 +
>  1 file changed, 1 insertion(+)

applied


