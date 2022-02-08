Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31FEC433F5
	for <linux-ide@archiver.kernel.org>; Tue,  8 Feb 2022 06:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347830AbiBHGu2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Feb 2022 01:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347842AbiBHGu2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2022 01:50:28 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C596C0401F2
        for <linux-ide@vger.kernel.org>; Mon,  7 Feb 2022 22:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644303025; x=1675839025;
  h=message-id:date:mime-version:subject:from:to:references:
   in-reply-to:content-transfer-encoding;
  bh=MUmIj9HT8Q0qoR8I95VwEicCdFoCMrt7kFRP92JZP0E=;
  b=MdSPj3RDndto4A4dgYQtqiudDCW34mI/AHYCXRNsueQHvbIQhOJCSIWS
   s6wYb4jKMjYFCt08q5nm3of2/KmPVYBrY+ljuVTBp/VohuOo0wtjW4jzb
   Xu5aaWKRRAblLfMb6RrNRMDJQmzN3vx0HZeoHd4D/9uJBQccn+nmhW2cm
   4fmwowahe9OsyHHqFu6qJ4JFiqDmgkgSDYz/P/skypk0Z91OEcxOxeyeX
   XCuqeY7X4AtmukoLXsD3LeJjA6kuEPNz14P+gMb8qZ/9qDIyK+fNSEo3m
   dQdw/hGqwMmfaxjON6JwZlf5CYL57N1xUBIEu7zvKKqCYZr6NlJu4kUb9
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,352,1635177600"; 
   d="scan'208";a="304297307"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2022 14:50:25 +0800
IronPort-SDR: KkbV92TN7PK/+7hMoIZWAiCm7H+/t+xl7RaQDL7lVz0YfCDybDaBsyGXc0v2nhRjbsvZJTPgy4
 Lv7Ue82+wM7Gjx5coDttNplaKuudyLTe6Nfg1rqCtZD0ohBNlpDpjE96EGxn89bAKoO8uelnPw
 GmTC1QGbtZ0fWi9VcitRebDWXKHEb8rYayIDojLv4BnwLnLfyFsXGwHjSuOnNF/dBih9Oq1fiu
 l1aB2XyjwnRXxh3/rzSzbobiogcCSgKayBrlUkoXAsds4mfxRvnhyxaVJsQg3gwnYW6utcCAkk
 xlAVFatv1vGdFenmo2Ymc1Kr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 22:22:15 -0800
IronPort-SDR: tU6HSTTfEqOGTwitgTqPowVIQ+fMzfhbieMSmzEfEhaUmaEyvr96Lxxx1jY8xRLg3gpdjWKRqa
 30R7/vbgP2E+Yin608zunoLQbYcMoTNQKeL1BMg1npnz9ZaK42zJpL2O3uYeDes70wKuijXnDx
 7hD5FDxVKxkWUhSeNA61Q4mkO/kleMXlsvZiLp+Fw69Smf8sJ47pzl/sFAhL1ZyBV4Jx8v2WVk
 LkEdNOWRs3NVZo3J7jIDjp6z9WNja39a9swfxyiMe12WAf49BA2sJiXU4vpxwCXTZTXKCVtGgz
 Qgs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 22:50:26 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JtDD05mCgz1SVp0
        for <linux-ide@vger.kernel.org>; Mon,  7 Feb 2022 22:50:24 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644303024; x=1646895025; bh=MUmIj9HT8Q0qoR8I95VwEicCdFoCMrt7kFR
        P92JZP0E=; b=NJikcCFFfOx3pR51028RBaDEsAGeQOzzw4N6xEVvAL9dkXclUdu
        YgngF67VW+DG3IF1mAzTzHjogHaai55OhSb9yPlT1jiDYClsM3uf4QDPx+Tjs+RA
        SQA5ilNoln1muFETNDl2NAfnkbvKW4hx7et0NlaVPbFb1QR+yqtkaP0TAFjGmiGo
        xeO46BuVwRPZDPelgOImkIJNRr9MnS6M8xqIH/6XWfwat3POeI4iup3rijRuxrYT
        vLEOpPQ1cvFTq1yz7D5B0lH2ZrPZUW+wP7/yYuYiPzjBbnba2lszlpWSG5n29E+9
        lRemIbZltMNxpQPbAYT6N2u2jLIoj6zXX/A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M_TE0Czeo4fC for <linux-ide@vger.kernel.org>;
        Mon,  7 Feb 2022 22:50:24 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JtDCz1hHjz1Rwrw;
        Mon,  7 Feb 2022 22:50:23 -0800 (PST)
