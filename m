Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96ABC67871
	for <linux-ide@archiver.kernel.org>; Tue, 25 Oct 2022 00:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiJYAuz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Oct 2022 20:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiJYAtF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Oct 2022 20:49:05 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0B170E52
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2022 16:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666653987; x=1698189987;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=7lQC4sr8oaAgfSJC4gymSJXlk+XZn4EyfTnjCQDEovw=;
  b=UK9sjHsvVlB/HEfBFlG2/0CtsuKgy/tK16ZJtax0WP8BPbT5KqfWTKQk
   2EhRxK8iooQ1amUF1bEchovm0S9qmE4jRRz7Uo6dj7cfTU1VW18AmJSe7
   IFSAZMxHUChFKQlnFMQeguADv4xndq/hPdBEilz3cTbjbyPHd6R/Ewujd
   O/NsnnqmeSBjw163NOLnibgCR+1YBBwIZFFbrLgATRzJOAixeRy+UZok9
   p37kXic8heZirxZ2biakMAS1Uj6OfvBx7CfKDIegNtjOXxa/6PYg1Gipq
   uhvgOylu4duxpUwv/EZhf8DsSCcmNS5wUDe2raaDRkpMEgeggtwB7oTx9
   A==;
X-IronPort-AV: E=Sophos;i="5.95,210,1661788800"; 
   d="scan'208";a="318959523"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2022 07:26:19 +0800
IronPort-SDR: EXIWDOz3H6RZ/efD8/FBlzy5z/3QcSn2n/UVrEfrt6bAf6I5y5STlxrTollv9YCgOy6l0SJ+Mu
 X48KcWGyza1wE/M2rHeEjG9c0d41bp93krjwnlftJMR5rHJOk/l4l0SMJnLLfOKnaNTg8i3Fba
 g2GDG0cs8COlFv0LEXq7h4GZiJ93RVlWiwy+Xc8RpiFsny7Ey7beogft+pZUu2trX32AkZGu4s
 ZfXe7YkuzJfMWvdJBv8XdMG+jVcQRT2god0FYvu6CQfMXkdBeLSblT053Bq2I46u+YQa801jEU
 HoZqJiuFHyf71k1XAtHcJSgJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Oct 2022 15:40:02 -0700
IronPort-SDR: Yhzes34QIEtdzl6IqRLEYytA0mKe4+79+TFXAXjimenQ4oKO0t6+7mpPRcijtcvLLDR3UhN76u
 ttNl7+6fhVCWdxK8S0Q52vcbRRhJwX9XwC367h4UiOG7p0zZwyp0Ztw3XHviukzAmSfn7UC/kT
 7AXG9UpjFxTjg40NkS5+mEJx2Nao0vLafLLohqZCrcX1a8iH1BtpH4O3g2K+75ZgE/iCVMkyiD
 I9gW4D6Vtxn9Tq2HlnhXEbJNEaCDSzPbOgsU4pjHs5hQvI8VPBuCl8VYeJRL+o7P3JKlmOhA4X
 aeg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Oct 2022 16:26:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MxB6334C7z1RwqL
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2022 16:26:19 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666653978; x=1669245979; bh=7lQC4sr8oaAgfSJC4gymSJXlk+XZn4EyfTn
        jCQDEovw=; b=OiAUN360ThhlLqOUduFuGLuy8zyNmFlFNtBrWDw8nLS/31fsXJP
        fhvHXnRtxXjGT5AbARrpRqJhgsfbkfacBY8t+Oey/ySMFQiOTWaiy435Qf5w91Cp
        /0z94dit0RDuVqSgceB1IIY5YbLKzrziuwXHqibMi78Wpe6VSOnC4BLq+Hc6c9mK
        qUwJZrEMMF8cx0nFHCYsovFUDxDSu15uM4E4CwJz7ma2gn0OX3t+0PrBqF90Z+B0
        TzsIbs6LZrSx9q5LheSQZZOssrYZ8yYs0phYiw2XokY3HvUfORHkmllb7qiqqZ0L
        CRCaTDQLFfqEwdMbqfcjXnC6ZiGdGW8b1Iw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5QbFkTDRiPdV for <linux-ide@vger.kernel.org>;
        Mon, 24 Oct 2022 16:26:18 -0700 (PDT)
