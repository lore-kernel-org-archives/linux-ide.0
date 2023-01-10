Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4911C54EBE
	for <linux-ide@archiver.kernel.org>; Tue, 10 Jan 2023 21:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjAJV6R (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 10 Jan 2023 16:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjAJV6P (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2023 16:58:15 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB20C5DE74
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 13:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673387893; x=1704923893;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=sx2MAS8pFeR3d8yTCiM0ZjG2Pu+K8FMPa0JiFjW85iU=;
  b=IeoZuxDPA8GMVMvf3kl4S9LzIISi9OKY08OffyNMOrm4E+mcWewTc8Ab
   ckvwKVuSixsLZGzzHD/xI03mzUQaNGin+WPSIr463Dau+8ZbzYmdVOK2s
   wp6Ke4x/lcdKf/l2TCg3Y56d/HJsVDVBXXMZXF2S35g2s4kMolNh864Rf
   2fPMU68UVusEAOAJXZ47MJgaBxN72/ejY107IyyJxCNstH7MWJ+GV+kI7
   TYvXm/h1fbwVJKR6fco3/1h8B/7rq7I2+xZUtmeugJjmSsmJiEkMZhVRC
   p+aajgvsGjrktx7EZHPjkglp7gekbVOqayp4xhhHEhcTGpNldYOqZ49R9
   A==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="218795507"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2023 05:58:10 +0800
IronPort-SDR: HvFPhg4UfblwnkWC4XqsxQbKIF89bTqNxSZvo5DNk8NvmTCBJFrk0w6ZsNAkhd+NEP+Mj96ItK
 YiJvSK1zRcCx6AqZOpFQ2tDc7rHD4xlb5vrPYVj9mzaMDdfjbEDvxQvh17iAbYhRZF6TLMShG+
 /5aY7d6WjoZCdwDdus44Ec+Qqrq67/l++LyAjPUQsCE5YJJibxDXUjqPmHRjKX+Zzoyr/QD7J1
 ZnFCvjafYDHLWnPLSmExvkbBGFc//hpvEcyLWTboECzvD7YOfSRPbj7H8sgXlAblYEYjXd/dqO
 7QM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 13:15:59 -0800
IronPort-SDR: cLuZZJoBj7gNg00McZ70Q0rRlGpvlfQrNOSzrd/x5HmSKR+IMwMEy0Hi9fZAh8INYjJRRf6xxv
 M32972GfBdnCkM/IWQE+Be0nRVYbBZcGUhxvHeD/toHaslqUcGJ+DlnpRdc1JkUkt2t2V3Bhvo
 Y+wHLFfmTmySXQUMZWck3BmDchF88pOeFNK3WV3k+jivt+zBYWoBIeeek1vqCnuXdE97t+XhHZ
 qMZOhnfNxDB0cdBYZ3k57xxQ/A8KJuok+bOOCdsRZNPl2qs/BUKzE1ZtbmB6X8j85F8JId2GRw
 DqE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 13:58:11 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Ns4SK6BJdz1Rwt8
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 13:58:09 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673387889; x=1675979890; bh=sx2MAS8pFeR3d8yTCiM0ZjG2Pu+K8FMPa0J
        iFjW85iU=; b=lMvCKLgtsfjf5TvcK324BQKzGgxPFLXkUSFQWnv6KlpMbyRgCE3
        LoEM2iW9mt8oG2lCc7sgOPRTXLxydMOoX2RRmlwIi2s/BQcrzNdJj8dRXm9pxE/u
        UHepmzmEO+V4/TDdHuwFdpOKc1baIEmSI08/eaT7Eq6nFhf7VGYvG+gIMgS1+u0V
        keVQHHXpI5uRRw6WXf0W69v0Egr7IrjJAkuLe0Lx38ROZBz9oqgfPGHBHNvcFJDh
        J5l/EFOl/n1sUPzaEquLff3D2HnkqLL+W0h7zO3WTSHjCsJTVE4sjHMfAp2Sx1Ow
        VrXMpaxu4tKXZ6WA9ATX3BbCcni2WzQ50xg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LdsHp5NWP7KX for <linux-ide@vger.kernel.org>;
        Tue, 10 Jan 2023 13:58:09 -0800 (PST)
Received: from [10.225.163.12] (unknown [10.225.163.12])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Ns4SJ24Jkz1RvLy;
        Tue, 10 Jan 2023 13:58:08 -0800 (PST)
Message-ID: <4a278c42-1f7b-f4c2-13c1-06d6fe52997f@opensource.wdc.com>
Date:   Wed, 11 Jan 2023 06:58:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 1/6] block: add a sanity check for non-write flush/fua
 bios
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
References: <20230110132710.252015-1-damien.lemoal@opensource.wdc.com>
 <20230110132710.252015-2-damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230110132710.252015-2-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/10/23 22:27, Damien Le Moal wrote:
> From: Christoph Hellwig <hch@infradead.org>
> 
> Check that the PREFUSH and FUA flags are only set on write bios,
> given that the flush state machine expects that.
> 
> [Damien] The check is also extended to REQ_OP_ZONE_APPEND operations as
> these are data write operations used by btrfs and zonefs and may also
> have the REQ_FUA bit set.
> 
> Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>

Christoph, Jens,

Are you OK with this patch ?

I am going to queue up patches 2 to 6 in libata tree as we have another
series on top of these patches (CDL series rebased). Jens, if you could
take this one in the block tree, that would be great.

Thanks !

> ---
>  block/blk-core.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 9321767470dc..c644aac498ef 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -744,12 +744,16 @@ void submit_bio_noacct(struct bio *bio)
>  	 * Filter flush bio's early so that bio based drivers without flush
>  	 * support don't have to worry about them.
>  	 */
> -	if (op_is_flush(bio->bi_opf) &&
> -	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
> -		bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
> -		if (!bio_sectors(bio)) {
> -			status = BLK_STS_OK;
> +	if (op_is_flush(bio->bi_opf)) {
> +		if (WARN_ON_ONCE(bio_op(bio) != REQ_OP_WRITE &&
> +				 bio_op(bio) != REQ_OP_ZONE_APPEND))
>  			goto end_io;
> +		if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
> +			bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
> +			if (!bio_sectors(bio)) {
> +				status = BLK_STS_OK;
> +				goto end_io;
> +			}
>  		}
>  	}
>  

-- 
Damien Le Moal
Western Digital Research

