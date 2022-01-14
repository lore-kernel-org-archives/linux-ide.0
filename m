Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55958C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 14 Jan 2022 09:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbiANJXa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 14 Jan 2022 04:23:30 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20440 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiANJX3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jan 2022 04:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642152210; x=1673688210;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n+SxaKvzkZ7XVtw07eKIgPKkmAI7AtDfjwM7hYZ2lU4=;
  b=JJ2YVBhPyiark24AtidbaLGd8n9cl/y2lCw0nom4AtFMHX9Lqzh1R6K7
   pTWlbHUNnpsk66U8hgAXFx5zSdJ11MKSC1Vr3outQdzN+AJImNPpbSxdP
   d4PRyARIDMXA2QOUWFSVvypDGbmsCvkn4LlPn74brpslYSQS4TTjh/9/P
   RRTRvIli8f6Ax1spRLwJ0qtIqqms4W3fTtrbP+01nmLc74SIUheNPQ9oY
   db3J6nlkAWAHp1ibQrx1Xb5WvwThse/xYAMzEU+qpiAe/hZ3Drkfsh6DB
   xat4wncRokEUcT1F9iOQ8YmtjKczB4Kkth361REVzXM7nHtsN3Mu422fn
   A==;
X-IronPort-AV: E=Sophos;i="5.88,288,1635177600"; 
   d="scan'208";a="189422055"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2022 17:23:29 +0800
IronPort-SDR: CMJKQA7Mn/yrVAUrmeQwjObfM+L5ZMsLu3UpYSbpoYSD+9JL+xJY3lF9Ombp/x0SpKBXwXlP+R
 GhkdmlDEgPuC/2anGt20Axl5hNaLsesa/efQ/hshs2vg5lmE9G2Y0CYqgqtVao2FR/SUca/wJo
 qVa9PGX5VWsB3jm3gbJlK1kDLxiibiqZFEszKUYUVo/QG5SsOnASQkV5ZiQyrUqt1a+fpDOgoh
 9htEr7Gv7Vh1v9pIpRS1G3iV01dLhP2q6MPLn0JoyCm6QOKAb2rxR7LHXc5OWi95I2CqFhvtp0
 mHc6rgxqvPguGx1KkyO7MoGs
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 00:55:48 -0800
IronPort-SDR: k6SSlme6bnSR4WB6tzBrIctn+7J9R3HGMec6sSimSSJn6hifMuWkjQ1+GTqrVRUXhYWGwpc4a4
 1Rgpic0rLjg1PtmfZG95Mhe3t2NsjzEDT0NjSeqHl/UrxzM0BQo03Yz1ZsSRjYKuvxmbosiev7
 4HX1B4rrbMScuMEibg96U7q3HuNwqvE0J1Sd39IHRjUtJTXBnTQd4L46xZHjIuY7lUuhc4TaYH
 jT9P8fmVGIIlR37p7Hp3AgaIHshsr20N8NHzZn49yhXB1Vl0Mn0Y7uSxMUGmsuo7tt61FG3jr6
 vyI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 01:23:29 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JZwp855wpz1SVnx
        for <linux-ide@vger.kernel.org>; Fri, 14 Jan 2022 01:23:28 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1642152208; x=1644744209; bh=n+SxaKvzkZ7XVtw07eKIgPKkmAI7AtDfjwM
        7hYZ2lU4=; b=ZCLHTfw9mCHzbmizuZgc5s0RhH28UE9p+RSeG72VVbEJCG8rFKD
        HqCi6x6WAixIwu+lHYHoiqxiIpFEmm//8JsqKQV7x03fX2l+lr/kGYCw3PQ8GWMu
        /3/GK1e0jaTUgJp1LVzdmPY0S1qNecLrQIV29kvyzxnOaa6kq9cFPOCbPLc9SzJ+
        T6+ZyMLmMdhzOv3lGSB0+uGqik3FyVmYXe8vED0oHK1kTyoBu1tcgfCl/DZF+ajj
        T5d3dXZgINZStsEkLGKQeyQFbgpN+68x+MAHvk/Zuln7OIIHbzDqCh14mgLAFI65
        iVoSyT8CBxbipio846by2yF6OJolGZC6l/g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oZ-ngThKLsB5 for <linux-ide@vger.kernel.org>;
        Fri, 14 Jan 2022 01:23:28 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JZwp76vXhz1Rwrw;
        Fri, 14 Jan 2022 01:23:27 -0800 (PST)
Message-ID: <85153d62-15b6-e055-00aa-74b728bb0195@opensource.wdc.com>
Date:   Fri, 14 Jan 2022 18:23:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 0/2][RFC] Make delay before debouncing configurable
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org
References: <20220113154635.17581-1-pmenzel@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220113154635.17581-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/14/22 00:46, Paul Menzel wrote:
> The 200 ms delay before debouncing the PHY was introduced for some buggy
> old controllers. To decrease the boot time to come closer do instant
> boot, add a parameter so users can override that delay.
> 
> The current implementation has several drawbacks, and is just a proof of
> concept, which some experienced Linux kernel developer can probably
> implement in a better way.

I do not think that a libata module parameter is not the way to go with
this: libata is used by all drivers, so for a system that has multiple
adapters, different delays cannot be specified easily.

I am really thinking that the way to go about this is to remove the
200ms delay by default and add it only for drivers that request it with
a link flag. That is, ATA_LFLAG_NO_DEBOUNCE_DELAY needs to become
ATA_LFLAG_DEBOUNCE_DELAY.

The other large delay is the link stability check in
sata_link_debounce(). 100ms is added (more for hotplug case) to ensure
that the SStatus register DET field provides a stable value. But I
cannot find any text in the AHCI and SATA IO specs that mandate such
large delay.

I tried to address all of the above. Please have a look at the top 4
patches in the sata-timing branch of the libata tree:

git@gitolite.kernel.org:pub/scm/linux/kernel/git/dlemoal/libata

The sata-timing branch is for now based on libata for-5.17 branch.

The 200ms delay in sata_link_resume() is gone by default, replaced with
a 1ms delay (totally arbitrary). The 200ms delay is executed only if a
driver has the ATA_LFLAG_DEBOUNCE_DELAY link flag set.

The next part is sata_link_debounce(): I *think* that we can assume that
a link is stable if we see cur_det == last_det == 3. In this case,
bailing out early seems to be fine, at least on my test box (Intel
dual-socket Xeon server with Intel AHCI chipset). But I only tested
boot/reboot. Hotplug/unplug and suspend/resume need to be tested, but I
need to go to the lab for that (working from home). Will try next week.

Could you give this branch a try and check how that improves device scan
times ?

On my test box, which has *a lot* of drives, I see something like this:

Before:
[   16.696140] ata4: SATA max UDMA/133 abar m524288@0x9d200000 port
0x9d200180 irq 341
[   17.527446] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
...
-> 831 ms to get the link ready

After:
 [   15.957946] ata4: SATA max UDMA/133 abar m524288@0x9d200000 port
0x9d200180 irq 341
[   16.245066] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
...
-> 287 ms to get the link ready

There are differences between the many HDDs & SSDs I have connected
though. There is a lot of scheduling side effects at play, so the gains
are variable in my case. A system with a single disk attached should be
used for proper evaluation.

Going forward, if more testing do not show any problem, I am thinking of
pushing these changes to for-next to get things tested more widely and
see who screams that they lost their drives :)
For now, I added the ATA_LFLAG_DEBOUNCE_DELAY to the ata_piix driver
only. Likely, this flag will be needed for most legacy/old adapters
(which I do not have).

Cheers.


-- 
Damien Le Moal
Western Digital Research
