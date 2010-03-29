From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_mpc52xx: reduce code size by simple change of constant
 data types
Date: Mon, 29 Mar 2010 16:19:56 -0400
Message-ID: <4BB10B6C.4070402@pobox.com>
References: <201003050827.40384.roman.fietze@telemotive.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f182.google.com ([209.85.223.182]:41198 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab0C2U1e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Mar 2010 16:27:34 -0400
Received: by iwn12 with SMTP id 12so958559iwn.21
        for <linux-ide@vger.kernel.org>; Mon, 29 Mar 2010 13:27:33 -0700 (PDT)
In-Reply-To: <201003050827.40384.roman.fietze@telemotive.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roman Fietze <roman.fietze@telemotive.de>
Cc: linux-ide@vger.kernel.org

On 03/05/2010 02:27 AM, Roman Fietze wrote:
> Hello List members, hello Jeff,
>
> I've prepared a totally simple patch that, if I did it and measured it
> correctly, reduces the text size as of the ppc-6xx-size command of
> pata-mpc52xx by more than 10%, by reducing the rodata size from 0x4a4
> to 0x17e bytes. This is simply done by changing the data types of the
> ATA timing constants.
>
> If you are interested at all, and it's worth the trouble, here the
> details:
>
> ppc-6xx-size:
>       text data bss  dec  hex filename
> old: 6532 1068   0 7600 1db0 pata-mpc52xx.o
> new: 5718 1068   0 6786 1a82 pata-mpc52xx.o
>
> The (assembler) code itself doesn't really change very much. I double
> checked the final results inside mpc52xx-ata-apply-timings() and they
> match. The driver is still working fine of course.
>
>
>
> Signed-off-by: Roman Fietze<roman.fietze@telemotive.de>
> ---
>   drivers/ata/pata_mpc52xx.c |   78 ++++++++++++++++++++++----------------------
>   1 files changed, 39 insertions(+), 39 deletions(-)

applied