Message-ID: <3a8cb80d-0104-934a-3c21-56afcc510634@opensource.wdc.com>
Date:   Tue, 8 Feb 2022 15:50:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: sata_fsl: fix sscanf() and sysfs_emit() format
 strings
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-ide@vger.kernel.org
References: <20220208064601.237582-1-damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220208064601.237582-1-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/8/22 15:46, Damien Le Moal wrote:
> Use the %u format for unsigned int parameters handling with sscanf() and
> sysfs_emit() to avoid compilation warnings. In
> fsl_sata_rx_watermark_store(), the call to sscanf() to parse a single
> argument is replaced with a call to kstrtouint().
> 
> While at it, also replace the printk(KERN_ERR) calls with dev_err()
> calls and fix blank lines in fsl_sata_rx_watermark_store().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/sata_fsl.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index da0152116d9f..556034a15430 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -322,7 +322,7 @@ static void fsl_sata_set_irq_coalescing(struct ata_host *host,
>  static ssize_t fsl_sata_intr_coalescing_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
> -	return sysfs_emit(buf, "%d	%d\n",
> +	return sysfs_emit(buf, "%u	%u\n",
>  			intr_coalescing_count, intr_coalescing_ticks);
>  }
>  
> @@ -332,10 +332,8 @@ static ssize_t fsl_sata_intr_coalescing_store(struct device *dev,
>  {
>  	unsigned int coalescing_count,	coalescing_ticks;
>  
> -	if (sscanf(buf, "%d%d",
> -				&coalescing_count,
> -				&coalescing_ticks) != 2) {
> -		printk(KERN_ERR "fsl-sata: wrong parameter format.\n");
> +	if (sscanf(buf, "%u%u", &coalescing_count, &coalescing_ticks) != 2) {

PPC folks,

The "%u%u" sscanf() format above seems totally bogus to me. How could 2
unsigned int without a separating characters be parsed as such ? Surely,
a separation character is needed, no ?

I cannot find any documentation on what the intr_coalescing sysfs
attribute format should be... Please have a look.


> +		dev_err(dev, "fsl-sata: wrong parameter format.\n");
>  		return -EINVAL;
>  	}
>  
> @@ -359,7 +357,7 @@ static ssize_t fsl_sata_rx_watermark_show(struct device *dev,
>  	rx_watermark &= 0x1f;
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
> -	return sysfs_emit(buf, "%d\n", rx_watermark);
> +	return sysfs_emit(buf, "%u\n", rx_watermark);
>  }
>  
>  static ssize_t fsl_sata_rx_watermark_store(struct device *dev,
> @@ -373,8 +371,8 @@ static ssize_t fsl_sata_rx_watermark_store(struct device *dev,
>  	void __iomem *csr_base = host_priv->csr_base;
>  	u32 temp;
>  
> -	if (sscanf(buf, "%d", &rx_watermark) != 1) {
> -		printk(KERN_ERR "fsl-sata: wrong parameter format.\n");
> +	if (kstrtouint(buf, 10, &rx_watermark) < 0) {
> +		dev_err(dev, "fsl-sata: wrong parameter format.\n");
>  		return -EINVAL;
>  	}
>  
> @@ -382,8 +380,8 @@ static ssize_t fsl_sata_rx_watermark_store(struct device *dev,
>  	temp = ioread32(csr_base + TRANSCFG);
>  	temp &= 0xffffffe0;
>  	iowrite32(temp | rx_watermark, csr_base + TRANSCFG);
> -
>  	spin_unlock_irqrestore(&host->lock, flags);
> +
>  	return strlen(buf);
>  }
>  


-- 
Damien Le Moal
Western Digital Research
