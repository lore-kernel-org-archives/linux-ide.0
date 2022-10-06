Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FA6C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  6 Oct 2022 05:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJFFqN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 6 Oct 2022 01:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiJFFqL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2022 01:46:11 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D21B8A1CB
        for <linux-ide@vger.kernel.org>; Wed,  5 Oct 2022 22:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665035165; x=1696571165;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yp/8wvTHZ3BOX6ZZhXm6bW9O1sqoUyHC8hQp3/BcelI=;
  b=AwK+ElLbidGjhB2nWH06cZsn55WD7jMvDKajsjluxWzBlWxJ7UR0Xuqb
   CjQfvO175wpNdU9a3cvw55vR39oMbGBNFuo21ibxP1anhWrwQ3f8S7BOm
   Gf7dbvtjs5EO3l+N2APp/qpm8FUvIqaLWFRYOraFIxiYDfpCbe0+TSUDd
   RNXTnGousfXrkDBMSty3O6kQ+jd9TxYAyGw5mdJND75lsXGo5ZN10ldhW
   HUYHfgVqkj3IsYguJAPXAw8dyY502Q50pX3gdF8jJtledpcmKEjfv+oVj
   9Xi1mcs6uBISSXpRkf2Qxj3o0jMZYpeQ++TU+zP2nL743oBYcH5+szqs0
   w==;
X-IronPort-AV: E=Sophos;i="5.95,163,1661788800"; 
   d="scan'208";a="213109326"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2022 13:46:04 +0800
IronPort-SDR: qaz31Jo9csYux1N+IrwDjvirC0t5vMoeYTM30f/OMtR5gCfYQKC+R+oi2/LEgeN1M00tHrROUS
 6p3S3Wg/miKemIQKA6cvNEnUJzvqIeAwvz6+1yxJWTe0BPvQOr1fG8ucVMDUKdIogPir13K0YF
 k8iZoG4wYQFukqa08AhCw1vr2becRchVtVzbD6fcEh68ByK8mIROCKJ/3ts4M+Ec7c+68AgXQB
 38Cfq07SFmhUUV5phk3SYf36983BBYmgLXwLVxwW+pIqeS8FkM9l+qM3ua0iLfFEivQOckIo7N
 ppIBDZw0xVCfDygQqjSwHmqS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2022 22:00:15 -0700
IronPort-SDR: HW6I92P3Pcd0AkUTtxRblgkKLfvZZ3HoAjqR41nl9bATcO6TuTU0cwFIlQRBhgk/xCKt7ZUyzc
 aoqmyw6MqtPOlPCPJ4CTepGHEx/+kzcGQahCa22lCFrQeiwo4+0CmwRrxKKD/7rYfk5njpw2sK
 vta9dqHEmf1X0kQInfC6XfDpwfwRm5btJ/WyAunwp56u8n0+kkoz+B9dWe+GN0H1DcGqHVmSoV
 Fej5DD4xzWvPGlHLbaEStdtVpo4ZDTWvdtONPKdPxYSqsxUsl0t+Y85fCHsKllK4HZNny0RaR+
 s5s=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2022 22:46:04 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MjgQz4g4Nz1RvTp
        for <linux-ide@vger.kernel.org>; Wed,  5 Oct 2022 22:46:03 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665035161; x=1667627162; bh=Yp/8wvTHZ3BOX6ZZhXm6bW9O1sqoUyHC8hQ
        p3/BcelI=; b=PDlEqQ/zg58P2ppafOSiKOdt3GeaV+8AQav+TQOIvA8qmPLH01x
        bRXx8tFsg7uOhKGYyMdn9RS8yr3WRgmqvhmvL/tFhNsvFd1w2JNxAA1hGth1my2C
        +si4Lvbu2zHlvNNGgvvJjwgynSDr+82hLvoToOS/E4fBuEFXNgJzWQEnRR/afJfL
        R+IEzd4/CSdA1z5FSs2GLAzKLkCK9w2dqx2GVmxsLrI0cDuBGu01Gv0INgslvlM3
        3dOU2Od6PfJo8LI4i5uTirV1eRlU4/UfbcmbVu2La+iuer6lgyP/1+d5VnswdhZu
        3WYnwv4WZIXM6KXLSREaSaTFoIDjW3yIKgg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BRdMkv75qwwp for <linux-ide@vger.kernel.org>;
        Wed,  5 Oct 2022 22:46:01 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MjgQx0G3bz1RvLy;
        Wed,  5 Oct 2022 22:46:00 -0700 (PDT)
Message-ID: <60557988-a5e5-8c81-72f9-c0f3ab9ed573@opensource.wdc.com>
Date:   Thu, 6 Oct 2022 14:45:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] ata: pata_mpc52xx: Replace NO_IRQ by 0
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <a8c87c6d8dd6d9e57c515036a333ff89fc56bcbf.1665033366.git.christophe.leroy@csgroup.eu>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a8c87c6d8dd6d9e57c515036a333ff89fc56bcbf.1665033366.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/6/22 14:17, Christophe Leroy wrote:
> NO_IRQ is used to check the return of irq_of_parse_and_map().
> 
> On some architecture NO_IRQ is 0, on other architectures it is -1.
> 
> irq_of_parse_and_map() returns 0 on error, independent of NO_IRQ.
> 
> So use 0 instead of using NO_IRQ.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Doesn't this need fixes and cc:stable tags ?

> ---
>  drivers/ata/pata_mpc52xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index 6559b606736d..3ebd6522a1fd 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
> @@ -731,7 +731,7 @@ static int mpc52xx_ata_probe(struct platform_device *op)
>  		udma_mask = ATA_UDMA2 & ((1 << (*prop + 1)) - 1);
>  
>  	ata_irq = irq_of_parse_and_map(op->dev.of_node, 0);
> -	if (ata_irq == NO_IRQ) {
> +	if (!ata_irq) {
>  		dev_err(&op->dev, "error mapping irq\n");
>  		return -EINVAL;
>  	}

-- 
Damien Le Moal
Western Digital Research

