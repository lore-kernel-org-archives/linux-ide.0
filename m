Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BE5C433FE
	for <linux-ide@archiver.kernel.org>; Thu, 27 Oct 2022 01:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbiJ0BAx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 26 Oct 2022 21:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbiJ0BAx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 26 Oct 2022 21:00:53 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED14E4C13
        for <linux-ide@vger.kernel.org>; Wed, 26 Oct 2022 18:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666832452; x=1698368452;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=hppA36QO/822mMJc73WWU3Pnzz3V6woG0DVkM3foBuw=;
  b=GF+EtflDgylISb+wGBdQy6MwdoqAUr6K84rcHJYI0dGjvtqrdnPscTqM
   bz+3d1+9HuYLGvH4fFiEq1Lkt1ztK+1ochjcpitDEQTBlFrRitrglalEJ
   lGZmpsFH7RaXHxWrjFP4Q8tagguB6xQllKoBw9Q6D/O1yB+yOoBJvMMuI
   XhFrDseo56J9reUiEZVMiSn6t7idYY+nsIKI+Dr3tc530X6NaMDYYCGwP
   UdaDmieRI7LZHsAmdCzI0Na0GHHFj81xSJ4BH4GR51K0Phs0WoZgYMw3q
   T3TGVEJyZ/jzTXyIxLrK566oWV/Y1WfyWGVmfeB55xWmGyqFGW3x6gwZg
   g==;
X-IronPort-AV: E=Sophos;i="5.95,215,1661788800"; 
   d="scan'208";a="219997033"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 09:00:51 +0800
IronPort-SDR: aYMo17LL8ov8eYIMG6lsirfKCN2xJXPY/wlQgX5Iup2LaGfTYgAhEN/VG4Fdt3TQklRFzvSojA
 RfIZu1KpOEo1oaH7htEIXpWMx8bKq83UwO/L83wUIH9aeXgwrAPT0r9TwMuLd5CHSlAoJIIZT/
 kybDHGe2hvw/mdHOvSZrQFSn2esNklB7QOg6hxTW0xpOMJuaXr7HrxV1ggOLWEJKozqT5w7+WU
 N59vCjLSu2Jv/HAJ9E0b90lz7KiREz4qjn6/JkSqOM9v04MEOhKIqN5TsJpvnA4zRSGPEOlHWA
 TCikHo5uH/dy9Lz6oU0xsaNh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 17:20:13 -0700
IronPort-SDR: qK2SRJ1XRM9TcC+NtRNHriLGT2LAOcQOj7HQN3S+O3PQTIppaSgrFqGpqA9R7SOFVMjuY4gnre
 lPosiUM6RY+2PWJ6BgAeqxgsAaupwqYUsgxdtBDJdH2dtjnMdbXao9rv71GBhg59eB21tUyEa5
 zT85JWwaeZUrt7gEDFqKvGjS7LrilUnAk6xKOT1d3QjFam7HMa30oz+y2viudLjwN9ueMBb1P/
 8BFYDK6qzSxsN3qTAovDHMm36kcTbjQVfSt/Hq1YZzUkrADFFwRvFvh43TIn3eP2uUdn2SFfsM
 GU0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 18:00:52 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MyS6C2lQXz1RvTr
        for <linux-ide@vger.kernel.org>; Wed, 26 Oct 2022 18:00:51 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666832451; x=1669424452; bh=hppA36QO/822mMJc73WWU3Pnzz3V6woG0DV
        kM3foBuw=; b=frJpQkSz0A7bw6B2fyZs8sDeAV2b7wlbTMHjioOMd/+S8NHgWbA
        sfxXbJw4yhjHfacT8T+gO2X41ljNw5OprJZ2uULnq3eOAGWtaHpms5FETJtFXe8W
        mEdq82NPAcVhC0gSKV90ySArinKlusyPOIvV5VtBzAU77PUPh8OhehW07xxi8oxv
        avXy1nmIIQ5Tf221krn1DNcEewrRZ/ejcCks66vvozHN+d8oCWXmWBXpZG7MkYg2
        nP66zTo51pHSw2Fb0z3IG9hRBWz3dMIXCuUVWAAOWeTQd34276uJ2i/FMsLEMeHC
        WN6DahS0lwUIrZJdWqUKgnZXaINgEr2vQHA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OT6VptdWpyT0 for <linux-ide@vger.kernel.org>;
        Wed, 26 Oct 2022 18:00:51 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MyS6B1lH8z1RvLy;
        Wed, 26 Oct 2022 18:00:49 -0700 (PDT)
Message-ID: <f950962c-935c-db5f-35a3-a0ee7411e90b@opensource.wdc.com>
Date:   Thu, 27 Oct 2022 10:00:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] ata: sata_dwc_460ex: remove variable num_processed
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>, linux-ide@vger.kernel.org
References: <20221024141759.2161963-1-colin.i.king@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221024141759.2161963-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/24/22 23:17, Colin Ian King wrote:
> Variable num_processed is just being incremented and it's never used
> anywhere else. The variable and the increment are redundant so
> remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to for-6.2. Thanks !

> ---
>  drivers/ata/sata_dwc_460ex.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index e3263e961045..fd699c5bfc34 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -472,7 +472,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
>  	struct ata_queued_cmd *qc;
>  	unsigned long flags;
>  	u8 status, tag;
> -	int handled, num_processed, port = 0;
> +	int handled, port = 0;
>  	uint intpr, sactive, sactive2, tag_mask;
>  	struct sata_dwc_device_port *hsdevp;
>  	hsdev->sactive_issued = 0;
> @@ -618,9 +618,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
>  	dev_dbg(ap->dev, "%s ATA status register=0x%x\n", __func__, status);
>  
>  	tag = 0;
> -	num_processed = 0;
>  	while (tag_mask) {
> -		num_processed++;
>  		while (!(tag_mask & 0x00000001)) {
>  			tag++;
>  			tag_mask <<= 1;

-- 
Damien Le Moal
Western Digital Research

