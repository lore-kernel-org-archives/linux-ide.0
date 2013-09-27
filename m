From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RESEND] ata_piix: minor typo and a printk fix
Date: Fri, 27 Sep 2013 09:53:48 -0400
Message-ID: <20130927135348.GD3205@htj.dyndns.org>
References: <52458C14.8010308@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:57223 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332Ab3I0Nxx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Sep 2013 09:53:53 -0400
Received: by mail-yh0-f43.google.com with SMTP id b6so961984yha.2
        for <linux-ide@vger.kernel.org>; Fri, 27 Sep 2013 06:53:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <52458C14.8010308@linux.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Levente Kurusa <levex@linux.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On Fri, Sep 27, 2013 at 03:45:56PM +0200, Levente Kurusa wrote:
> @@ -1364,38 +1364,56 @@ static const int *piix_init_sata_map(struct
> pci_dev *pdev,
>  	const int *map;
>  	int i, invalid_map = 0;
>  	u8 map_value;
> +	char *mapdata[4];

	char buf[32];
	char *p = buf, *end = buf + sizeof(buf);

> 
>  	pci_read_config_byte(pdev, ICH5_PMR, &map_value);
> 
>  	map = map_db->map[map_value & map_db->mask];
> 
> -	dev_info(&pdev->dev, "MAP [");
>  	for (i = 0; i < 4; i++) {
>  		switch (map[i]) {
>  		case RV:
>  			invalid_map = 1;
> -			pr_cont(" XX");
> +			mapdata[i] = " XX";
>  			break;
> 
>  		case NA:
> -			pr_cont(" --");
> +			mapdata[i] = " --";
>  			break;
> 
>  		case IDE:
>  			WARN_ON((i & 1) || map[i + 1] != IDE);
>  			pinfo[i / 2] = piix_port_info[ich_pata_100];
>  			i++;
> -			pr_cont(" IDE IDE");
> +			mapdata[i] = " IDE IDE";
>  			break;
> 
> +		case P0:
> +			mapdata[i] = " P0";
> +			goto flag;
> +
> +		case P1:
> +			mapdata[i] = " P1";
> +			goto flag;
> +
> +		case P2:
> +			mapdata[i] = " P2";
> +			goto flag;
> +
> +		case P3:
> +			mapdata[i] = " P3";
> +			goto flag;
> +

	p += scnprintf(p, end - p, " P%d", map[i]);

Thanks.

-- 
tejun
