Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EE8C433EF
	for <linux-ide@archiver.kernel.org>; Sun, 20 Feb 2022 06:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiBTGpW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 20 Feb 2022 01:45:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiBTGpV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 20 Feb 2022 01:45:21 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F5E3668D
        for <linux-ide@vger.kernel.org>; Sat, 19 Feb 2022 22:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645339501; x=1676875501;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=gLRzoJb1IaP++3QPTVc3m/x1RPL55qorl5ahrXjecSQ=;
  b=MeKZ+SlH3TLGzPfKhNzMizyhJ+b65bMMdPEqYj0yioyqQgL+j3eMZ6s8
   qeAMM8nbAAqPl39RZnjH3uuK0NPFkyhExbEj9bOtbbCa60fLRcq8xyOIx
   gORipbkNaCXUWJAER+nmEX1C7/cOVSaNEhWrHERJdeiTRf3x35R9M2QJ2
   drGZYGb4/XJoZCDmD7Q+0dWGkx51yC3iqrWFcF0rtGr5+N+7+ph6syqpu
   /n98baRp5/9Xrx82tmY5yshWXZCS2DKw/D7SwFFxbh2mscpdnOQzKLGWL
   4ze7KwIbSzj1oqp0/vd+Xl4JBWusjeHYBwPY83/ErWiU4n2+5VFjz4HH/
   A==;
X-IronPort-AV: E=Sophos;i="5.88,383,1635177600"; 
   d="scan'208";a="194388712"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2022 14:45:00 +0800
IronPort-SDR: YCIhLDoCJ13K/Y9OeatWrLbtqr0L/fHUzvJWCByGhorgYzUnuSB95U01M0wgAJhpgqWqWwx3Hg
 ahUUOO5QPD9WrhJ2LDArl2wilfxbKY7RSB066y5WczSxV/jNs90XWqtxCZIRXOko5X9IfvWb1+
 YYpsbWnt+9heXKc7QjfdKmh/Y6AiUkjoXeam34RWCMqaBWXViPq4zKRFHfDpGbQSEcTwxrZxYG
 ZHJYiZY0708ousi1y+fsfYbHvuGnBlp09u9uX9J+Yq+t8D1/ciSglIMID00eyHxmAT7UnZu9jv
 hjxVgCDaGna35FLLDzWEXP1+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 22:16:36 -0800
IronPort-SDR: LDmcDEkx1D5MgYfoIvf6aF6HyDD2nYaDayezqbXPaeCZq+KqH/n4O+NOsLRpF3fkChM/Du6KQc
 sZdvgfQTrusCqjBDyMWcOn1kog0BBGA/AgWR0uWBl1OMPVdC4jMJK9bn44HpVlw8ofjC+P9OZT
 4EdtydrHWDIDAJkyDJXHSjSGwpKjAuQunOXsfq2cwKPf/iD18e9BWEegx8ZwYeoWKvilBKlgM1
 U2JHo1MYTk65KjeT6ADrpjSnamE5wwFobj4MbfbRJzQKw7ru7dRTishUTH9nG/gTvT35jcFh2+
 avM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 22:45:01 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K1bXC5vfwz1Rwrw
        for <linux-ide@vger.kernel.org>; Sat, 19 Feb 2022 22:44:59 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645339499; x=1647931500; bh=gLRzoJb1IaP++3QPTVc3m/x1RPL55qorl5a
        hrXjecSQ=; b=U8NMy193juDf7gPJXP5GS5IzffviiqXja+yPEB39aJ/G+2UkOvC
        SXgCLDp4XLh1l51alJ2AuOJhV5FRDGTADw0FgpuGqoAio44RFGJm93yoidhDNEVI
        z98lW2iqBtesBkdHeOerZcOqAzKjHmyrnrV/eZhic9sc3IHnaa+TV+x8se5fBVd4
        RBLyHnvObDZ7t+eVz1htoALi5nyD0l/fgoRIYIe8Df/WSmgMWpAz4xsfuamNlt7r
        DDqhjhOiaFvoEQ6NRoysv8pd+WQFecwjX/gLJnHbhtCi7rnhoH2FUDHtbbi3Wifx
        /sZvgbhjDPOPb6uWQCB3qPPColoJqqZzyHA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ys9fsl-gdSxr for <linux-ide@vger.kernel.org>;
        Sat, 19 Feb 2022 22:44:59 -0800 (PST)
Received: from [10.225.163.78] (unknown [10.225.163.78])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K1bXB6yFtz1Rvlx;
        Sat, 19 Feb 2022 22:44:58 -0800 (PST)
Message-ID: <f37abf49-e11d-f9d7-f247-f296213100ff@opensource.wdc.com>
Date:   Sun, 20 Feb 2022 15:44:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: pata_hpt37x: fix PCI clock detection
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <02715925-4a0f-30dd-86b8-85786cf6484a@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <02715925-4a0f-30dd-86b8-85786cf6484a@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/20/22 05:04, Sergey Shtylyov wrote:
> The f_CNT register (at the PCI config. address 0x78) is 16-bit, not 8-bit!
> The bug was there from the very srart... :-(
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Cc: stable@vger.kernel.org

Any Fixes tag possible with this one ? I have not checked what "git
blame" says...

> 
> ---
> This patch is against the 'master' branch of Damien Le Moal's 'libata.git'
> repo.
> 
>  drivers/ata/pata_hpt37x.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: libata/drivers/ata/pata_hpt37x.c
> ===================================================================
> --- libata.orig/drivers/ata/pata_hpt37x.c
> +++ libata/drivers/ata/pata_hpt37x.c
> @@ -950,14 +950,14 @@ static int hpt37x_init_one(struct pci_de
>  
>  	if ((freq >> 12) != 0xABCDE) {
>  		int i;
> -		u8 sr;
> +		u16 sr;
>  		u32 total = 0;
>  
>  		dev_warn(&dev->dev, "BIOS has not set timing clocks\n");
>  
>  		/* This is the process the HPT371 BIOS is reported to use */
>  		for (i = 0; i < 128; i++) {
> -			pci_read_config_byte(dev, 0x78, &sr);
> +			pci_read_config_word(dev, 0x78, &sr);
>  			total += sr & 0x1FF;
>  			udelay(15);
>  		}
> 


-- 
Damien Le Moal
Western Digital Research
