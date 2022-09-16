Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7FBC54EE9
	for <linux-ide@archiver.kernel.org>; Fri, 16 Sep 2022 14:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiIPOVO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 16 Sep 2022 10:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIPOVM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 16 Sep 2022 10:21:12 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B1471BD6
        for <linux-ide@vger.kernel.org>; Fri, 16 Sep 2022 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663338068; x=1694874068;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=O+pqlwbxQg1hAAq+luWu/GEhDDgCmFWLTEZMPBOz8xs=;
  b=eK4vyUDnJ/RWKWugI/ZCOxm8S+TKoa9bByskzlXz/DN1roiH35ZmA2NB
   Dq2TsGXvtINCttZFNqO/F/DHSrsU7xAQ2bk8rKe3+IgUvz4FW5YpMv/NK
   qyqMjZ83iMosXbfP+kd+sB3f5KqxpTi6z5ycuMYIKeOB5q40QWodhgYIH
   JDrUG7xCR1eiFAZcnS9gSdijvGmrkdL3zAV1HwEhvUTeYxUOczw635awx
   A4BqIbUgRwAlpEOufU9OTwkevN0eod19dT8amAIdpJrs392AXaY0Uk+5q
   nWIBN0rJviTDNJkEvnVWZPbSlXBcXx2gzahBDq2oBBx+k5aqcJX5LioPD
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654531200"; 
   d="scan'208";a="216707657"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2022 22:21:07 +0800
IronPort-SDR: qpJSoDsKL9i0yIZ9N1vgFqreK9sZX5zwOa8XhYcppm6BPaT+B8o/kHMNidA4tQFhNXEeApcte6
 ZAdJ8AmtRj8mXeNDKMHoRqnT4Fi9Hj6DC2AfJOqY77SxlHurFb/fdfBmWr16fd9ri6sNmaNlIs
 iigI+ew5hVqUPGGGhJyc8Jw4A99nn6OADCAKzvQcQdiTWgSPYXJbQP9nYZbWjTkqOZDJOwfIyi
 R3mgC8aFP0Hq7CTHE2HEJhJQ6NV4H4sYjNL7E07Xt/cLjLxUHmS+6UBue1H1KwqgwBeP8ZET/K
 a4llswYJDdcLAZoETIRJ3xJG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 06:41:18 -0700
IronPort-SDR: Vv0iupSTvkmDrNUkFyQmqcn97Oq+ezXmZfx7y6s6jOf0RfsCA0y+MhCf0O7U6qNeux8Z1kOCQs
 E/2/HRD3Wp1IHfBn1RYT777k9VJQ8BKQ7w3Vfs9G1fiThEPA1Dz1+WKY+xKk6WoRzZCN6pQj1h
 WzeGBMq5NvTv7K4Wd6KfZ4zXGqn80GLVSHH7NEOH3UARfxjacZ6GMOLL0338onjuyhTe7TOgoK
 hKVwt/AmHbG5z09iz5IZgTipZc9FYYzBUYiIqXHpknhDnrA4ONL6QUjSFVEpbrcb19oJ68iTn4
 mcY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 07:21:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MTbpX4vKhz1RvTp
        for <linux-ide@vger.kernel.org>; Fri, 16 Sep 2022 07:21:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663338067; x=1665930068; bh=O+pqlwbxQg1hAAq+luWu/GEhDDgCmFWLTEZ
        MPBOz8xs=; b=obazrQBLnRYGfFJyqigB0N1pI915+a7he34qV7FvbJ7M1prfbj8
        J4uaQJ8PWdZCBoeAsPdvCfF0fVHBZTUE/aR1JFuBs14Uer6ZY/DQ4vPUoh9/fK7H
        XzrY7mMpKJvs7MjMmbSt8DlcVeKCGFrefFsbxV2LGTALggDoYvuUfaXFBHZAYTg6
        WgRbs6pgusS+gosyq2w1O1owGrjZLjumL0inM6BUqJdTHTo8PHrKdQMMIzH/z+ma
        EfMFAFspdZPtcV59NKs4fTD3/7lwUmUmJ23ta8OExPLITXQ7vunpy3i+Vuc66+ww
        ArZG0lcfqJxd/Q+Ah7O7BmVak3PgYgqVTZQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CF_v8t3WRC_e for <linux-ide@vger.kernel.org>;
        Fri, 16 Sep 2022 07:21:07 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MTbpT0LZwz1RvLy;
        Fri, 16 Sep 2022 07:21:04 -0700 (PDT)
Message-ID: <198dc594-4d74-ba85-bc4e-190981592ae6@opensource.wdc.com>
Date:   Fri, 16 Sep 2022 15:21:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH] ata: libata-sff: Fix double word in comments
Content-Language: en-US
To:     Shaomin Deng <dengshaomin@cdjrlc.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220830075024.13917-1-dengshaomin@cdjrlc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220830075024.13917-1-dengshaomin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/08/30 8:50, Shaomin Deng wrote:
> Remove the repeated word "Transfer" in comments.
> 
> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>  drivers/ata/libata-sff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index b1666adc1c3a..7916e369e15e 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -776,7 +776,7 @@ static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
>   *	@qc: Command on going
>   *	@bytes: number of bytes
>   *
> - *	Transfer Transfer data from/to the ATAPI device.
> + *	Transfer data from/to the ATAPI device.
>   *
>   *	LOCKING:
>   *	Inherited from caller.

Applied to for-6.1. Thanks.

-- 
Damien Le Moal
Western Digital Research

