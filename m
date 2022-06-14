Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8010C43334
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jun 2022 05:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbiFNFYj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Jun 2022 01:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiFNFYi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jun 2022 01:24:38 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F29526576
        for <linux-ide@vger.kernel.org>; Mon, 13 Jun 2022 22:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655184278; x=1686720278;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=g1Yq6Tw8YUFDPHSALNs1ceFf330ZgLKorFwwUsAIAf4=;
  b=FWyF7jgPDc/qRe5YtHLgTd4Z34e3h9uAhRlocx7XbYQIuO2jC1sG8WGC
   CtFPC8LFNCvNvs7YGJ51YjDv7K1F/srDMXx+bQBgNQULS8Bn3BNWlBJKW
   Rdku28LiVELcTuyXJt2Fif/I/O46tVOGLGar1rgjTHjH877+RCrVu+52w
   HGgrKxrjruz5vkKPKftc5ApS5vQX2uCJFh2p3r8t72sTpiKu5ARA2/AFc
   P4I/EI+PgItvDTD4V/458WlyfGTWSr2QEQhAlEmTrjMEZp3amwjVdSvYh
   ld/B/19YQQVPp/c8ZU2i4ZDmtjcnk/Y2SOnoKIsUAEoqeJzzm/4Y6flZC
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647273600"; 
   d="scan'208";a="203835711"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2022 13:24:37 +0800
IronPort-SDR: 4DKKHuOaxMCO0JjBk6/u5E+uCRHpyG4bZwzrawRs9t8Z6cfzq0e+Ab5tIqe3mnFIZoKwJBTN/H
 FkyAC6iMmfmComxfixrqfzcXYgt7poVyuNBJQxf2OnOZsa36oG5VC+9pLM7N0EEXteTzo0u3Wz
 l3yx67hJqU8G1VpHasiYNd7H5cn6JyKHiuv9JLd51xDNpq+2d7WC5lOY6Iu0Xg/Xl8GoVNHz2O
 r+9mzVAqf5OYMhBwt8L96Fu53aQ1H/RbbqaXzVI/iijjWEuxFZRBwPTVZ/vzYyfqbskxfjSrdG
 e2Gpr2PlsLU8qdAilTlbznc9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2022 21:43:12 -0700
IronPort-SDR: SJUDSVRl+dDzOsf6DwM6WSlqaQ+9y/GdPO3C4Frfd3VS/zek6BKomWfg4y/MFsWS6xrDnkgPH7
 23F1exG/XbJcmEuMwN/qDnqNhN9jtjiCUgNbp/StLkp2kdiqA6YqDn7M0v61uKpcVpceTZ9Pnj
 BROZvA1d8nfnQIml1i/Kl0i5ar+exu93YhxCUggXc7MiimcHEuewZGTMIKkFAjYpFGzXMdsjLF
 3aJt0caExr0A7XR2c8u/5X0AJpUWspFSGKTNLQ8ALstFlXVOysYgy5SclqQy4OwZsFG/UxurxL
 t8Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2022 22:24:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LMcLr1QHbz1Rwrw
        for <linux-ide@vger.kernel.org>; Mon, 13 Jun 2022 22:24:36 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655184274; x=1657776275; bh=g1Yq6Tw8YUFDPHSALNs1ceFf330ZgLKorFw
        wUsAIAf4=; b=ertWJdNyz0HAnXvRAsEMx95Nd9HlsJsMOEUrP0KckEXCFfrjLXL
        0kcPOOtslLps7cCztMft9KvU7B8ILPfC+KIbBF5KU9uvt02E1NXh4YeC6qidZGqg
        76GNu4PK3XMxXqtAEUELYDidHM4FwKWuof8h2HdgvbYaYPVi5mwlXUzNrgP3GU3c
        o/X1BO4pxHlyJtt79eExIHPBEyWXonsM1xeC7mMzb3EpTvJElQmKGByrsxRNu1K4
        Y6V+tGsofBP5YvgekHM34MuwYcvlniyetofZkuZDQAh0EHcYZMxHA5k9DXjgOvf6
        M1+32SNJF7PrGX+EjYNdXu7Zskbop/oVANA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CRxn6GYsDiwr for <linux-ide@vger.kernel.org>;
        Mon, 13 Jun 2022 22:24:34 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LMcLn61TCz1Rvlc;
        Mon, 13 Jun 2022 22:24:33 -0700 (PDT)
