From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Delkin Devices CFA not recognized
Date: Tue, 23 Feb 2010 17:41:11 +0000
Message-ID: <20100223174111.6113c862@lxorguk.ukuu.org.uk>
References: <808c8e9d1002230903pea21f5al2c09e2420af141c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45948 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751115Ab0BWRhg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Feb 2010 12:37:36 -0500
In-Reply-To: <808c8e9d1002230903pea21f5al2c09e2420af141c9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Gardner <gardner.ben@gmail.com>
Cc: linux-ide@vger.kernel.org

> I tracked the problem down to ata_id_is_cfa() in include/linux/ata.h.
> The Delkin card doesn't match either assumption in that function.
> On the Delkin card, id[0] is 0x844a and id[83] is 0.

844A is not CF so the kernel is behaving correctly.
83 = 0 means it doesn't support the CFA feature set as an ATA device

So the question is why it is reporting 844A

My guess would be that it's trying to report a low byte of 'removable
device' not 'removable media'

> The simple fix for me is to change the id[0] check ata_id_is_cfa() in to
> include 0x844a.
> 
> --- linux-2.6.33-rc8.orig/include/linux/ata.h
> +++ linux-2.6.33-rc8/include/linux/ata.h
> @@ -841,7 +841,8 @@
> 
>  static inline int ata_id_is_cfa(const u16 *id)
>  {
> -	if (id[ATA_ID_CONFIG] == 0x848A)	/* Traditional CF */
> +	if ((id[ATA_ID_CONFIG] == 0x848A) ||	/* Traditional CF */
> +	    (id[ATA_ID_CONFIG] == 0x844A))	/* Delkin Devices CF */
>  		return 1;
>  	/*
>  	 * CF specs don't require specific value in the word 0 anymore and yet
> ---
> 
> While that works, it doesn't seem like a very good solution.
> Here are some of the ATA-related logs after the change:

If they simply got the identifier wrong then it ought to be fine. Might
be worth double checking it's removable behaviour is right. The one thing
you might do is to change in your hack is for the Delkin case also doing
a memcpy(id + whatever, "Delkin Devices", ..) to check the vendor info
matches the expected case. I'm not sure thats even worth it as I can't
see it triggering on anything but misidentified cards anyway.

Submit it to Jeff with a signed off by line.

Alan
