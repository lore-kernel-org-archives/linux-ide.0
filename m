Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F052C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  8 Jun 2022 10:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbiFHKaQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Jun 2022 06:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbiFHK2E (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2022 06:28:04 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C745B880CB
        for <linux-ide@vger.kernel.org>; Wed,  8 Jun 2022 03:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654683445; x=1686219445;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=E49nx26+OJ1/jRHKiMMpDxenyTCrGPxNodruik37FIg=;
  b=aVzTGGBCSUkqnje1zY1Vih2ypxiRr6JR6Tlo4rvjgjCky7PcrNfO0yd3
   DUsXfu7wUHihRgS2HPKFF9Ze/cpOSUqW21OdUKmnuVIhyvPK/+GNbWoqj
   jHTaabIgp/oLydV/hl8w2tfaJLCrg91nVfmStSD0sA93nXoPmPalRo+ai
   ZYi4ThtEJYZlGYK7iQfLq3xF0Nqu4hLe7qqEhsXnBlQforvgaG7UbH+hO
   ZkBGw5T3dM2tWqQWvUMDDntfOoO9/I7B5dtJdh9e/twGIt7wWlkuQkueF
   sQOF3J2A75D7gwSvxhbDmIztSzgFWoVwFVohYhT3bFQFYsr4e0NE1b/Ua
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647273600"; 
   d="scan'208";a="306862658"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2022 18:17:24 +0800
IronPort-SDR: WC8z4jNL/03xZK3IvXrybQzpjSnX+MGbJ/vOuAZTaT3nHd24n+U8eJnbZDzhXmtNy8xKmzADEw
 u4tTkbb9xs9ZHkZPq9ejS7Gg37RLeRrAr3krDMiU/OCCu4b5LBz4t4HSY8A2OZX4MIIq/zZ2B4
 e9x/rQ8d+FaIri0grnD3sJZ3oWhkQLu9DO5bMtfRN43M8N0sXVuOnMmjHupG9pp0Zt2bcl9wry
 CHtgvlX/8b5JBRs51JsEnfgfUdiUJtWXkd+wla79JPP01BBYOBC5V0F0EjKG4u9JJrKQiWlojI
 22K+V8ZJQb+dA560dyQV+V2R
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jun 2022 02:40:38 -0700
IronPort-SDR: 9AnLdPFmnnMcGuycM7OIpNVHi87/USLSzADQeJW/R1bJO+l5rrAgxH+zR/y3exSVXLLv3pZNuK
 614tOYxbqBhBE1rPaMQ2fx521iOCMKDpl/ZwDWPn340VMH4pq5xnY37t8pTQFvpRfFDys4L2G0
 vn7ejLFE5EEZpdhaguJVm3HVzlqthSoIP4WYoH+6Ux/T8E4xPbGKWGZbKVzy6gppJidTPgXINV
 7CT8FBMfKUMm4HZkg5K8dvbpOcqBBwNNzql5/Zjg3c9G9ryY7MqTa/sMJDlX70nCB/WuBQ4CyH
 KlE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jun 2022 03:17:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LJ37S3f4hz1SHwl
        for <linux-ide@vger.kernel.org>; Wed,  8 Jun 2022 03:17:24 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654683444; x=1657275445; bh=E49nx26+OJ1/jRHKiMMpDxenyTCrGPxNodr
        uik37FIg=; b=ALY+6OqGNrnKChP3ahyoOwTYIZ9GFpo+IGw5gdmzuqkpv6YhOOB
        Ww4W55XeBbPPLNgiLZGrGUWbk3n1gkBwz78DaAHSrWYpQRus3xC6y+8Y85CPp7pp
        CpcHXFfVuy+EV1I0y2Cq3PPQ3VrTxC6zx1FVkbo5s5uEg0pDKF0P/yDW9lN2n0Lm
        ls51XHsHKKUKvg+HRkQXd4Y+De5XCceBmHPmJoa3VhScgushvaMcL/1ryfj/gLn+
        z4Jln44KsenrU56rErEi+CCzAhxvvPnQsLKlFf42UaERY/kezY4t96fa0ZBk3Q0U
        zEHcHq35imScVULY1FF2vOIofWBjJCAPJcA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BfSZtF0ePYBu for <linux-ide@vger.kernel.org>;
        Wed,  8 Jun 2022 03:17:24 -0700 (PDT)
Received: from [10.225.163.72] (unknown [10.225.163.72])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LJ37R4bcSz1Rvlc;
        Wed,  8 Jun 2022 03:17:23 -0700 (PDT)
Message-ID: <12518fe8-f286-fe20-089b-5055c32312b7@opensource.wdc.com>
Date:   Wed, 8 Jun 2022 19:17:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: libata-transport: fix {dma|pio|xfer}_mode sysfs
 files
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-ide@vger.kernel.org
References: <b0f8a1d3-2550-31b2-702c-3294d0569187@omp.ru>
 <c9695894-3bc6-e825-8239-ea6aa3e4831e@opensource.wdc.com>
 <78ae75a3-7f11-b177-c430-ad746f7d106a@omp.ru>
 <a9a01deb-c314-3196-bd3e-947fcd8819b8@opensource.wdc.com>
 <ac79bf20-5db0-90fa-380d-3e16f81bd79f@gmail.com>
 <1c81b5a8-b1b3-7bac-b7e4-9de7127c48b0@opensource.wdc.com>
 <a3d25d32-9e97-e227-4a0b-1c083b29f7f6@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a3d25d32-9e97-e227-4a0b-1c083b29f7f6@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/8/22 19:09, Sergey Shtylyov wrote:
> Hello!
> 
> On 6/8/22 6:14 AM, Damien Le Moal wrote:
> [...]
>>>>>>> The {dma|pio|xfer}_mode sysfs files are incorrectly handled by the
>>>>>>> ata_bitfield_name_match() macro which leads to reading such kind of
>>>>>>> nonsense from them:
>>>>>>>
>>>>>>> $ cat /sys/class/ata_device/dev3.0/pio_mode
>>>>>>> XFER_UDMA_7, XFER_UDMA_6, XFER_UDMA_5, XFER_UDMA_4, XFER_MW_DMA_4,
>>>>>>> XFER_PIO_6, XFER_PIO_5, XFER_PIO_4, XFER_PIO_3, XFER_PIO_2, XFER_PIO_1,
>>>>>>> XFER_PIO_0
>>>>>>>
>>>>>>> Using the correct ata_bitfield_name_search() macro fixes that:
>>>>>>>
>>>>>>> $ cat /sys/class/ata_device/dev3.0/pio_mode
>>>>>>> XFER_PIO_4
>>>>>>
>>>>>> Looks good, but Documentation/ABI/testing/sysfs-ata says:
>>>>>
>>>>>    Completely forgot that the sysfs files are documented as ABIs... :-(
>>>>>    Hm, shouldn't that file be added to the libata's entry in MAINTAINERS?
>>>
>>>    So what's your opinion on that idea?
> 
>    ???

Yep, it looks like other subsystems have their doc files listed there. So
we can add them. Will you send a patch for that ?

>> OK. Then let's do code and doc fixes in one patch, not 2.
> 
>    Doh! Just when I did 2 patches... :-/

Sorry. I replied a little late. Just squash the patches :)

-- 
Damien Le Moal
Western Digital Research
