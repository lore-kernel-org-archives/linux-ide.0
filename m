From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_ali: Correct HP detect
Date: Tue, 24 Jul 2007 16:56:27 -0400
Message-ID: <46A6677B.5060209@garzik.org>
References: <20070720153449.5002bf8b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59236 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932808AbXGXU4a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Jul 2007 16:56:30 -0400
In-Reply-To: <20070720153449.5002bf8b@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc6-mm1/drivers/ata/pata_ali.c linux-2.6.22-rc6-mm1/drivers/ata/pata_ali.c
> --- linux.vanilla-2.6.22-rc6-mm1/drivers/ata/pata_ali.c	2007-07-02 20:50:11.000000000 +0100
> +++ linux-2.6.22-rc6-mm1/drivers/ata/pata_ali.c	2007-07-19 10:11:43.000000000 +0100
> @@ -45,7 +45,7 @@
>  		.ident = "HP Pavilion N5430",
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
> -			DMI_MATCH(DMI_BOARD_NAME, "OmniBook N32N-736"),
> +			DMI_MATCH(DMI_BOARD_VERSION, "OmniBook N32N-736"),

applied


