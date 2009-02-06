From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] [resend] Resume from hibernation fails with pata_it821x
 RAID volume
Date: Fri, 06 Feb 2009 20:46:51 +0300
Message-ID: <498C778B.7020309@ru.mvista.com>
References: <200902061412.09839.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:26063 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751878AbZBFRq0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Feb 2009 12:46:26 -0500
In-Reply-To: <200902061412.09839.linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Ondrej Zary wrote:

> hibernation didn't work for me since I started to use IT8212 controller. Now I 
> did some debugging (booting with no_console_suspend init=/bin/sh).

> Found that resume fails (2.6.28) with "serial number mismatch 'some 
> garbage' != 'some other garbage'" and "revalidation failed" messages. That's 
> because the controller firmware fills different serial number in the IDENTIFY 
> every boot.

> The patch below fixes the resume simply clearing the serial number. The proper 
> fix would be probably to fill in the serial number of the RAID volume 
> instead.

    I wonder why they just don't put it there (if they indeed have such 
number). If I don't mistake, this is a RAID disk?

> I assume that there must be something like that stored on the drives 
> but I don't know where.

> Fix resume on pata_it821x RAID volume by clearing the serial number in 
> IDENTIFY data, which is otherwise different on each boot.

> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

> --- linux-2.6.28-orig/drivers/ata/pata_it821x.c	2009-01-02 17:18:36.000000000 
> +0100
> +++ linux/drivers/ata/pata_it821x.c	2009-02-02 17:47:57.000000000 +0100
> @@ -561,6 +561,9 @@
>  		id[83] |= 0x4400;	/* Word 83 is valid and LBA48 */
>  		id[86] |= 0x0400;	/* LBA48 on */
>  		id[ATA_ID_MAJOR_VER] |= 0x1F;
> +		/* Clear the serial number because it's different each boot
> +		   which breaks validation on resume */

    See CodingStyle chapter 8 for the preferred multiline comment style.

> +		memset(&id[ATA_ID_SERNO], 0x20, ATA_ID_SERNO_LEN);

    Why not ' '?

MBR, Sergei
