Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEA6C4332F
	for <linux-ide@archiver.kernel.org>; Wed,  2 Nov 2022 07:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiKBH2S (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Nov 2022 03:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBH2R (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2022 03:28:17 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E412B3
        for <linux-ide@vger.kernel.org>; Wed,  2 Nov 2022 00:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667374096; x=1698910096;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ot/nI0fM53TlVPk/De8ftSRBhsS7mdKm5MGv/59/AYQ=;
  b=URNKJp3dQScASNbpZ6pqyF412PB2hTa+c9/LemmZMOVzbODaJhf2WAPE
   YavFeww9A5Eu7SwqteSjazdryZSHHNx/Qv7yoLhe/CbOne0r+z4axdcdk
   k2ei9//XEKYvcQHwzHXXXq7aT0ZcA2MT5ro8EGj9HsArDxbeUaXlHS7ib
   +nTFxDdUqQ68y75o1om642I9m3p/7sNU409pM+bDjDJyUTwtc487zuZXY
   vAhS2O5seziFNUcOzl1b1SJCFke9h2+oBmlSs92rDAHQLSJgTC8zxEhe7
   AacKe7ORLmB2nn4uD1uApaBI2F5OCb6RjQJUT90JPisB6HV4otGg+MRxT
   g==;
X-IronPort-AV: E=Sophos;i="5.95,232,1661788800"; 
   d="scan'208";a="319623780"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 15:28:15 +0800
IronPort-SDR: 6eSL+sdzzIU5ALBoUV9lF9AZqmkbKsdVeKomUCV2M0BU6B4rKIDTp7LQhSKcsf3eybUH4gFsBe
 mSGJ3jGNdyAKzRco2ZkfV48D/7Uxh1xW8sFb4Z6IarAWBrfQ8DfN4gTt7AXrEhTSEa51YSY+64
 r4SOrY0taZpGdp4m2NpKRiow9ybl3pQf9akrXvEMMQEtkncf/s339ITa2wybqyMrGhowJPXE2D
 F0IVuHyAi3YP2W+kEgX9qfa4mNad/i4J2TYhxVhwVUHkNpMn8CyRbmzcc760mjmA8BToyZssjj
 DoecCGQa+fZAoc5FDd4CL6Bn
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Nov 2022 23:41:45 -0700
IronPort-SDR: 2n/aMTRnTziBExiODbv0A7x4OIHBqCzQGkDdP15xtenZN8JhEGc99L7d3FatqN0TZW9gNWgic2
 BwvlRzgtA5TC+vdBe6hNoI47sFbM8wmHcnVXerfURss6mcQeeDdlw1zecQCO0UldEU2rOUluq+
 xPn6oCgW2nKMbFQJLp2EfQRnNyIn0iOyKbOt4wTGqF6mOOihFhFoOcp2qpzL7ySKUh+PDoP2qD
 dxyj6SEY/fUyNNy73+GYAa08xzqPLL2PcasGfQH6Mf6SMKeMDbOUEuKI2iHn05rm5nX/GwRGbf
 ylM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2022 00:28:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N2JQ314mrz1RvTr
        for <linux-ide@vger.kernel.org>; Wed,  2 Nov 2022 00:27:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667374074; x=1669966075; bh=Ot/nI0fM53TlVPk/De8ftSRBhsS7mdKm5MG
        v/59/AYQ=; b=sX7fJiKMz8+5ukvH+UPg23DYEmR9tWWZXwsUu7R3VCq58dcz6+Y
        WpA4QpDz2HASpPZBFoeZWVmNx1FUXkxgngFJgIy0mO0cC+oXqyftIzN3xZ09VZUA
        kOF6p+dOUL6vDEj+KCX2Gn3pd1HsG3SON6A0otdUpWWrOogHMvzcKsksK41nhkg9
        z+isUJf2ZZk/6Uyz8UUQhCyRPgF3F/o83Rl4VE6i0cvMpQrqzYesSUmrRPgSNKta
        jnfBLF9rcSZs/So81u1AaRJGoTKFMIWQR4GhAHWSGo7IdVzUuFyox1zMA9jPFR+b
        hjyTd3R1WigK1K5/fZf+dDWdM5KUzjCwGyQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M20iVz6FKHE1 for <linux-ide@vger.kernel.org>;
        Wed,  2 Nov 2022 00:27:54 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N2JQ14ZCMz1RvLy;
        Wed,  2 Nov 2022 00:27:53 -0700 (PDT)
Message-ID: <b37f7806-e31c-2448-0f3e-b7d7fe03d858@opensource.wdc.com>
Date:   Wed, 2 Nov 2022 16:27:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v4 1/7] block: Prevent the use of REQ_FUA with read
 operations
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
References: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
 <20221031022642.352794-2-damien.lemoal@opensource.wdc.com>
 <Y2E2wFnbeUzAPjo0@infradead.org>
 <3af6895b-b776-cf0d-fe1e-866ce5e6b0b0@opensource.wdc.com>
 <Y2IXjzWL5eHA3Co9@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y2IXjzWL5eHA3Co9@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/11/02 16:09, Christoph Hellwig wrote:
> On Wed, Nov 02, 2022 at 07:05:35AM +0900, Damien Le Moal wrote:
>>>> +	if (!op_is_write(rq->cmd_flags) && (rq->cmd_flags & REQ_FUA)) {
>>>> +		blk_mq_end_request(rq, BLK_STS_NOTSUPP);
>>>
>>> How could this even happen?  If we want a debug check,  I think it
>>> should be in submit_bio and a WARN_ON_ONCE.
>>
>> I have not found any code that issues a FUA read. So I do not think this
>> can happen at all currently. The check is about making sure that it
>> *never* happens.
>>
>> I thought of having the check higher up in the submit path but I wanted to
>> avoid adding yet another check in the very hot path. But if you are OK
>> with that, I will move it.
> 
> I'd do something like this:
> 
> ---
> From 96847cce848938d1ee368e609ccb28a19854fba3 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Wed, 2 Nov 2022 08:05:41 +0100
> Subject: block: add a sanity check for non-write flush/fua bios
> 
> Check that the PREFUSH and FUA flags are only set on write bios,
> given that the flush state machine expects that.
> 
> Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index e9e2bf15cd909..4e2b01a53c6ab 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -720,12 +720,15 @@ void submit_bio_noacct(struct bio *bio)
>  	 * Filter flush bio's early so that bio based drivers without flush
>  	 * support don't have to worry about them.
>  	 */
> -	if (op_is_flush(bio->bi_opf) &&
> -	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
> -		bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
> -		if (!bio_sectors(bio)) {
> -			status = BLK_STS_OK;
> +	if (op_is_flush(bio->bi_opf)) {
> +		if (WARN_ON_ONCE(bio_op(bio) != REQ_OP_WRITE))
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

Indeed looks nicer. I will send a v5 with this.

-- 
Damien Le Moal
Western Digital Research

