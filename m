From: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] pata-rb532-cf: read/write data in 4-byte blocks
Date: Wed, 12 Nov 2008 03:25:50 +0100
Message-ID: <200811120325.51136.florian@openwrt.org>
References: <1226448783-10047-1-git-send-email-n0-1@freewrt.org> <1226448821-10933-1-git-send-email-n0-1@freewrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:55192 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbYKLCZz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Nov 2008 21:25:55 -0500
Received: by fg-out-1718.google.com with SMTP id 19so219915fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 11 Nov 2008 18:25:53 -0800 (PST)
In-Reply-To: <1226448821-10933-1-git-send-email-n0-1@freewrt.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Hi Phil,

(CC'in Jeff as he is the libata maintainer).

Le Wednesday 12 November 2008 01:13:41 Phil Sutter, vous avez =E9crit=A0=
:
> * rename the offset definition to avoid abiguity with the standard AT=
A
>   IO address
> * read and write four bytes at once like the original driver does
> * use writesl() and readsl() which implicitly iterate over the data
>
> This patch assumes buflen to be a multiple of four, which is true for
> ATA devices. ATAPI support is not known, though unlikely, as the
> original driver always transfers 512 Bytes at once.
>
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
> Acked-by: Sergei Shtyltov <sshtylyov@ru.mvista.com>

Acked-by: Florian Fainelli <florian@openwrt.org>
