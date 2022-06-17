Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59654C43334
	for <linux-ide@archiver.kernel.org>; Fri, 17 Jun 2022 07:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379014AbiFQHsZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Jun 2022 03:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiFQHsX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Jun 2022 03:48:23 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698E12C137
        for <linux-ide@vger.kernel.org>; Fri, 17 Jun 2022 00:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655452099; x=1686988099;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=B46MQXIcMRNO4b8PSavY+ZrQgDNQTUJ/xQERZpR6e7w=;
  b=OadFBBnaXPpc0HNZLTNB5+n/0cO1dozFcNymgVy6a252/Ef7zeLleH97
   91/XiHnwA5NdQxbIlIl/HSNknWKl2792G0UXpyK0UU/IZcdt4/Ogdeyj/
   10ewJdSjz9RU3B7UMiT5J0VqHGQg+R8u2k/bJucQVufmYIZ6OrlWdZMI5
   hv27RD9Yy/dcPmzEgAwqo7Gw/w7Sk6bY4imG1wf38nhQqy+jczYBrMF+K
   sASWNcEwfs4Q4hTJbJ4R8jIO3xPKw7SdKwhP9z1a/Mzdd0osDR/v/mkHV
   TlGNOnMrLFx9+IW3TpD4R5AH0rKjGSioBnvXIz9FWDld2Y0kZoL0DVE2c
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="208264622"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 15:48:19 +0800
IronPort-SDR: SBixhoRT81sXMzN8Es1TeZf7qXym4kiKTkOL3EjFrpWoUYyE+v8ZI42NkpfUOd5xZfR8kObbe9
 IVWY6QjCXWr5iCEXsGYH0k34s06iqDd+B9KDUqoSEa26HNxMa3kRZUSFnUEXhbPI+kc2NdST0l
 tzjPBpzNO5Ww1WTu1zhgllXsnkV9cIXz5ClJ8j/fxKPPH0NvyNa3xwhBn5htLnkGvdRfPnlyHi
 trGAb3QyI/OAgpXSVXWy8KDrsV7wBOg0f+GBoVbVPkRm0CJowTfV8Qpr7YtcxR70Py4E8GfnbW
 SysPiEd6Ne92nINlg6ScQEkq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 00:10:54 -0700
IronPort-SDR: nZGOS88M810R+vagLqCZqHZoYBEpOIHabxoHqCDXvWsSMnYYrrUXYsL/G9umr6RCyJt6gEEYyb
 TEPDs/tV07QEcAxiJyDN5Xp78d9XY+H4dESGefCjrvP6+xUE4bTiMBKAozMEuqK8HBExW99lhH
 GM+vf0XL5lWRSs4Amgn++JpLzvq6pRxS91kKuK5Zxn994TI7nvQbyjFxLDOTFJtCIZTQ9sU8oc
 suMDN5qAi6YCQYoFoJN3/E05OL9hX302DYgNs89byXKKJ4wNJPCEXQnnbPXrsEmOQC4MSuXPJn
 Tz0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 00:48:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPWPH0Pd7z1Rwrw
        for <linux-ide@vger.kernel.org>; Fri, 17 Jun 2022 00:48:19 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655452098; x=1658044099; bh=B46MQXIcMRNO4b8PSavY+ZrQgDNQTUJ/xQE
        RZpR6e7w=; b=KQrVYiJfMBUDRdvKb/zuEqmrFobtSObD0bXatUopBSJXPxWDSeM
        w3JH33lR6OHN0qAfyXuTkoR1UC2bbJlyCsUtbcMHT03dWB0uU9H2X5Di4B76C48y
        3KbyA9mfhOD+zUfzWO+xoraCbwIYqCzPYivXqmaMqHAfluWBi8jSUpht6k9lxdjb
        PhBVtoikSfaJjKzGVvhZTpvhb9vovgEejEDUOGl6RKIfBJvmFsdxupn8Dmk+muOw
        rp2tastsIbmt2O5trvdGYrr2ULVazZRtNYsKHMpao/jlzpYkRi8+T79ZYtWwCI+/
        iJuMYUNgLOlEgFJGXOkIkVewZ2qk/1QJM+w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K4HBG5PIuXE9 for <linux-ide@vger.kernel.org>;
        Fri, 17 Jun 2022 00:48:18 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPWPG2b06z1Rvlc;
        Fri, 17 Jun 2022 00:48:18 -0700 (PDT)
Message-ID: <58135380-4610-7c92-64d9-509a36631361@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 16:48:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/2] ata: libata-core: make ata_exec_internal_sg()
 *static*
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220615193821.9235-1-s.shtylyov@omp.ru>
 <20220615193821.9235-2-s.shtylyov@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615193821.9235-2-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/16/22 04:38, Sergey Shtylyov wrote:
> ata_exec_internal_sg() is only called by ata_exec_internal() further in
> the same file, so we can make it *static* and remove its prototype from
> drivers/ata/libata.h...
> 
> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
> Changes in version 2:
> - new patch.
> 
>  drivers/ata/libata-core.c | 8 ++++----
>  drivers/ata/libata.h      | 4 ----
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 980328a4b896..3cc1312a2622 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1467,10 +1467,10 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
>   *	RETURNS:
>   *	Zero on success, AC_ERR_* mask on failure
>   */
> -unsigned ata_exec_internal_sg(struct ata_device *dev,
> -			      struct ata_taskfile *tf, const u8 *cdb,
> -			      int dma_dir, struct scatterlist *sgl,
> -			      unsigned int n_elem, unsigned long timeout)
> +static unsigned ata_exec_internal_sg(struct ata_device *dev,
> +				     struct ata_taskfile *tf, const u8 *cdb,
> +				     int dma_dir, struct scatterlist *sgl,
> +				     unsigned int n_elem, unsigned long timeout)
>  {
>  	struct ata_link *link = dev->link;
>  	struct ata_port *ap = link->ap;
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 926a7f41303d..1446a482835d 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -53,10 +53,6 @@ extern unsigned ata_exec_internal(struct ata_device *dev,
>  				  struct ata_taskfile *tf, const u8 *cdb,
>  				  int dma_dir, void *buf, unsigned int buflen,
>  				  unsigned long timeout);
> -extern unsigned ata_exec_internal_sg(struct ata_device *dev,
> -				     struct ata_taskfile *tf, const u8 *cdb,
> -				     int dma_dir, struct scatterlist *sg,
> -				     unsigned int n_elem, unsigned long timeout);
>  extern int ata_wait_ready(struct ata_link *link, unsigned long deadline,
>  			  int (*check_ready)(struct ata_link *link));
>  extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,

Applied this one only to for-5.20. Thanks !

-- 
Damien Le Moal
Western Digital Research