Message-ID: <de30104b-f299-ab7e-c687-06ca513aa7a7@opensource.wdc.com>
Date:   Tue, 14 Jun 2022 14:24:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: libata-core: fix sloppy parameter type in
 ata_exec_internal[_sg]()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <226fc2b1-ecb9-19d9-d7f0-2c6bc0fc8edf@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <226fc2b1-ecb9-19d9-d7f0-2c6bc0fc8edf@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/14/22 03:47, Sergey Shtylyov wrote:
> Make the 'timeout' parameter to ata_exec_internal_sg() *unsigned int* as
> msecs_to_jiffies() that it calls takes just *unsigned int* for the time in
> milliseconds. Then follow the suit with ata_exec_internal(), its only
> caller; also fix up ata_dev_set_feature(), the only ata_exec_internal()'s
> caller  that explicitly passes *unsigned long* variable for timeout...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.

Since you are changing this function signature, can you also make it
static since it is only used in libata-core.c ? The declaration in
drivers/ata/libata.h is useless.

> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien's 'libata.git' repo.
> 
>  drivers/ata/libata-core.c |    6 +++---
>  drivers/ata/libata.h      |    4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> Index: libata/drivers/ata/libata-core.c
> ===================================================================
> --- libata.orig/drivers/ata/libata-core.c
> +++ libata/drivers/ata/libata-core.c
> @@ -1472,7 +1472,7 @@ static void ata_qc_complete_internal(str
>  unsigned ata_exec_internal_sg(struct ata_device *dev,
>  			      struct ata_taskfile *tf, const u8 *cdb,
>  			      int dma_dir, struct scatterlist *sgl,
> -			      unsigned int n_elem, unsigned long timeout)
> +			      unsigned int n_elem, unsigned int timeout)
>  {
>  	struct ata_link *link = dev->link;
>  	struct ata_port *ap = link->ap;
> @@ -1647,7 +1647,7 @@ unsigned ata_exec_internal_sg(struct ata
>  unsigned ata_exec_internal(struct ata_device *dev,
>  			   struct ata_taskfile *tf, const u8 *cdb,
>  			   int dma_dir, void *buf, unsigned int buflen,
> -			   unsigned long timeout)
> +			   unsigned int timeout)
>  {
>  	struct scatterlist *psg = NULL, sg;
>  	unsigned int n_elem = 0;
> @@ -4339,7 +4339,7 @@ unsigned int ata_dev_set_feature(struct
>  {
>  	struct ata_taskfile tf;
>  	unsigned int err_mask;
> -	unsigned long timeout = 0;
> +	unsigned int timeout = 0;
>  
>  	/* set up set-features taskfile */
>  	ata_dev_dbg(dev, "set features - SATA features\n");
> Index: libata/drivers/ata/libata.h
> ===================================================================
> --- libata.orig/drivers/ata/libata.h
> +++ libata/drivers/ata/libata.h
> @@ -52,11 +52,11 @@ extern u64 ata_tf_read_block(const struc
>  extern unsigned ata_exec_internal(struct ata_device *dev,
>  				  struct ata_taskfile *tf, const u8 *cdb,
>  				  int dma_dir, void *buf, unsigned int buflen,
> -				  unsigned long timeout);
> +				  unsigned int timeout);
>  extern unsigned ata_exec_internal_sg(struct ata_device *dev,
>  				     struct ata_taskfile *tf, const u8 *cdb,
>  				     int dma_dir, struct scatterlist *sg,
> -				     unsigned int n_elem, unsigned long timeout);
> +				     unsigned int n_elem, unsigned int timeout);
>  extern int ata_wait_ready(struct ata_link *link, unsigned long deadline,
>  			  int (*check_ready)(struct ata_link *link));
>  extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,


-- 
Damien Le Moal
Western Digital Research
