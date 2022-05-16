Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C469CC433F5
	for <linux-ide@archiver.kernel.org>; Mon, 16 May 2022 11:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238338AbiEPLTn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 16 May 2022 07:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiEPLTl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 16 May 2022 07:19:41 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E7B34BB0
        for <linux-ide@vger.kernel.org>; Mon, 16 May 2022 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652699980; x=1684235980;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=CUucOLgns6eQXRoE9htceYH05GIXpIff0VqPv0DIPFU=;
  b=bZY7bboj3DyNMtrttxGjcuN+rg6phzrPZIwc0K4j8KT0I+/wDjh2gEB1
   1sg1oSB8lMDbB6QlnIzHs5PwcIu/eEkNLuAjgV50cwik1eWt7KvtFa0qq
   LWpmxayUNK9okgsZSX9LQ22hH4x80CnrmWtOQGgMzrdG9bl8SCVzEUb73
   9kCqK7+zbyQeYgAwbwxmbuab2/sRGyEoWjrz9x6XxIiAxgy7YsgkYVhKG
   GiYQ+0p91drWKrlPsZ4ou0QQPOyNGnaFZfqBuTGcg6kDk9EJo3ywMDSI1
   OGtMPu5Hq7k2jWl8xSz91iEwT7vwieoDpkty6gSzomVO52W/7+PfJtGXj
   w==;
X-IronPort-AV: E=Sophos;i="5.91,229,1647273600"; 
   d="scan'208";a="312407995"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 19:19:39 +0800
IronPort-SDR: AAPZHGN3wuPlMKLhxLdO63TWAh7fWO1iPChaUQZvAhh2Lx3tty5VnQ2+D8wOCXHva5OHl2DC23
 lAXvZShE77agN3HetTZZ0sTSYooDhTtC8VewbSbBW1Ll4kEocLVdfY9wyJtLiAsKCafDX1BJ7h
 mNxVzrbwElaBn72yaTeY3V9s4ag156Td9Qd890uQ8YRFiu4XtDjFbiaJ+0pSaKxbIOmlqZb9hp
 v1sU3Y4SEvTapoBkMN1gtA74W08fJKALzmWmY+JCzIR2OnIIzJes9uAr1fIjNJN9UUoIJlzz4B
 FviaH+0bh1jtJ6Eshd+rj0G1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 03:45:21 -0700
IronPort-SDR: QFROXplp4U8LCQec0HNNZwpeD+JBX0DL04H2YIUnaFHv5kvWFEDrgjqT/9kwOEeqbOQAsGR/Mc
 auS3thy3W6yzLUBHYYuRPx3eSRAJ9/eyXB5Ux1oH/VEizdXyQt9ISF6dPhWWdjL/14dXp7Kl4n
 hfNA6zQMKFFaW3cGfk9udJvGUX9JSb58fHOm70sWJppJks8+x1rTGCMzLw0lf/lPM45ErckjYf
 oetidtabyYXAa9PzXEDBwd6El9LNWiT9vaU7F8YLJpxD3oJq5znp23+FJ+/sYevZBaYz9PZPCQ
 EOg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 04:19:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L1xbv3CJwz1Rvlx
        for <linux-ide@vger.kernel.org>; Mon, 16 May 2022 04:19:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652699979; x=1655291980; bh=CUucOLgns6eQXRoE9htceYH05GIXpIff0Vq
        Pv0DIPFU=; b=QtKP4y4YDlZCxk1+A1Ta1Di70z2oi+JyGndZPqaxfQzBpbgwfOZ
        I06AVUiHmA7pT0LBmZg5BvSA2qfjASwlTS/NV+DVmaztO034z4cUYG1Oi+xoBnw1
        KUuwVG+5owJZSZmIScmyMnI6hPCVpff3QbNP3B3wp1tyN9I5TBLOkhogES5/TPg4
        BTPB3b0PJ4Mj9gvl7Vzhc5Xk1OzXwLJ19o6Wz5dyvExIt/43Jf6DXve/DpxpT7YT
        zHYvFNGMZULmj9UF5UhAGo8E8ZhlP5BWpn/iO66Xcty/RyoXO11bUjpqCVMvo9OZ
        L9Y6s4+BZhZ/2toY5QYPAgHfHsgEk3H1+rA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DZReo_-99fcM for <linux-ide@vger.kernel.org>;
        Mon, 16 May 2022 04:19:39 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L1xbt3ycSz1Rvlc;
        Mon, 16 May 2022 04:19:38 -0700 (PDT)
Message-ID: <90824959-6963-0836-3dca-0331e43e161b@opensource.wdc.com>
Date:   Mon, 16 May 2022 13:19:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] ata: make ata_device::{pio|mwdma|udma}_mask *unsigned
 int*
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220508204139.4961-1-s.shtylyov@omp.ru>
 <20220508204139.4961-3-s.shtylyov@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220508204139.4961-3-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/05/08 22:41, Sergey Shtylyov wrote:
