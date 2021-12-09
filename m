Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68311C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 01:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhLIBOU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 20:14:20 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:48942 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbhLIBOT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 20:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639012247; x=1670548247;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jPU7klA/MI3iIkSOp5ixzg0LgKrdYV86PIv7O6Hu9v0=;
  b=CFm2i5h0d4zoeqAFErGcyD5SOdrBg5Cwz+zeCj2ultpRt5ab0M1ngiw8
   UBenVF7kIjH6rpXWG5SLuL3EkN9pbT1pXiPWuV1BRYTnjWrjDEnOCuuHb
   PO0i0Mu4TXOZU68MCA5sZ+BuBcxTT0lOD27GC2Ku/79GSrMpZN/9NqPNz
   n0jRfYpGIEs4cj9hagxA97Oko+iNkGeocE+EXwZ2zZfuEeEOl2AcAtNtX
   6NeL1dw9TXbY/EIC2aMhdv0MMcVOPL/eso2F84ZHDW/KhxDicptIlGxvx
   VrOQMSCQLU4N886RcAvyRYgTMBbs7Xw+Lde77TN2ssu+wWR2IfLT1QAEB
   A==;
X-IronPort-AV: E=Sophos;i="5.88,190,1635177600"; 
   d="scan'208";a="291773600"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 09:10:46 +0800
IronPort-SDR: Pf17p00OJNA4zJ89bpNqjO9f5vTE6XnNzCgOJft/MolSOI+1trnRDoHzYNEy6TcbggOWO2qTjZ
 lxlZ3qGfuwxyfRSV8JVX02Ox1NZ8oTQrXtP+PX9KqHcx8En2isMABOGJnu2J+vWgTfpVmS0Kb7
 kko4+Xn6PV0UUdeLa15CpMmT6uhL+ySbIHotKjutPakKcGYPsiU9znnKPC202MQGiNRrtPT+IN
 XfovMdxdGCsCtI3NOY172On5miUJjY9CeRI0vMowaGKjlDkxYlw4LEXDC0gp3+7cXW1J84/PZ+
 p2lAIeddetnNBnaHCM9sycbQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:43:49 -0800
IronPort-SDR: 2yrOgc9bOc8R/jz78q9aYyqP4+aCDE9/DF6kXO536Ujp+wEUt4ahoJZdwj+b9CVE6j0cule7xm
 SF4SqO5DWafhLG7ldO4PKFkrEBfg4YXoGw64Zw16f9mKSjlwE+vqPmzPwOkSnNKO5BkF8R5fqr
 J2783f9JIo/k1awQKJHL2t/buU3403aENI3JNiDYungK8hL7KfBUrlS03AawxVokdwszd3Qf/f
 b5ibEtfGBxH/9h6ehHk5R85uAIYRw0FS2OjlLmlo6Dc5hDHtrhgIN4jj5hYfP4ztw2YkxSk1h3
 d/o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 17:10:47 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J8bZG56nTz1RvTh
        for <linux-ide@vger.kernel.org>; Wed,  8 Dec 2021 17:10:46 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639012246; x=1641604247; bh=jPU7klA/MI3iIkSOp5ixzg0LgKrdYV86PIv
        7O6Hu9v0=; b=BjI73/qpCAlzGWy093eYyBiUaGTpOk04Pc6MYnLJt7RQdwH0x72
        wN7qWNCSvOBpV2UeuKKlw6ZV+AEV6FC9P/umampfW0nGmIyyWLp0PaypJluCIgdY
        S1XjO7Qt8GJeb3K2FWz+8ZI/oGBz89GRZ+0jDeXak2JUsLzX4RvhQnxv+6sn333q
        6FXha5xpsLZIiQ5fuA2i96JPGuVIoE2R+oPEgD+vmX76lwkS57MgHk2ac+HZ16vj
        lgLlxZUdMXg8a78w4JWmmJaRO8wotgdnANK2BxLA5N1bSoN73Ph0aQLTL+jGaCL5
        XpCR3S3amVIIv4B06CPzkiQE8qs66IhlObA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iikb-Q3MPCsU for <linux-ide@vger.kernel.org>;
        Wed,  8 Dec 2021 17:10:46 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J8bZG0HgPz1RtVG;
        Wed,  8 Dec 2021 17:10:45 -0800 (PST)
Message-ID: <8dac2bea-1ffb-7be0-2170-bc25e04a4b5b@opensource.wdc.com>
Date:   Thu, 9 Dec 2021 10:10:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 62/73] pata_rz1000: convert blank printk() calls
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-63-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211208163255.114660-63-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/09 1:32, Hannes Reinecke wrote:
> Convert blank printk() calls to structured logging.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/pata_rz1000.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
> index 3722a67083fd..8beec884836d 100644
> --- a/drivers/ata/pata_rz1000.c
> +++ b/drivers/ata/pata_rz1000.c
> @@ -69,7 +69,7 @@ static int rz1000_fifo_disable(struct pci_dev *pdev)
>  	reg &= 0xDFFF;
>  	if (pci_write_config_word(pdev, 0x40, reg) != 0)
>  		return -1;
> -	printk(KERN_INFO DRV_NAME ": disabled chipset readahead.\n");
> +	dev_info(&pdev->dev, "disabled chipset readahead.\n");
>  	return 0;
>  }
>  
> @@ -97,7 +97,7 @@ static int rz1000_init_one (struct pci_dev *pdev, const struct pci_device_id *en
>  	if (rz1000_fifo_disable(pdev) == 0)
>  		return ata_pci_sff_init_one(pdev, ppi, &rz1000_sht, NULL, 0);
>  
> -	printk(KERN_ERR DRV_NAME ": failed to disable read-ahead on chipset..\n");
> +	dev_err(&pdev->dev, "failed to disable read-ahead on chipset..\n");

While at it, make that ".." at the end a single dot ?

>  	/* Not safe to use so skip */
>  	return -ENODEV;
>  }
> 


-- 
Damien Le Moal
Western Digital Research
