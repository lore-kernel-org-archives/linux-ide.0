From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [uclinux-dist-devel] [PATCH] ata: pata-bf54x: Support sg list in
 bmdma transfer.
Date: Sat, 31 Dec 2011 00:42:07 -0500
Message-ID: <CAMjpGUc00v4gNT5aL9P7HEgP32R8R=Cy_OV-6EZK2+aOx7yBfg@mail.gmail.com>
References: <1325302324-28635-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50973 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab1LaFma convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Dec 2011 00:42:30 -0500
Received: by eaad14 with SMTP id d14so6937807eaa.19
        for <linux-ide@vger.kernel.org>; Fri, 30 Dec 2011 21:42:28 -0800 (PST)
In-Reply-To: <1325302324-28635-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: David Miller <davem@davemloft.net>, sshtylyov@mvista.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

On Fri, Dec 30, 2011 at 22:32, Sonic Zhang <sonic.adi@gmail.com> wrote:
> --- a/drivers/ata/pata_bf54x.c
> +++ b/drivers/ata/pata_bf54x.c
>
> +struct dma_desc_array {
> + =C2=A0 =C2=A0 =C2=A0 unsigned long =C2=A0 start_addr;
> + =C2=A0 =C2=A0 =C2=A0 unsigned short =C2=A0cfg;
> + =C2=A0 =C2=A0 =C2=A0 unsigned short =C2=A0x_count;
> + =C2=A0 =C2=A0 =C2=A0 short =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x_mod=
ify;
> +} __packed;

this looks like it belongs in arch/blackfin/include/asm/dma.h
-mike
