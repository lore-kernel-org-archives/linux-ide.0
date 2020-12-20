Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFDDC433E0
	for <linux-ide@archiver.kernel.org>; Mon, 21 Dec 2020 06:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D65B22BF3
	for <linux-ide@archiver.kernel.org>; Mon, 21 Dec 2020 06:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgLUGci (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 21 Dec 2020 01:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgLUGci (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2020 01:32:38 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506C2C0613D3;
        Sun, 20 Dec 2020 22:31:57 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c7so8503137edv.6;
        Sun, 20 Dec 2020 22:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=upGN1dBVZ/btBdBBPeURAqi5iKi4W8RMHZ52S9FrN+g=;
        b=f//lnvun2qaI2b2XF05irRBMFR0/xFM8ZlFjdmAkLPMpOeF8Pgv70DgDp8TbunYqZT
         +cv36wy/8zLg02Gtz12XmbbbuSuA28nxEDmJoiLwI3BTJgHYmRlj6knCWNDmtsnEjkPV
         RQcUhCMwt9qP8SJJ32kqOeYioj3UClqalDVGxsi5xKSRgL9R91ZSj0vyrGdt+mij3H1H
         vcPqc1tUeGT9OUpPtMhiKl8z0aOYEHE4gI197kA+svK5FJ5/Jfnk8PSzTEshQvpVhWbv
         et0gvNOXxXjSypfOvvbbCPxdvaYbNvV7B4mJeNJuq/dbHaf4sID+w5Wv6q8aKP5VH2hU
         DdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=upGN1dBVZ/btBdBBPeURAqi5iKi4W8RMHZ52S9FrN+g=;
        b=NVyWdvDMn+XBvOlUxXsp0eo48f9XjrX23Z8hR31BA84l1DWTkxx3rtepS6RT8ZzeiT
         DWNejQ1CPf0IDfSFZTCYwu7sTTUOsXe3nhDdWStgQ4QG3l5oKkrqEjpd4upWiIjrLbJ3
         XNLj4LCrHAxjMqDE1w2mtcRgCSft0NQ79U/AVwibDcnv4lOFUw7jKpZ4VWsuqL35vKr9
         SXXGAAaGv4wciIv8EEH0D+j5/xhx/+k5soe1XCgzETJmI0+W3kyQG5r1uAAc3A30TEQj
         N2ipr0r/l8q49JC3aSw5ayDAxYVJUVam0GkzBQzcIekcAxGjybxE5gA1mH0lSbBRSytJ
         fDuw==
X-Gm-Message-State: AOAM532ghJ6nMDsF0QgDh/Epy4NgSprzdbyYRqGSPfdv0HvreCXOxng2
        uypH/MX1CDFlhe1Jc5SHWqyloQyIFqPmEw==
X-Google-Smtp-Source: ABdhPJzkanZ/GzLadDBfPDG5a7XQywIW2Otp1yk1ztP6juHx1KH1AX/SUNLY/Dm4lbUI4J/gb9pzAQ==
X-Received: by 2002:a05:6512:368d:: with SMTP id d13mr5150213lfs.414.1608493836961;
        Sun, 20 Dec 2020 11:50:36 -0800 (PST)
Received: from kari-VirtualBox (87-95-193-210.bb.dnainternet.fi. [87.95.193.210])
        by smtp.gmail.com with ESMTPSA id k21sm1907262ljb.43.2020.12.20.11.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 11:50:36 -0800 (PST)
Date:   Sun, 20 Dec 2020 21:50:33 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, "David S. Miller" <davem@davemloft.net>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide: pci: Fix memleak in ide_pci_init_two
Message-ID: <20201220195033.due2e4ukijaah23a@kari-VirtualBox>
References: <20201220070541.7515-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201220070541.7515-1-dinghao.liu@zju.edu.cn>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sun, Dec 20, 2020 at 03:05:40PM +0800, Dinghao Liu wrote:
> When do_ide_setup_pci_device() fails, host allocated
> by ide_host_alloc() may not have been freed, which
> leads to memleak.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/ide/setup-pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
> index fdc8e813170c..c7da5368fcd4 100644
> --- a/drivers/ide/setup-pci.c
> +++ b/drivers/ide/setup-pci.c
> @@ -586,7 +586,7 @@ int ide_pci_init_two(struct pci_dev *dev1, struct pci_dev *dev2,
>  		 * do_ide_setup_pci_device() on the first device!
>  		 */
>  		if (ret < 0)
> -			goto out_free_bars;
> +			goto out_free_host;
>  
>  		/* fixup IRQ */
>  		if (ide_pci_is_in_compatibility_mode(pdev[i])) {
> @@ -597,11 +597,11 @@ int ide_pci_init_two(struct pci_dev *dev1, struct pci_dev *dev2,
>  	}
>  
>  	ret = ide_host_register(host, d, hws);
> -	if (ret)
> -		ide_host_free(host);
> -	else
> +	if (!ret)
>  		goto out;

Maybe 
	if (ret)
		goto out_free_host;

	return 0;

would be more clear here. But this is just small nit.

>  
> +out_free_host:
> +	ide_host_free(host);
>  out_free_bars:
>  	i = n_ports / 2;
>  	while (i--)

