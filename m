From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata.h: Don't do a SATA check for 40wire_relaxed
Date: Tue, 04 Dec 2007 14:20:56 -0500
Message-ID: <4755A898.7050707@garzik.org>
References: <20071119152434.45363e5d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34518 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbXLDTU5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 14:20:57 -0500
In-Reply-To: <20071119152434.45363e5d@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> Without the valid bits at least one set of TSScorp drives report 0 in
> word 93 for PATA 40 wire, which we (and the specs) say actually means
> SATA. (The SATA version seems to report 80 wire...)
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc2-mm1/include/linux/ata.h linux-2.6.24-rc2-mm1/include/linux/ata.h
> --- linux.vanilla-2.6.24-rc2-mm1/include/linux/ata.h	2007-11-16 17:55:20.000000000 +0000
> +++ linux-2.6.24-rc2-mm1/include/linux/ata.h	2007-11-16 18:42:20.000000000 +0000
> @@ -560,8 +560,6 @@
>  
>  static inline int ata_drive_40wire_relaxed(const u16 *dev_id)
>  {
> -	if (ata_id_is_sata(dev_id))
> -		return 0;	/* SATA */
>  	if ((dev_id[93] & 0x2000) == 0x2000)
>  		return 0;	/* 80 wire */
>  	return 1;

I've been thinking a lot about this, and I am really wondering if we 
should fix up the IDENTIFY DEVICE page instead?


