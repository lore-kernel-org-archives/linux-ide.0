Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6B5C433EF
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 01:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbhLIBMD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 20:12:03 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30539 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbhLIBMC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 20:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639012109; x=1670548109;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KmryPteSBJ42vrdQzuB1nL5I3lioWO569AS065pzuu8=;
  b=CHBUN089FVPG0MmFmapRkmp2uJ1A/nl2gXd+gQ6oVcJEwqVWq9GrD70y
   gTSne/Sdu3irUv5jSAL/yNCoTVYelH3ht8DPRDjtxqxmTFEP2at4oESYt
   AzCrA/D259hW2k3Nv5oqkhIWx5n2dC3KVie8BoEoc0i5hyvaAhG0aVhHS
   5aBzlDCf67N/IqRbbhikJIYYIkAs9xDCxLR0Mc9/zPoI6AzbXQCFt31FU
   XHbjdq2OwGJcu71xfPAm33SpTPl8D0g5Isns5WJf5sXdHDWnZXNBwZj0S
   gxl5NpAQps/pCJLp1YSZZQWK0sP5YndZORHuIXFVfXVuunLDg2TcXjk4G
   w==;
X-IronPort-AV: E=Sophos;i="5.88,190,1635177600"; 
   d="scan'208";a="187795162"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 09:08:29 +0800
IronPort-SDR: 5wIGygGzzjr572d38/HaOWIPSH1IAqvVSqqQnwpLcu3+hJOnk65yWStxfg68qobk7xo8Oaf5Sy
 3rcZDmfJvQIgzlD23QnlAUFUS3Helty5hEWprp0T6tTqqjstKdaZHByEFumhgcqhgbAHjj9Eg1
 exkaV+2wqnewo2b+tGeyr4iWeLTdThfLyg5CVDGaDv5i3c7TttSSnd3/5TIcmP6gp2F4ojKC4P
 PQ/zscVEAviWEVemR+ulFjnZXuSWkv9dyRBJKQ7oKQ+uLSN9CxitzI6IS0AiJb9MzMhOBh3VY0
 IvErNB7bBmTZc68fbIA1K6Dp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:41:32 -0800
IronPort-SDR: HJn3jJ+8V/CKsghqt6SbIJyKrRtLBSdr9KBgFCtwW3G4YD7FjeE3jeAfmFU8z7lEoscyl6rd32
 YOsW2cMqyMviquXikao2wUey/fzr68ynFHxZvI0meNvQ7lZNPkynnvRw2CWr12DkWqtPvXYQNl
 RYeKQASadb04UyqRHs3Pch6pfy3dNNDFllt+jVYTI7fglqhJP+V1vj/r97C+VI7KcJJugRILa8
 /BOPgMdgRgNws1zRXShMdEvSXnITtZghO7pX+X1yTF5/UhO+Mn6Z37eaK0tbS5Kiw5UnCKNzYi
 BDk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 17:08:30 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J8bWd5M5Dz1RvTh
        for <linux-ide@vger.kernel.org>; Wed,  8 Dec 2021 17:08:29 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639012109; x=1641604110; bh=KmryPteSBJ42vrdQzuB1nL5I3lioWO569AS
        065pzuu8=; b=DtwHM2Cs+g8y5YDsWK6C2U861bcLOxB/Z+6yDA8vyngbGPdoNqd
        QB+PInTVkDQqJc5krwuaOaxJT5tTPmgZKKBm6SCv/riAtc9nDZ7IajVsJS2KQORS
        fcYSVBgygmHDGcHMQcrarXqyG7szBNb1Lw7U0am24FFonwzamXdziMCSgzq5aBCj
        /9TrQ64cYyzLTJMuuUUJ+tvZwwPKuaI2K2Jm4eg1MWZ44qh2VlOw8fcb1i/+xNKx
        OPox2mBJIwWNhH49ibEgKzujHVuzHoQWO96eSiRqtypCDf8OlXmVLgty4DtkBIEN
        eFQnDwqEGfjPbNwDKu11/6BfkdTDFO4X2Nw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5S6aVfCVT-NN for <linux-ide@vger.kernel.org>;
        Wed,  8 Dec 2021 17:08:29 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J8bWc5nPrz1RtVG;
        Wed,  8 Dec 2021 17:08:28 -0800 (PST)
Message-ID: <f7ffa1ac-1fba-36e3-c701-e71f97ab5578@opensource.wdc.com>
Date:   Thu, 9 Dec 2021 10:08:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 54/73] pata_atp867x: convert blank printk() calls
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-55-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211208163255.114660-55-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/09 1:32, Hannes Reinecke wrote:
> Convert blank printk() calls to structured logging.

