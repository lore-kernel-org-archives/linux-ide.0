Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28BAC433F5
	for <linux-ide@archiver.kernel.org>; Sun, 10 Apr 2022 23:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiDJXuM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 10 Apr 2022 19:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236049AbiDJXuL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 10 Apr 2022 19:50:11 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2603D14083
        for <linux-ide@vger.kernel.org>; Sun, 10 Apr 2022 16:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649634480; x=1681170480;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=fOe1mfMlHzTu6MBOpDv1gP1kMG1JaKfRhFoDSnAvrrc=;
  b=qGWf7HQRFqXWABDcdMl4gh+YJtVXo59IdgEjTiBhNwaaXlrjiEJp4jeM
   Ra/gYue9QMeqT86ZGq/XapwfFIgJfzgrIZ/IVHEEvuKaWStdyW/qoUBMm
   xG9xjnjdBmHYgQ02qsYZSOhD/jVMg2DXtcSk+MtGySLKfEkIgT3na2KId
   a1kCd8zXxAtEb0E5aP3cW4TasJh1o8O1v6HdbCQl+A6bfmozrVYDo4a9R
   QUTpSU1DwAjit4TQXstnhe5jDJTknkFvgebZND6v9GV4dj33F+39LGmX6
   5/FKqB6XSQDj4fatf/tmAOpP4hAt47PufCNPsV7Vnb2H/61qs/htkY7hv
   g==;
X-IronPort-AV: E=Sophos;i="5.90,250,1643644800"; 
   d="scan'208";a="198470489"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2022 07:47:59 +0800
IronPort-SDR: aNMm1A4s4DL5mnTtjY8WCEZURN+HHZoEaHw2Vxyn9M8u2/PhYtP7FzRavf3Bu7cn25tQkm7gsc
 wbkSvfdNYW83OBIBsVZpsgFnki1L9rCp0zfepjGiEHDGK0Fa+jk2izEAC/NTpwyEYM4vr1JiJ7
 bD2OT2zdglRJkEW/I3lLKks4DNUuJPvpfw64VDvyf0Bk92XiyLpFxgQ2/8TsTlvW4WChzRKEzW
 XNXMFkTvsSZXOSuQHldE6yhAOGwO9dgGDLhDZ7+0VRiin5ICUbOE10dknHcsp1XQAnlmRg1mBV
 wwIvdeufbkFXKH//KeuMqGOm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Apr 2022 16:18:28 -0700
IronPort-SDR: 1IQjptfvQH0lOZjBxOXPqiwTRaPENwnRQKsRrB6TAKY89oGAKe+5jiyvl8jT0qOt8Rt8mUXvM8
 d6xQWrfXNYpMjn+RX00+oF+JvESbgnIGwIWryiGRL2kH6gcTsdZC0eByRs4lBIotrmPhMCV7Ia
 eNoSJZE/6He2OiTSsai4Trmcy/SIyN29pR9WaPRRDW/lMrgDozHn9ovvrT9IHWssc5fDjTto2+
 FHS5dPYUvIwEdn/aW8bHIfyHlBqdx0SdZL0u82giqSk87ejO8olmjTKTVR9ibq2n/9Lx5PSIXx
 HQI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Apr 2022 16:47:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kc7vx6fS7z1SHwl
        for <linux-ide@vger.kernel.org>; Sun, 10 Apr 2022 16:47:57 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649634477; x=1652226478; bh=fOe1mfMlHzTu6MBOpDv1gP1kMG1JaKfRhFo
        DSnAvrrc=; b=KQwFb/NNG5YeshXfOM+GfbuUsKWPk/G7VORCOfMQ8X/Ml58na/m
        jQgpy0taAzw6jn5Q0Y+E+Gg669P2WRFNB2LD19Y6Sk1Efx/rfAB5AOGCILRFxAy7
        eRon5M95ipoYVDBnMVZUZ2e806Qbf3qLpITWZhbiFH9J0gpZg6EokX0oNVUai2wP
        DNGNz0Md8t77Gf8va0qNR79G3GaW30+s5tyNwkLmL115Dz7z7uhQif+Um/3S5fae
        sJIQeSqwwWTCQZkop3jOiZtQWYRym8TYTr1j6Smv3C4ZLSyC0dqjeWcxl0DAtNHx
        +dxuo+XL+etJcIlxQ3NAgyeljLnGcKMqEWA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mBXwzrT9L_zh for <linux-ide@vger.kernel.org>;
        Sun, 10 Apr 2022 16:47:57 -0700 (PDT)
Received: from [10.225.163.8] (unknown [10.225.163.8])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kc7vx0qlYz1Rvlx;
        Sun, 10 Apr 2022 16:47:56 -0700 (PDT)
