Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0747DC433F5
	for <linux-ide@archiver.kernel.org>; Wed,  9 Feb 2022 23:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiBIX3e (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Feb 2022 18:29:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiBIX33 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2022 18:29:29 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078BBE05A3CE
        for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2022 15:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644449371; x=1675985371;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=/89J6epN1D3m8aSfG5bsNKq6nfWN0nvxGCDz4js5BaM=;
  b=e6+idh2DcYLFuItvEdK4XeyoNQldEOVeMxqFRRJSc/043ZlAK5sRwMca
   zp6fPKYzMqryFDk20KTJ9IPL9HHBUIz5gUmP2dhkKq0OaFZND6rpGRCqH
   PRoO9wfIXXMU4PSz3TU29udCRWY0OWul6NJEVbidqlaJB1yuqqgak4+IN
   gNqP7aRaFFLkfmz//F4f526BY0pKTjOJYBKyliC9iCIR2w+K8gLanPonn
   SIYknfra14vQtnUzhBAcFbeCeX7bTXJhOIvHJHn0tuTvXQpM066dWCl3q
   9eqm58tTl0NRouyu6oSQRNQm3jDPru41zP/On4piLONymPDa4abkmEx+Q
   w==;
X-IronPort-AV: E=Sophos;i="5.88,356,1635177600"; 
   d="scan'208";a="193527661"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2022 07:29:30 +0800
IronPort-SDR: qQxwinuizFN9MBoABQTiS3DsWi/GFjOrFwC2jREjiP9LioWHuIlFwmzn+b4oK6EvQARGO1to3p
 tSSf4L/+j9mBmyZSYARKmUKtCKvShCd9T/8bZ4UdH44d5LzdByWCc6TjDdMVx+CMVlY5p5i1GI
 7MKymugzw8mHNG2uAyl29ZreMbB5gdQIgxK/P6MCjNXgYNB6oE3BWForiK+KF127j1ZrRr7+tr
 Nlmh6aglyI2z8oUODmOKuzkS9xgSp1+HS6yopBlVg2yP5MAqH9USj7wJl9BsGbpvHttDgQENSm
 SfkN04t4wLpTtgMf+5c0l2D7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 15:02:27 -0800
IronPort-SDR: nZx/nT66aqZSu2wjm/UKApGSAP277dwoWfjJf2fRlg6GT5vAJe942OH9uGAeXa/j8asW9ntZ2T
 dMHEBgTj46c1tMtZA8G+JklaHODNfNZvhYvK+d93z8MmWdfo4SZL9ApGR7RX6Gl6GmjPoI382D
 ffT0HTwVOqLBUS4c7Gwf6yEC62Ur9UweTloRcJiyGiohEMhy8gQZxOnLauA9XQwGiNrwpZ8fW0
 6dwyH9mr9BsFSigHvHB6Wv7Z44uI90RCpyaFTNa/CpUyDqrHf1U1urSUNVVsd6hykyS9X72rhD
 +C8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 15:29:30 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JvGLK6dlDz1SHwl
        for <linux-ide@vger.kernel.org>; Wed,  9 Feb 2022 15:29:29 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644449369; x=1647041370; bh=/89J6epN1D3m8aSfG5bsNKq6nfWN0nvxGCD
        z4js5BaM=; b=F6irGl9dRjVwo3ACSgjbLY/pbtpnoiT9XlSooMKWuZHG8VxDoK9
        6CnQ/ysGGudHnlt74AiZvwuidmBfpRElpLhTQ7Qa63QOiCvPQJWipYNY4PfBTkYQ
        o1hUv4T9sXiqnU2HaJRPREEY9BsszwixIcGpKFpQssvj2blibujdSqcoa8zTUQdw
        Muh4lAiTLDuSgcYhaXcEdxbMr1CmZUyG3EeWu+cZ4kRsM3iIjesbBSqX3Lok3Fr1
        V4hVov33iRstvWcrifeRhIPxdz/6ueXT3THOXdRbIpuB46wnFvW5MWW0RJxl1WaB
        GUeVnY6XvF+jXPQfvPQYxADPbbzWsL4hrow==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZQqJQel4ks1x for <linux-ide@vger.kernel.org>;
        Wed,  9 Feb 2022 15:29:29 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JvGLK0sxxz1Rwrw;
        Wed,  9 Feb 2022 15:29:28 -0800 (PST)
Message-ID: <a7d2fd87-9210-a960-b69e-dd0ea94e86d4@opensource.wdc.com>
Date:   Thu, 10 Feb 2022 08:29:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 2/2] ata: pata_artop: use *switch* in atp8xx_fixup()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220209202535.7679-1-s.shtylyov@omp.ru>
 <20220209202535.7679-3-s.shtylyov@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220209202535.7679-3-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/10/22 05:25, Sergey Shtylyov wrote:
> This driver uses a string of the *if* statements in atp8xx_fixup() where
> a *switch* statement would fit better...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
> 
> Changes in version 5:
> - fixed up #define DRV_VERSION;
> - added "ata: " prefix to the patch subject.
> 
> Changes in version 4:
> - new patch.
> 
>  drivers/ata/pata_artop.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
> index 08e88403d0ab..20a8f31a3f57 100644
> --- a/drivers/ata/pata_artop.c
> +++ b/drivers/ata/pata_artop.c
> @@ -28,7 +28,7 @@
>  #include <linux/ata.h>
>  
>  #define DRV_NAME	"pata_artop"
> -#define DRV_VERSION	"0.4.7"
> +#define DRV_VERSION	"0.4.8"
>  
>  /*
>   *	The ARTOP has 33 Mhz and "over clocked" timing tables. Until we
> @@ -315,12 +315,15 @@ static struct ata_port_operations artop6260_ops = {
>  
>  static void atp8xx_fixup(struct pci_dev *pdev)
>  {
> -	if (pdev->device == 0x0005)
> +	u8 reg;
> +
> +	switch (pdev->device) {
> +	case 0x0005:
>  		/* BIOS may have left us in UDMA, clear it before libata probe */
>  		pci_write_config_byte(pdev, 0x54, 0);
> -	else if (pdev->device == 0x0008 || pdev->device == 0x0009) {
> -		u8 reg;
> -
> +		break;
> +	case 0x0008:
> +	case 0x0009:
>  		/* Mac systems come up with some registers not set as we
>  		   will need them */
>  
> @@ -338,6 +341,7 @@ static void atp8xx_fixup(struct pci_dev *pdev)
>  		/* Enable IRQ output and burst mode */
>  		pci_read_config_byte(pdev, 0x4a, &reg);
>  		pci_write_config_byte(pdev, 0x4a, (reg & ~0x01) | 0x80);
> +		break;
>  	}

without a default case, isn't there a warning with make W=1 or make C=1
(sparse) ?


>  }
>  


-- 
Damien Le Moal
Western Digital Research