Received: from [10.225.163.8] (unknown [10.225.163.8])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MxB621vqYz1RvLy;
        Mon, 24 Oct 2022 16:26:18 -0700 (PDT)
Message-ID: <a44337f7-3e8f-abcc-5695-f2e571087e8d@opensource.wdc.com>
Date:   Tue, 25 Oct 2022 08:26:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 0/3] Improve libata support for FUA
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
        Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20221024072609.346502-1-damien.lemoal@opensource.wdc.com>
 <f1456224-f644-dce5-15ea-fecc965788e1@maciej.szmigiero.name>
 <1401aa25-38de-c5e0-f9de-7aeb7ce0af9d@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1401aa25-38de-c5e0-f9de-7aeb7ce0af9d@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/25/22 07:09, Damien Le Moal wrote:
> On 10/25/22 03:48, Maciej S. Szmigiero wrote:
>> On 24.10.2022 09:26, Damien Le Moal wrote:
>>> These patches cleanup and improve libata support for the FUA device
>>> feature. Patch 3 enables FUA support by default for any drive that
>>> reports supporting the feature.
>>>
>>> Changes from v1:
>>>   - Removed Maciej's patch 2. Instead, blacklist drives which are known
>>>     to have a buggy FUA support.
>>>
>>> Damien Le Moal (3):
>>>    ata: libata: cleanup fua handling
>>>    ata: libata: blacklist FUA support for known buggy drives
>>>    ata: libata: Enable fua support by default
>>>
>>
>> Thanks for the updated series.
>>
>> In general (besides the small commit message thing that Sergey had
>> already mentioned) it looks good to me, so:
>> Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> 
> Thanks. I need to do some more testing using some very old drives I found.
> So far, no issues: detection works, some drives have FUA, other not. For
> the ones that have FUA, I am running fstests (ext4 and xfs) to check for
> weird behavior with REQ_FUA writes. Once I complete all tests I will queue
> this.

Actually, I need to take this back. Checking again the code, I found an
issue with this entire FUA support: for a drive that does not support NCQ,
or one that has NCQ but has its queue depth set to one, then for a REQ_FUA
write request, ATA_CMD_WRITE_MULTI_FUA_EXT or ATA_CMD_WRITE_FUA_EXT will
be used. All good, BUT ! sd.c may also send read requests with the FUA bit
set if the read request has REQ_FUA set. For read commands, the regular,
non FUA commands ATA_CMD_READ_MULTI, ATA_CMD_READ_MULTI_EXT, ATA_CMD_READ
or ATA_CMD_READ_EXT will be used since ATA does not define a FUA version
of these. This means that the REQ_FUA flag will be ignored: this entire
code is broken as it is assuming that the read command processing on the
drive is consistent with executions of ATA_CMD_WRITE_MULTI_FUA_EXT or
ATA_CMD_WRITE_FUA_EXT. I do not want to bet on that, especially with old
drives.

I would be tempted to restrict FUA support to drives that support NCQ,
given that with NCQ, both READ FPDMA QUEUED and READ FPDMA WRITE have the
FUA bit. But then, the problem is that if the user changes the queue depth
of the drive to 1 through sysfs, ncq is turned off and we are back to
using the EXT read & write commands, that is, only write has FUA.

So if we want a solid ata FUA support, we would need to always use NCQ
regardless of the drive max queue depth setting...

Thoughts ?

> 
>>
>> Thanks,
>> Maciej
>>
> 

-- 
Damien Le Moal
Western Digital Research

