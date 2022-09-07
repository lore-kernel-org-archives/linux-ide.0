Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D5AC54EE9
	for <linux-ide@archiver.kernel.org>; Wed,  7 Sep 2022 22:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiIGWNN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Sep 2022 18:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiIGWNM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Sep 2022 18:13:12 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4E3AA34C
        for <linux-ide@vger.kernel.org>; Wed,  7 Sep 2022 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662588789; x=1694124789;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V+0k4SbulDK21C0d7Ev+pAWQlueHvqwL6BErGZBgVdU=;
  b=WCdjjKDLqY5Z4r4H3VcWiqC0DcUxdPYYLERIyQ+p+2XsoQ2tNc2iDy5g
   sPX1Ap4mVZfQ0ucDPDB0vclzG/EXgjbK5LjSRRN0dLSvovgfUFXFBROFO
   STkPO1hwvTraxZA4HSlbC7XqH4wtOI1P6e9+N7Ygim/EmftUKGNbjcOu1
   xXnfd5JEIBw0VBGLyYxic/RQgyi5a3MT2iIyg65hO8A0fhgcXxkminMwm
   7ya0WDviA5K5+RQib8BcjiMBlP+DRAVX60pF42RU3dDpjdfbanucs338w
   lNFCb1d6bXr9XZDPYpzRms0ZRbEjgVree8TB8s8QjbglQShs50f5uJASP
   g==;
X-IronPort-AV: E=Sophos;i="5.93,298,1654531200"; 
   d="scan'208";a="215942163"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2022 06:13:08 +0800
IronPort-SDR: PUbk7z4U7hFpAMb+AXdzypz8HdYJmLQ+wU1bdVYItgv5KoSpQKsj6nNbuu92+Yhi+PfF4EB/Iq
 HftEQ5lb7zMcDfekJDaZayqC7jIiLbWwdlGv2IOn8/brR0E8VHAkvmMxHqFH13bbcZ2hf7/R5M
 BLynD+0aZFrlNHz4A7YAjevXineUFdoKy4IpFjdkixSeoDCaLuaqzDnBQhhZPOoOO5KtfzyU9b
 0zz3jIJI13QBCeHoJBGaFizvGS2mIAmqyhPsCf+trMVRYvl4DzUhpSVqWt09dgANt96sueyKDl
 XlG6C5hxiSJcthVk2rN3+6hS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Sep 2022 14:33:30 -0700
IronPort-SDR: NcLG2T+UN+fT1qfYw/ADnRSd79aIjYs1asZsUn8v+db8mUlyG5+MfNi6+s4LYBubAclmfNnl5j
 aKjYHHhMlaNtFpUwzlDq49NM3l1yRYwETIKrRZbUmzRSqF7m+bnOl7L8eVKScEvY9HR0TIz26r
 TGrFs81Ri5z4xeAVri4ZipnbtFRgpds7eN7ctTQmg+ipiqMq2L3TheaqiSVS+cYbunEhTDai48
 BtN0j8JChxy8SM7dAgvYGdPzGob3M2uBA1nGdm7XtdU25sIbkTx/jRu5f1WDbvoWs/If8PICs+
 5Ts=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Sep 2022 15:13:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MNGjK5Sy2z1Rwt8
        for <linux-ide@vger.kernel.org>; Wed,  7 Sep 2022 15:13:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1662588788; x=1665180789; bh=V+0k4SbulDK21C0d7Ev+pAWQlueHvqwL6BE
        rGZBgVdU=; b=rebSP0s+zADCSOOsrax25tnyTOjohwsTRNeFBUc3SAOcVEi+h1e
        M4h5z16Y6JJQSfuWVtu3hHBSP8YXXSSY8GmqV10QM9Zu+4OxR+GMJw64wOM10bp5
        lUoxp9b11JoLqpM+6dMKL5gbuaU0oiD5JQRoBUFEbtMU8YPBPwD8KlFA6YPSSAnf
        6sPfaxHI0XA5QUdScRqm2xtV+sFtrhloG7CogXUQJ7dCUyLNUU1NZV4Z4mYa30tN
        03s3qFIe5/YKmKU0u8oGH4O8bFsauOSoPQIik6RHO7huVlp133EQYOI/pCfQSPhn
        C24cyjWFPCc32qvmVEjWF3lGnt2O1io5LlQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1AdyuU19MGKb for <linux-ide@vger.kernel.org>;
        Wed,  7 Sep 2022 15:13:08 -0700 (PDT)
Received: from [10.225.163.64] (unknown [10.225.163.64])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MNGjG656Sz1RvLy;
        Wed,  7 Sep 2022 15:13:06 -0700 (PDT)
Message-ID: <04372579-4c43-efa1-6042-270f6ae919c2@opensource.wdc.com>
Date:   Thu, 8 Sep 2022 07:13:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] libata/ahci: quirk for JMB585/JMB582
Content-Language: en-US
To:     MD Lin <mdlin@jmicron.com>, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        kevinliu@jmicron.com, charonchen@jmicron.com,
        corahuang@jmicron.com, mhchen@jmicron.com, georgechao@jmicron.com,
        banks@jmicron.com, tzuwei@jmicron.com
References: <20220907105130.13797-1-mdlin@jmicron.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220907105130.13797-1-mdlin@jmicron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/7/22 19:51, MD Lin wrote:
> This patch adds a quirk, which enable error bit handling functions
> and SATA configuration for JMicron JMB585/JMB582.
> 
> Signed-off-by: MD Lin <mdlin@jmicron.com>

