From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata: Detect Delkin Devices compact flash
Date: Mon, 01 Mar 2010 15:12:24 -0500
Message-ID: <4B8C1FA8.7000706@pobox.com>
References: <808c8e9d1002231041la0d2cd9y35e9bce347d4d2db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f197.google.com ([209.85.211.197]:39736 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab0CAUMe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Mar 2010 15:12:34 -0500
Received: by ywh35 with SMTP id 35so1371121ywh.4
        for <linux-ide@vger.kernel.org>; Mon, 01 Mar 2010 12:12:33 -0800 (PST)
In-Reply-To: <808c8e9d1002231041la0d2cd9y35e9bce347d4d2db@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Gardner <gardner.ben@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On 02/23/2010 01:41 PM, Ben Gardner wrote:
> I have a Delkin Devices compact flash card that isn't being recognized using the
> SATA/PATA drivers.
> The card is recognized and works with the deprecated ATA drivers.
>
> The error I am seeing is:
> ata1.00: failed to IDENTIFY (device reports invalid type, err_mask=0x0)
>
> I tracked it down to ata_id_is_cfa() in include/linux/ata.h.
> The Delkin card has id[0] set to 0x844a and id[83] set to 0.
> This isn't what the kernel expects and is probably incorrect.
>
> The simplest work-around is to add a check for 0x844a to ata_id_is_cfa().
>
> Signed-off-by: Ben Gardner<gardner.ben@gmail.com>

applied


