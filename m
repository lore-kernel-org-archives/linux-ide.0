Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1923C43217
	for <linux-ide@archiver.kernel.org>; Tue,  1 Nov 2022 22:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiKAWGD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiKAWFr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 1 Nov 2022 18:05:47 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27C2DFF4
        for <linux-ide@vger.kernel.org>; Tue,  1 Nov 2022 15:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667340339; x=1698876339;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bvijd/XNf7+b6GpJzbGNsMETf26UX8win/XwhAEB7pc=;
  b=FnBvm2L+zBLCSnqyPgRk1+ui3shIuRAfMXzTxA2fCZt4UIVxTOaIILI6
   94gu1LjlktO/GzVp7jVguGfrVBVbWMyj93G+vsvl0qlUuUQVtcKVs/c2X
   0gOUxBMZPv4PGdM8M5CLaAQWoXKx3F6FV2L4cMW4JoUBhMxt5oHJgVbRw
   wi8ZGltm//gWWe+rgtSG/beG7MLrCFLukFTBlTZpRd5CEqkxXeP/YDxHS
   L7O5+m1in/ahr9hrpFTf+qEHbIMEBxjPSINbXjovYj5KTjKESOdQL8VRb
   sqwrVouCNX6jJGT1HFggxAEhJ/6bQ75g/IVdDH3XqtdO0ba7+yX3PR/ji
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,232,1661788800"; 
   d="scan'208";a="215600110"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 06:05:39 +0800
IronPort-SDR: EmCi2+GdeUAv/y1jljFWRFjvcWoGVLVj2qu5r9JQoK261tDxitIpMV+PE8hkPURrWGfWk+JhQc
 xUJ4VTr/oa3pCdAMxmo35y3N2S7JhPhd3ACtdchz2ig10efekgXLJqcA/2ejneYPGJfd6cgyZp
 yVEo1OPdLK2Ka6EHZc/PwpAvo+WwS/PMVun0hxhuKsKx3UwAVSh0hcnYUHnmUID76rZ5qR9OqU
 /c+KKdXDhkhrgmdCvFC4/euM+FabyjpTs2nL5LutwnmDfblfqSW0FP8esu9DP7Xa4ss3Tlnb7v
 Oxy+3APfZ6qisWnNXiXD/Dil
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Nov 2022 14:24:53 -0700
IronPort-SDR: +B4nniLx3hYzu3zvc06PpQv9ah9uIm5OcOF7SFIyyGCWXIhpq962jcLc5lzN/8neaZmCL9ldGd
 lXNDDcqQfoYj/uBrIRHpyMvIeqazRLI1f0jZHKfvWMcER6EffXsCkp0N8u9mrPWpIFA86HFbdA
 jwPBbfKwL00loSPUOe/1EMEbxntJxPKkFGocygw6IuXIEmQCGlcth2nT0+5vaGS+z+jiWzejdO
 56VwsPntCDTXRX7nu5j31vFnoz8isrsTdH/ACDXMM1Amq6RSPFFmUS3Dvb4I8vVmfRsym+TESU
 F2M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Nov 2022 15:05:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N23xG3v92z1RwtC
        for <linux-ide@vger.kernel.org>; Tue,  1 Nov 2022 15:05:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667340338; x=1669932339; bh=bvijd/XNf7+b6GpJzbGNsMETf26UX8win/X
        whAEB7pc=; b=GtKMTw4fbnWuwaOUvnObRRXDm+jqX4KN2AfXfw5G/GKBOqIhJai
        im70Kwc1H86V7SWGrbU9uc8ENnssjHwrPI1fQkLeXJYxTlHx6brN23UGSatiDkEv
        8lcOsQNXVassrPIz22tQc7bBH4WVtON6LPNRK4GuURpqDW9T/YGBfsQ6K3h+EaPo
        ciyNwykRbOotZ1x7mn3YsBakPyX9OGFV48CVlJ/ijdyHdiVR+DAsdqoZpDL4CMh5
        2lsUE6Q7/ClOpzVgIczjT+ONiDLNV4MhLcDEURLsqEMziSzgJcuHQab309qSi3f0
        klBjM6KpqgsVPCZ8Zl0zPPojeb5HclViRBQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YXDvhe9U9Djo for <linux-ide@vger.kernel.org>;
        Tue,  1 Nov 2022 15:05:38 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N23xD5n7Fz1RvTp;
        Tue,  1 Nov 2022 15:05:36 -0700 (PDT)
Message-ID: <3af6895b-b776-cf0d-fe1e-866ce5e6b0b0@opensource.wdc.com>
Date:   Wed, 2 Nov 2022 07:05:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y2E2wFnbeUzAPjo0@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/2/22 00:09, Christoph Hellwig wrote:
> On Mon, Oct 31, 2022 at 11:26:36AM +0900, Damien Le Moal wrote:
>> +	/*
>> +	 * REQ_FUA does not apply to read requests because:
>> +	 * - There is no way to reliably force media access for read operations
>> +	 *   with a block device that does not support FUA.
>> +	 * - Not all block devices support FUA for read operations (e.g. ATA
>> +	 *   devices with NCQ support turned off).
>> +	 */
>> +	if (!op_is_write(rq->cmd_flags) && (rq->cmd_flags & REQ_FUA)) {
>> +		blk_mq_end_request(rq, BLK_STS_NOTSUPP);
> 
> How could this even happen?  If we want a debug check,  I think it
> should be in submit_bio and a WARN_ON_ONCE.

I have not found any code that issues a FUA read. So I do not think this
can happen at all currently. The check is about making sure that it
*never* happens.

I thought of having the check higher up in the submit path but I wanted to
avoid adding yet another check in the very hot path. But if you are OK
with that, I will move it.

-- 
Damien Le Moal
Western Digital Research

