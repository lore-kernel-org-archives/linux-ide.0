From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 7/7] libata: Add 32bit PIO support
Date: Fri, 05 Dec 2008 21:16:51 +0100
Message-ID: <87ej0mnzrg.fsf@denkblock.local>
References: <20081205194231.17133.42760.stgit@localhost.localdomain>
	<20081205194355.17133.23019.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:55874 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198AbYLEUQ7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Dec 2008 15:16:59 -0500
In-Reply-To: <20081205194355.17133.23019.stgit@localhost.localdomain> (Alan
	Cox's message of "Fri, 05 Dec 2008 19:44:03 +0000")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kai@kaishome.de, linux-ide@vger.kernel.org, jeff@garzik.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> From: Alan Cox <alan@redhat.com>
>
> This matters for some controllers and in one or two cases almost doubles
> PIO performance. Add a bmdma32 operations set we can inherit and activate
> it for some controllers
>
> Signed-off-by: Alan Cox <alan@redhat.com>
> ---
[...]
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 61b1fb4..5c93377 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
[...]
> +	if (unlikely(slop)) {
> +		__le32 pad;
> +		if (rw == READ) {
> +			pad = cpu_to_le32(ioread32(ap->ioaddr.data_addr));
> +			memcpy(buf + buflen - slop, &pad, slop);
> +		} else {
> +			memcpy(&pad, buf + buflen - slop, slop);
> +			iowrite32(le32_to_cpu(pad), ap->ioaddr.data_addr);

Shouldn't the rest of pad be initialised to zero or something before it
is written?

Regards,

Elias