> The {pio|mwdma|udma}_mask fields of the *struct* ata_device are declared
> as *unsigned long* (which is a 64-bit type on 64-bit architectures) while
> the actual masks should easily fit into just 8 bits. The alike fields in
> the *struct* ata_port are already declared as *unsigned int*, so follow
> the suit, converting ata_[un]pack_xfermask() as necessary...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
>  drivers/ata/libata-acpi.c |  3 +--
>  drivers/ata/libata-core.c | 18 +++++++++---------
>  include/linux/libata.h    | 18 +++++++++---------
>  3 files changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index cdb7c0238a43..61b4ccf88bf1 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -525,8 +525,7 @@ int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm)
>  	struct ata_device *dev;
>  
>  	ata_for_each_dev(dev, &ap->link, ENABLED) {
> -		unsigned long udma_mask;
> -		unsigned int xfer_mask;
> +		unsigned int xfer_mask, udma_mask;
>  
>  		xfer_mask = ata_acpi_gtm_xfermask(dev, gtm);
>  		ata_unpack_xfermask(xfer_mask, NULL, NULL, &udma_mask);
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 2a6f301c3359..44af61dfba77 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -418,7 +418,7 @@ static void ata_force_xfermask(struct ata_device *dev)
>  
>  	for (i = ata_force_tbl_size - 1; i >= 0; i--) {
>  		const struct ata_force_ent *fe = &ata_force_tbl[i];
> -		unsigned long pio_mask, mwdma_mask, udma_mask;
> +		unsigned int pio_mask, mwdma_mask, udma_mask;
>  
>  		if (fe->port != -1 && fe->port != dev->link->ap->print_id)
>  			continue;
> @@ -796,11 +796,11 @@ int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
>   *	RETURNS:
>   *	Packed xfer_mask.
>   */
> -unsigned int ata_pack_xfermask(unsigned long pio_mask,
> -			       unsigned long mwdma_mask,
> -			       unsigned long udma_mask)
> +unsigned int ata_pack_xfermask(unsigned int pio_mask,
> +			       unsigned int mwdma_mask,
> +			       unsigned int udma_mask)
>  {
> -	return ((pio_mask << ATA_SHIFT_PIO) & ATA_MASK_PIO) |
> +	return	((pio_mask << ATA_SHIFT_PIO) & ATA_MASK_PIO) |
>  		((mwdma_mask << ATA_SHIFT_MWDMA) & ATA_MASK_MWDMA) |
>  		((udma_mask << ATA_SHIFT_UDMA) & ATA_MASK_UDMA);
>  }
> @@ -816,8 +816,8 @@ EXPORT_SYMBOL_GPL(ata_pack_xfermask);
>   *	Unpack @xfer_mask into @pio_mask, @mwdma_mask and @udma_mask.
>   *	Any NULL destination masks will be ignored.
>   */
> -void ata_unpack_xfermask(unsigned int xfer_mask, unsigned long *pio_mask,
> -			 unsigned long *mwdma_mask, unsigned long *udma_mask)
> +void ata_unpack_xfermask(unsigned int xfer_mask, unsigned int *pio_mask,
> +			 unsigned int *mwdma_mask, unsigned int *udma_mask)
>  {
>  	if (pio_mask)
>  		*pio_mask = (xfer_mask & ATA_MASK_PIO) >> ATA_SHIFT_PIO;
> @@ -1378,7 +1378,7 @@ static inline void ata_dump_id(struct ata_device *dev, const u16 *id)
>   */
>  unsigned int ata_id_xfermask(const u16 *id)
>  {
> -	unsigned long pio_mask, mwdma_mask, udma_mask;
> +	unsigned int pio_mask, mwdma_mask, udma_mask;
>  
>  	/* Usual case. Word 53 indicates word 64 is valid */
>  	if (id[ATA_ID_FIELD_VALID] & (1 << 1)) {
> @@ -3191,7 +3191,7 @@ int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel)
>  {
>  	char buf[32];
>  	unsigned int orig_mask, xfer_mask;
> -	unsigned long pio_mask, mwdma_mask, udma_mask;
> +	unsigned int pio_mask, mwdma_mask, udma_mask;
>  	int quiet, highbit;
>  
>  	quiet = !!(sel & ATA_DNXFER_QUIET);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 1429b7012ae8..f6fc482d767a 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -677,9 +677,9 @@ struct ata_device {
>  	unsigned int		cdb_len;
>  
>  	/* per-dev xfer mask */
> -	unsigned long		pio_mask;
> -	unsigned long		mwdma_mask;
> -	unsigned long		udma_mask;
> +	unsigned int		pio_mask;
> +	unsigned int		mwdma_mask;
> +	unsigned int		udma_mask;

Ah. OK. So you did this here...
Hmmm. I would squash these 3 patches into a single one. Otherwise, we have
sort-of a mess without all patches applied (making revert a pain if needed).

>  
>  	/* for CHS addressing */
>  	u16			cylinders;	/* Number of cylinders */
> @@ -1100,13 +1100,13 @@ extern void ata_msleep(struct ata_port *ap, unsigned int msecs);
>  extern u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask,
>  			u32 val, unsigned long interval, unsigned long timeout);
>  extern int atapi_cmd_type(u8 opcode);
> -extern unsigned int ata_pack_xfermask(unsigned long pio_mask,
> -				      unsigned long mwdma_mask,
> -				      unsigned long udma_mask);
> +extern unsigned int ata_pack_xfermask(unsigned int pio_mask,
> +				      unsigned int mwdma_mask,
> +				      unsigned int udma_mask);
>  extern void ata_unpack_xfermask(unsigned int xfer_mask,
> -				unsigned long *pio_mask,
> -				unsigned long *mwdma_mask,
> -				unsigned long *udma_mask);
> +				unsigned int *pio_mask,
> +				unsigned int *mwdma_mask,
> +				unsigned int *udma_mask);
>  extern u8 ata_xfer_mask2mode(unsigned int xfer_mask);
>  extern unsigned int ata_xfer_mode2mask(u8 xfer_mode);
>  extern int ata_xfer_mode2shift(u8 xfer_mode);


-- 
Damien Le Moal
Western Digital Research
