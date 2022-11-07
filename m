Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312EEC433FE
	for <linux-ide@archiver.kernel.org>; Mon,  7 Nov 2022 12:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiKGMNE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Nov 2022 07:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiKGMND (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Nov 2022 07:13:03 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3569ABB6
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 04:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667823181; x=1699359181;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tUstmNhwZ0mBvZkbjuyo7nQC2y/FVzmOOGFSb/fvLS4=;
  b=EMWtYe1shCzseu1L/o8byFoIi/s8O3kiWAtfC3YAFqsNa4PMdxSC1vbo
   Zc1D+F9diLBuz0yGpcslVic393KlgdQUW26ZzZWwQv88Kun6a5/XorX3m
   pb4EiJiDohhX5ce0hFAnd2XjfZ7aNNzbB4laKffRS6QtgGCrUowRiPAFX
   k4FhyiiuH6PrVJBWwWNrshRdDxyKXX9Y5QDBZzG5UoXHoBJgfvLXjDZOm
   kFHFErH2oyIB8fz5sCQlLNqATU/T/ZjVM+kUhP07c4zY783UozJ2rJObI
   s2ssZPG7llvKD3HuMVofhCr3JEBnFIfJUHNSfze3G/PUL0ywbzDvaeVZ7
   g==;
X-IronPort-AV: E=Sophos;i="5.96,143,1665417600"; 
   d="scan'208";a="327762179"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2022 20:13:01 +0800
IronPort-SDR: P/W3eRD+GXtzNMywv6uSqsqzIdvYzSZH3rEGVYjR9Cgad78qLIFbGP4Dey+8jjF130J+ExHNup
 8JZG3M+7ED5CT/WYypTdgWPkibGLHQ5lPxyrYVf+t0tf4b2OUuyM7LuoG4pJz9qpwiEBBkOBrg
 p+viTWE48bg7CuYbxPG2g7ZvURXXEYasgrv9d63d8rwOBXccxFwjZxW4k+Eyg1KT+5lMWw9GYx
 fgg418LUewbkCl+GuD2E2BSRb9v/cMJcc9YGoY05YI+cFCT9K9DIPRKuvbtAuvnEpnIGaRKcAr
 q1o=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 03:32:08 -0800
IronPort-SDR: 1s2LBfME97WVjwsX04SnCu7P2P1tSvm8btYdZjRd4Q4uLWI42dc3Tx7Jar6ifps3rWWymOZBWc
 JhV3GEq0VSR8RQYsW/0KisjvrTiFUvZrIZdR3Q/aDhu9iKY0x50v9nBL9LpmFCVnAdijHwB0Vq
 sekZ9qkDzqBBETbpbjZAyOKptkyttPqAeJ+ErTCNzmwrbiZHmkYA5IlJZGfmbJHjZA9Jr/4LDY
 6gj48gxHQJijNr/ybRZXV0snrSE0+x+t1hCiTVAN7KF9tzoLb8vu9TkSnnlLZyILpPHBCuMAmb
 oq4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 04:13:01 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5VVh5mHjz1RwqL
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 04:13:00 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667823180; x=1670415181; bh=tUstmNhwZ0mBvZkbjuyo7nQC2y/FVzmOOGF
        Sb/fvLS4=; b=rNRusHKEkfrgtGupdl0arGOlnkt2uDWDrSVY0tVugkDCPrBM2nS
        Zw+kTFGsXnMSIYM8TamJqlW6t5UYq3HTCl9t4JjmzG6MXFeDfb+JDOKYjW2/07+/
        Dj9SkeOyMDHEdYB+emwfa9AwYDePccnMR1X17XRvfrvZ20sx4RyEN2Kenl7pMNxV
        mCJ4jTdi0lsLAaCCW8syTY/UAKrhf5UGq6LQndncST3XgBKHfl3I+ePDyNEAQ9l9
        TwN7FZimc/UqHKz3EaBVb4MzrnMXnJACSRaSJOypRC10VXmOzZB8vzfWP2RG41Pu
        E6M6cHkrCn73oI7eo4bU6n/8iBx+CQF+86A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ouwve7NiTUsn for <linux-ide@vger.kernel.org>;
        Mon,  7 Nov 2022 04:13:00 -0800 (PST)
Received: from [10.225.163.31] (unknown [10.225.163.31])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5VVg38nWz1RvLy;
        Mon,  7 Nov 2022 04:12:59 -0800 (PST)
Message-ID: <ca10f501-0d3e-fcae-2b98-d39ca1822a67@opensource.wdc.com>
Date:   Mon, 7 Nov 2022 21:12:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 5/7] ata: libata: Fix FUA handling in ata_build_rw_tf()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
References: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
 <20221107005021.1327692-6-damien.lemoal@opensource.wdc.com>
 <20221107055000.GD28873@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221107055000.GD28873@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/7/22 14:50, Christoph Hellwig wrote:
> On Mon, Nov 07, 2022 at 09:50:19AM +0900, Damien Le Moal wrote:
>> Finally, since the block layer should never issue a FUA read
>> request, warn in ata_build_rw_tf() if we see such request.
> 
> Couldn't this be triggered using SG_IO passthrough with a SCSI 
> WRITE* command that has the FUA bit set?

Yes indeed. Should I drop the warn ?

-- 
Damien Le Moal
Western Digital Research

