Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD32C3DA7C
	for <linux-ide@archiver.kernel.org>; Fri, 30 Dec 2022 12:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiL3M23 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 30 Dec 2022 07:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbiL3M22 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Dec 2022 07:28:28 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDA3DE9A
        for <linux-ide@vger.kernel.org>; Fri, 30 Dec 2022 04:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672403307; x=1703939307;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6LdN/Q2wkcK3ZLC0NfFvtjVptcUv753zyMlIOm1H1G4=;
  b=PeylwpaptS9SQcu1lPzAKkul85zq+t4vYViTEwcTDaMoT1NR6DzhOyRP
   k9httDy0F3NI3d8AEHWiuswyE/Zy/0IAkwx5iPaiE1/ijBPj2Db85lQZf
   9NlyNwuCwioLuGFeSWAA2hXdR9cjfN1f0ZSlh3CTsIRfWfkMNHRb/6Tw2
   ai7ewTXX6YKcsOLBFip3JBVTMGb7hMp40YJCJUKEhq058OJVsNBDcHnB5
   rbgwW0clqnJxglPQLqCi5OD/2qvNDFtU4h10F2IJ/0vtsfeosvkuxBtoX
   ijky/OvEYRpGDMhHGbfAQUS6frTBntBGmplZowOqP5VJutN7VJDEALn6G
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,287,1665417600"; 
   d="scan'208";a="219873179"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 20:28:25 +0800
IronPort-SDR: PkDi5n4a69dlw5wnb4GeYsn9uCaQawzo+bS1+AedTBbVkoQypV9lgXrqgqdyKFFZ02ZJNCiz/4
 CO8xwplPJkv1vzcfmKeZcE+DFo8UZAKL2Px4bOXNp/UzKU0tTbsNDxndq0HwwKWlKoSGFreMls
 dHNofwybNi4EY6NLvH9pL7Emg5IqkFiaHKQYFcOkw0H8Qx9ThiRpsy5TgX7ji5gpQrNLcILOG9
 FB0ywv3HEmyTvZw/DjvWEiw1rKZX7MamkUie7XW86l9u3p5mdWVwPpteX0BzO/bYNoR5rsnO+c
 lMs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Dec 2022 03:46:28 -0800
IronPort-SDR: H6IGPyOn0xPDxvxb5Hy8XP2nG4mJ5+tvCTrUbTeasRASyGGISfyhHfSEt0VdDsCTDL0Z1Mu3GT
 jECOtDTBhDGF7UzvOKI8OVVbbx9cN8+Otvk558oUkKqvhRo3hHMKQXwpebkr4fF506YjIO414C
 xEo4JuvovGAnQH0iU5nNqVyySh85ZOLCGAqaNHb1AbMOn9MGZh3tXR0hfeyY/wQhCRG9gIdCqm
 zkHMDMlw5uuGsM+cDkRlq4eCYvviScKu7yKHrR2g+12SFcXpQkTEh+qsE8Q2KsAkPXCMyzj3mt
 okg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Dec 2022 04:28:25 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nk4L114mCz1RwtC
        for <linux-ide@vger.kernel.org>; Fri, 30 Dec 2022 04:28:25 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1672403304; x=1674995305; bh=6LdN/Q2wkcK3ZLC0NfFvtjVptcUv753zyMl
        IOm1H1G4=; b=dRg8zjWumHrStWFffNN2j7rgOLBq3jpvXbOqecx0pPTgLg8oZXY
        MCeElKUGTNKOzubfPITiw+9n93D42J1CFSp3j4yaREFfmjPi7ZdZuzrAG4rKXdiG
        ZWOq6cXM/6DN1Ps29jKxmQ2NIffmqNAn1rIU3gdfsCmfPqIdPrKXRvGupm13dhL8
        xS72aNY0Ni0PGt1EvxJZESvmxQHz4OAMnlkIaAHgn0SYPnV0q7A5n/HI67uMmdSv
        ehBpUqKLh3rA8BDmBpVrd3XaAN/oR5x8b9O8g0PbSQq+yeBoaQfqKoKVwaBshx2a
        DiALpqgHay0uzEysl5d/atLfGe5p4qu8xlw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Mw4JIWPMiKcv for <linux-ide@vger.kernel.org>;
        Fri, 30 Dec 2022 04:28:24 -0800 (PST)
Received: from [10.225.163.126] (unknown [10.225.163.126])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nk4Kz2NxXz1RvLy;
        Fri, 30 Dec 2022 04:28:23 -0800 (PST)
Message-ID: <9682ad7e-a980-2b3d-08a1-2f8b898a9ce6@opensource.wdc.com>
Date:   Fri, 30 Dec 2022 21:28:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 1/7] block: add a sanity check for non-write flush/fua
 bios
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
 <20221108055544.1481583-2-damien.lemoal@opensource.wdc.com>
 <Y67RhYZFwx/kJ0dO@x1-carbon>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y67RhYZFwx/kJ0dO@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/30/22 20:54, Niklas Cassel wrote:
> On Tue, Nov 08, 2022 at 02:55:38PM +0900, Damien Le Moal wrote:
>> From: Christoph Hellwig <hch@infradead.org>
>>
>> Check that the PREFUSH and FUA flags are only set on write bios,
>> given that the flush state machine expects that.
>>
>> Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> ---
>>  block/blk-core.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 17667159482e..d3446d38ba77 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -730,12 +730,15 @@ void submit_bio_noacct(struct bio *bio)
>> 	 * Filter flush bio's early so that bio based drivers without flush
>> 	 * support don't have to worry about them.
>> 	 */
>> -	if (op_is_flush(bio->bi_opf) &&
>> -	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
>> -		bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
>> -		if (!bio_sectors(bio)) {
>> -			status = BLK_STS_OK;
>> +	if (op_is_flush(bio->bi_opf)) {
>> +		if (WARN_ON_ONCE(bio_op(bio) != REQ_OP_WRITE))
>> 			goto end_io;
>> +		if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
> 
> Considering that blk_queue_write_cache() looks like this:
> 
> void blk_queue_write_cache(struct request_queue *q, bool wc, bool fua)
> {
> 	if (wc)
> 		blk_queue_flag_set(QUEUE_FLAG_WC, q);
> 	else
> 		blk_queue_flag_clear(QUEUE_FLAG_WC, q);
> 	if (fua)
> 		blk_queue_flag_set(QUEUE_FLAG_FUA, q);
> 	else
> 		blk_queue_flag_clear(QUEUE_FLAG_FUA, q);
> 
> 	wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
> }
> 
> It seems that you can have flag WC set, without having flag FUA set.
> 
> So should perhaps the line:
> 
>> +             if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
> 
> instead be:
> 
> if (!test_bit(QUEUE_FLAG_FUA, &q->queue_flags)) {

Need both. If there is no write cache or write cache is off, FUA is
implied and is useless.

> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research