Message-ID: <1a56a6cc-5062-fd25-4285-aa53b4ad0eba@opensource.wdc.com>
Date:   Mon, 11 Apr 2022 08:47:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ata: pata_sil680: fix result type of
 sil680_sel{dev|reg}()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <9fceaba7-22e0-8cb2-fc69-04c0b8ece7db@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <9fceaba7-22e0-8cb2-fc69-04c0b8ece7db@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/10/22 05:29, Sergey Shtylyov wrote:
> sil680_sel{dev|reg}() return a PCI config space address but needlessly
> use the *unsigned long* type for that,  whereas the PCI config space
> accessors take *int* for the address parameter.  Switch these functions
> to returning *int*, updating the local variables at their call sites.
> Add the empty lines after some declarations, while at it...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
> repo.
> 
>  drivers/ata/pata_sil680.c |   27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> Index: libata/drivers/ata/pata_sil680.c
> ===================================================================
> --- libata.orig/drivers/ata/pata_sil680.c
> +++ libata/drivers/ata/pata_sil680.c
> @@ -47,9 +47,10 @@
>   *	criticial.
>   */
>  
> -static unsigned long sil680_selreg(struct ata_port *ap, int r)
> +static int sil680_selreg(struct ata_port *ap, int r)
>  {
> -	unsigned long base = 0xA0 + r;
> +	int base = 0xA0 + r;
> +
>  	base += (ap->port_no << 4);
>  	return base;

The variable "base" is rather useless here... A simple:

	return 0xA0 + r + (ap->port_no << 4);

would work too and is a lot cleaner.

>  }
> @@ -65,9 +66,10 @@ static unsigned long sil680_selreg(struc
>   *	the unit shift.
>   */
>  
> -static unsigned long sil680_seldev(struct ata_port *ap, struct ata_device *adev, int r)
> +static int sil680_seldev(struct ata_port *ap, struct ata_device *adev, int r)
>  {
> -	unsigned long base = 0xA0 + r;
> +	int base = 0xA0 + r;
> +
>  	base += (ap->port_no << 4);
>  	base |= adev->devno ? 2 : 0;
>  	return base;
> @@ -85,8 +87,9 @@ static unsigned long sil680_seldev(struc
>  static int sil680_cable_detect(struct ata_port *ap)
>  {
>  	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> -	unsigned long addr = sil680_selreg(ap, 0);
> +	int addr = sil680_selreg(ap, 0);
>  	u8 ata66;
> +
>  	pci_read_config_byte(pdev, addr, &ata66);
>  	if (ata66 & 1)
>  		return ATA_CBL_PATA80;
> @@ -113,9 +116,9 @@ static void sil680_set_piomode(struct at
>  		0x328A, 0x2283, 0x1281, 0x10C3, 0x10C1
>  	};
>  
> -	unsigned long tfaddr = sil680_selreg(ap, 0x02);
> -	unsigned long addr = sil680_seldev(ap, adev, 0x04);
> -	unsigned long addr_mask = 0x80 + 4 * ap->port_no;
> +	int tfaddr = sil680_selreg(ap, 0x02);
> +	int addr = sil680_seldev(ap, adev, 0x04);
> +	int addr_mask = 0x80 + 4 * ap->port_no;
>  	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>  	int pio = adev->pio_mode - XFER_PIO_0;
>  	int lowest_pio = pio;
> @@ -165,9 +168,9 @@ static void sil680_set_dmamode(struct at
>  	static const u16 dma_table[3] = { 0x2208, 0x10C2, 0x10C1 };
>  
>  	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> -	unsigned long ma = sil680_seldev(ap, adev, 0x08);
> -	unsigned long ua = sil680_seldev(ap, adev, 0x0C);
> -	unsigned long addr_mask = 0x80 + 4 * ap->port_no;
> +	int ma = sil680_seldev(ap, adev, 0x08);
> +	int ua = sil680_seldev(ap, adev, 0x0C);
> +	int addr_mask = 0x80 + 4 * ap->port_no;
>  	int port_shift = adev->devno * 4;
>  	u8 scsc, mode;
>  	u16 multi, ultra;
> @@ -219,7 +222,7 @@ static void sil680_sff_exec_command(stru
>  static bool sil680_sff_irq_check(struct ata_port *ap)
>  {
>  	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
> -	unsigned long addr	= sil680_selreg(ap, 1);
> +	int addr		= sil680_selreg(ap, 1);
>  	u8 val;
>  
>  	pci_read_config_byte(pdev, addr, &val);


-- 
Damien Le Moal
Western Digital Research
