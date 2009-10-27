From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH ide] : Increase WAIT_DRQ to support slow CF cards
Date: Mon, 26 Oct 2009 18:34:57 -0600
Message-ID: <4AE64031.5060105@gmail.com>
References: <20091026162011.GA3289@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:45723 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbZJ0Aez (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Oct 2009 20:34:55 -0400
In-Reply-To: <20091026162011.GA3289@frolo.macqel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Philippe De Muyter <phdm@macqel.be>
Cc: linux-ide@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org

On 10/26/2009 10:20 AM, Philippe De Muyter wrote:
> Hi,
>
> I just encountered a problem with write-access to a batch of CF cards
> (KINGSTON TECHNOLOGY 4GB COMPACT FLASH CF/4GB
> 3.3V/5V 9904321 - 006.AOOLF 4449081 - 1219643 X001 ASSY IN TAIWAN (c) 2008)
> connected to a PC-CARD / PCMCIA interface, with the following error messages :
>
> 	hda: status timeout: status=0xd0 { Busy }
> 	ide: failed opcode was: unknown
> 	hda: no DRQ after issuing MULTWRITE
>
> After testing with different bigger values for the WAIT_DRQ timeout value,
> the problem disappeared.  I had success with WAIT_DRQ = 500ms, then with
> WAIT_DRQ = 300ms.  I then tested with WAIT_DRQ = 200ms, but the problem
> reappeared.  So I kept the 300ms value.
>
> Signed-off-by: Philippe De Muyter<phdm@macqel.be>
>
> diff -r a145344bb228 include/linux/ide.h
> --- a/include/linux/ide.h	Thu Oct 22 08:28:28 2009 +0900
> +++ b/include/linux/ide.h	Mon Oct 26 16:51:23 2009 +0100
> @@ -125,8 +125,8 @@
>    * Timeouts for various operations:
>    */
>   enum {
> -	/* spec allows up to 20ms */
> -	WAIT_DRQ	= HZ / 10,	/* 100ms */
> +	/* spec allows up to 20ms, but some CF cards need more than 200ms */
> +	WAIT_DRQ	= 3 * HZ / 10,	/* 300ms */
>   	/* some laptops are very slow */
>   	WAIT_READY	= 5 * HZ,	/* 5s */
>   	/* should be less than 3ms (?), if all ATAPI CD is closed at boot */

This has come up before:

http://marc.info/?l=linux-ide&m=123064513313466&w=2

I think this timeout should not even exist. libata has no such timeout 
(only the overall command completion timeout), and I can't find any 
reference in current ATA specs to the device being required to raise DRQ 
in any particular amount of time.