Please use scripts/get_maintainer.pl to check to whom ata patches should
be addressed. If you do not send patches to me, there is a high chance
that I will miss them.

The patch title should be:

ata: ahci: Add initialization quirk for Jmicro 585/582 controllers

Or equivalent, that is, a little more descriptive.

The commit message also does not explain WHY this quirk is necessary (the
problem is not described) and there is also no description of HOW your
patch address the issue. Please be a little more verbose with the commit
message to better describe the patch.

> ---
>  drivers/ata/ahci.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 505920d45..b0768fae3 100755
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1657,6 +1657,68 @@ static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_priv *hp
>  	}
>  }
>  
> +static void ahci_jmb585_write_sata_phy(void __iomem *mmio, u32 addr, u32 data)

The patch title said jmb585 and jmb582. So should this be called
ahci_jmb58x_write_sata_phy() ?

> +{
> +	writel((addr & 0x01FFFUL) + (1UL << 18UL), mmio + 0xC0);
> +	writel(data, mmio + 0xC8);
> +}
> +
> +static void ahci_jmicron_585_quirk(void __iomem *mmio)

Same here. Also, please be consistent with the names: spell out jmicron or
use jmb, either is fine with me, but once you choose one, stick with it.
So:

ahci_jmb58x_write_sata_phy()
ahci_jmb58x_quirk()

or

ahci_jmicron_58x_write_sata_phy()
ahci_jmicron_58x_quirk()

> +{
> +	u32 pi = readl(mmio + HOST_PORTS_IMPL);
> +	u32 b8_data;
> +
> +	/*
> +	 * enable error bit handling functions, these might overwrite
> +	 * the setting which loads from external SPI flash
> +	 */
> +	b8_data = (pi > 3) ? 0x13 : 0x92;
> +	writel(0x03060004+b8_data, mmio + 0xB8);

Spaces missing around the "+" in the first argument.

> +	writel(0x00FF0B01,         mmio + 0x30);
> +	writel(0x0000003F,         mmio + 0x34);
> +	writel(0x0000001F,         mmio + 0x38);
> +	writel(0x03060000+b8_data, mmio + 0xB8);

Same here.

> +	writel(0xF9E4EFBF,         mmio + 0xB0);

And what are all these magic values ? Where do they come from ?
It would be nice to have these defined as macros with descriptive names in
drivers/ata/ahci.h.

> +
> +	/*
> +	 * set SATA configuration, these might overwrite
> +	 * the setting which loads from external SPI flash
> +	 */
> +	ahci_jmb585_write_sata_phy(mmio, 0x06, 0x70005BE3); /* port0 */
> +	ahci_jmb585_write_sata_phy(mmio, 0x13, 0x70005BE3); /* port1 */
> +	ahci_jmb585_write_sata_phy(mmio, 0x73, 0x000001E5); /* port0 */
> +	ahci_jmb585_write_sata_phy(mmio, 0x75, 0x000001E5); /* port1 */
> +	ahci_jmb585_write_sata_phy(mmio, 0x74, 0x00000024); /* port0 */
> +	ahci_jmb585_write_sata_phy(mmio, 0x80, 0x250B0003); /* port1 */
> +	if (pi > 3) {
> +		ahci_jmb585_write_sata_phy(mmio, 0x20, 0x70005BE3); /* port2 */
> +		ahci_jmb585_write_sata_phy(mmio, 0x2D, 0x70005BE3); /* port3 */
> +		ahci_jmb585_write_sata_phy(mmio, 0x3A, 0x70005BE3); /* port4 */
> +		ahci_jmb585_write_sata_phy(mmio, 0x79, 0x000001E5); /* port3 */
> +		ahci_jmb585_write_sata_phy(mmio, 0x83, 0x250B0003); /* port3 */
> +		ahci_jmb585_write_sata_phy(mmio, 0x7A, 0x00000024); /* port3 */
> +		ahci_jmb585_write_sata_phy(mmio, 0x84, 0x250B0003); /* port3 */
> +	}

Same here, lots of "magic" values that cannot be checked. Please use
macros and add comments describing where these come from (adapter specs ?).

> +}
> +
> +static void ahci_jmicron_quirk(struct pci_dev *pdev,
> +			struct ahci_host_priv *hpriv)
> +{
> +	void __iomem *mmio = hpriv->mmio;
> +	u8 tmp8;
> +
> +	if (pdev->vendor != PCI_VENDOR_ID_JMICRON)
> +		return;
> +
> +	switch (pdev->device) {
> +	case 0x585: /* check if the chip is JMB585 */

The comment can be removed. This is obvious.

Also, there is no case for jmb582 model which the patch title mentions. Is
it the same number for both models ? If that is the case, then please add
a comment above the switch() describing that.

> +		tmp8 = readb(mmio + 0x44);
> +		if (tmp8)
> +			ahci_jmicron_585_quirk(mmio);

The tmp8 variable is not necessary.

> +		break;
> +	}
> +}
> +
>  static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	unsigned int board_id = ent->driver_data;
> @@ -1775,6 +1837,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	 */
>  	ahci_intel_pcs_quirk(pdev, hpriv);
>  
> +	/* set JMicron configuration */

This is obvious from the function name. So you can drop this comment.

> +	ahci_jmicron_quirk(pdev, hpriv);
> +
>  	/* prepare host */
>  	if (hpriv->cap & HOST_CAP_NCQ) {
>  		pi.flags |= ATA_FLAG_NCQ;

-- 
Damien Le Moal
Western Digital Research