s/blank/raw ? Since they are not empty prints...

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/pata_atp867x.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
> index 2bc5fc81efe3..84dac8c69085 100644
> --- a/drivers/ata/pata_atp867x.c
> +++ b/drivers/ata/pata_atp867x.c
> @@ -155,7 +155,7 @@ static int atp867x_get_active_clocks_shifted(struct ata_port *ap,
>  	case 1 ... 6:
>  		break;
>  	default:
> -		printk(KERN_WARNING "ATP867X: active %dclk is invalid. "
> +		ata_port_warn(ap, "ATP867X: active %dclk is invalid. "
>  			"Using 12clk.\n", clk);
>  		fallthrough;
>  	case 9 ... 12:
> @@ -171,7 +171,8 @@ static int atp867x_get_active_clocks_shifted(struct ata_port *ap,
>  	return clocks << ATP867X_IO_PIOSPD_ACTIVE_SHIFT;
>  }
>  
> -static int atp867x_get_recover_clocks_shifted(unsigned int clk)
> +static int atp867x_get_recover_clocks_shifted(struct ata_port *ap,
> +					      unsigned int clk)
>  {
>  	unsigned char clocks = clk;
>  
> @@ -188,7 +189,7 @@ static int atp867x_get_recover_clocks_shifted(unsigned int clk)
>  	case 15:
>  		break;
>  	default:
> -		printk(KERN_WARNING "ATP867X: recover %dclk is invalid. "
> +		ata_port_warn(ap, "ATP867X: recover %dclk is invalid. "
>  			"Using default 12clk.\n", clk);
>  		fallthrough;
>  	case 12:	/* default 12 clk */
> @@ -225,7 +226,7 @@ static void atp867x_set_piomode(struct ata_port *ap, struct ata_device *adev)
>  	iowrite8(b, dp->dma_mode);
>  
>  	b = atp867x_get_active_clocks_shifted(ap, t.active) |
> -	    atp867x_get_recover_clocks_shifted(t.recover);
> +		atp867x_get_recover_clocks_shifted(ap, t.recover);
>  
>  	if (adev->devno & 1)
>  		iowrite8(b, dp->slave_piospd);
> @@ -233,7 +234,7 @@ static void atp867x_set_piomode(struct ata_port *ap, struct ata_device *adev)
>  		iowrite8(b, dp->mstr_piospd);
>  
>  	b = atp867x_get_active_clocks_shifted(ap, t.act8b) |
> -	    atp867x_get_recover_clocks_shifted(t.rec8b);
> +		atp867x_get_recover_clocks_shifted(ap, t.rec8b);
>  
>  	iowrite8(b, dp->eightb_piospd);
>  }
> @@ -270,7 +271,6 @@ static struct ata_port_operations atp867x_ops = {
>  };
>  
>  
> -#ifdef	ATP867X_DEBUG
>  static void atp867x_check_res(struct pci_dev *pdev)
>  {
>  	int i;
> @@ -280,7 +280,7 @@ static void atp867x_check_res(struct pci_dev *pdev)
>  	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
>  		start = pci_resource_start(pdev, i);
>  		len   = pci_resource_len(pdev, i);
> -		printk(KERN_DEBUG "ATP867X: resource start:len=%lx:%lx\n",
> +		dev_dbg(&pdev->dev, "ATP867X: resource start:len=%lx:%lx\n",
>  			start, len);
>  	}
>  }
> @@ -290,7 +290,7 @@ static void atp867x_check_ports(struct ata_port *ap, int port)
>  	struct ata_ioports *ioaddr = &ap->ioaddr;
>  	struct atp867x_priv *dp = ap->private_data;
>  
> -	printk(KERN_DEBUG "ATP867X: port[%d] addresses\n"
> +	ata_port_dbg(ap, "ATP867X: port[%d] addresses\n"
>  		"  cmd_addr	=0x%llx, 0x%llx\n"
>  		"  ctl_addr	=0x%llx, 0x%llx\n"
>  		"  bmdma_addr	=0x%llx, 0x%llx\n"
> @@ -332,7 +332,6 @@ static void atp867x_check_ports(struct ata_port *ap, int port)
>  		(unsigned long long)dp->eightb_piospd,
>  		(unsigned long)dp->pci66mhz);
>  }
> -#endif
>  
>  static int atp867x_set_priv(struct ata_port *ap)
>  {
> @@ -370,8 +369,7 @@ static void atp867x_fixup(struct ata_host *host)
>  	if (v < 0x80) {
>  		v = 0x80;
>  		pci_write_config_byte(pdev, PCI_LATENCY_TIMER, v);
> -		printk(KERN_DEBUG "ATP867X: set latency timer of device %s"
> -			" to %d\n", pci_name(pdev), v);
> +		dev_dbg(&pdev->dev, "ATP867X: set latency timer to %d\n", v);
>  	}
>  
>  	/*
> @@ -419,13 +417,11 @@ static int atp867x_ata_pci_sff_init_host(struct ata_host *host)
>  		return rc;
>  	host->iomap = pcim_iomap_table(pdev);
>  
> -#ifdef	ATP867X_DEBUG
>  	atp867x_check_res(pdev);
>  
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++)
> -		printk(KERN_DEBUG "ATP867X: iomap[%d]=0x%llx\n", i,
> +		dev_dbg(gdev, "ATP867X: iomap[%d]=0x%llx\n", i,
>  			(unsigned long long)(host->iomap[i]));
> -#endif
>  
>  	/*
>  	 * request, iomap BARs and init port addresses accordingly
> @@ -444,9 +440,8 @@ static int atp867x_ata_pci_sff_init_host(struct ata_host *host)
>  		if (rc)
>  			return rc;
>  
> -#ifdef	ATP867X_DEBUG
>  		atp867x_check_ports(ap, i);
> -#endif
> +
>  		ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
>  			(unsigned long)ioaddr->cmd_addr,
>  			(unsigned long)ioaddr->ctl_addr);
> @@ -486,7 +481,7 @@ static int atp867x_init_one(struct pci_dev *pdev,
>  	if (rc)
>  		return rc;
>  
> -	printk(KERN_INFO "ATP867X: ATP867 ATA UDMA133 controller (rev %02X)",
> +	dev_info(&pdev->dev, "ATP867X: ATP867 ATA UDMA133 controller (rev %02X)",
>  		pdev->device);
>  
>  	host = ata_host_alloc_pinfo(&pdev->dev, ppi, ATP867X_NUM_PORTS);
> 


-- 
Damien Le Moal
Western Digital Research
