Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DD0C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jun 2022 05:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243123AbiFNFnl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Jun 2022 01:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243118AbiFNFnh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jun 2022 01:43:37 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF802E0A4
        for <linux-ide@vger.kernel.org>; Mon, 13 Jun 2022 22:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655185416; x=1686721416;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=9Ap8YSwL65qOAoJQuyEN8ZJfg8fup/8+VB4kgPNpvhc=;
  b=dQXlyA2IKYGtOxfP9c4OIqxQJSq7//y7AeCDuldfG5UQBH4uBa4kg+1V
   ffdIzjeIG/OAcxGkWzSoFl7JwSoDKZrHl6hp+ERdX9xvv8ZwqPMTbs8Dm
   MNmcCuzq+d4aVT0yIHZS/qYsjNadOZPolyLQXcq+swVM+RDacf4u6hF0X
   0t6vCe4hwlzxo5T0FjBxsCWprs9DK5W67yUkTP0q5I0dr5hcggS4kblGJ
   INqNzpU91wHXpPaQnWcFp9QHEK4jqwpBdBTwF0SiZb0+MDAg4vTFk3rH/
   CIdsxycj5WUeascReqYyVbnNwbOHY6SyROGp5d3C3lX2+tInjIhrCL0bL
   g==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647273600"; 
   d="scan'208";a="307358825"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2022 13:43:35 +0800
IronPort-SDR: JbBBs5z2RuZ9GeWId2xKGKW9Gv+SiVU7mKPJh/Kd1BSStAOPbX39H1PaX0OP+HyFf7aFfTrZFX
 UsGhzhilUGLs5SCVHSIRNqRDDWV0b0mVLpYVV2IKDWqu4aQZjW+LpVlHgNBMmFU2XUtBN3eP9V
 yH7OY0ps5wnpWp/rgwTC3HhZNFHdKtIW1pUfKGbiU3XSIubcYh7E/fY7PBDNp90dJ+3zwj38BR
 FGldbyd4IgwRFhwi7ezxxe2HkPgv3kZazS7OoM0L2E1yCumfBZhDvNpjUXyO5t9qzj3DGZ9xxH
 RUBIQ+OMf6wRVU0dDX26bqo+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2022 22:02:10 -0700
IronPort-SDR: iP81cFWOREwRcKVv+7FJ8uLo2fGVdu4U0fAOX4mUizIIql1P4NW7qbM350HkVonjn791zAr+ln
 WXaBeeP8IkizZm6izU19K810/sGefZhd9k+o+qnKndcAjDE9n1JKcdXSsMojCCWoDl4TxvkIRc
 L/RE2QEz+8Ji2Fi60KEx+m9f+90HKGA2DLRHko9FpIivW7afP+99KYMElp+grd3Fo5ml3Mbev/
 K8O9rJbze1X/7YDtV0LN9MrbdXuGwzkgXx6hlnXBPfuMtaVi7VhpcG6ecW18KPn7iJik25ZpSQ
 95Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2022 22:43:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LMcmk68mvz1Rwrw
        for <linux-ide@vger.kernel.org>; Mon, 13 Jun 2022 22:43:34 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655185414; x=1657777415; bh=9Ap8YSwL65qOAoJQuyEN8ZJfg8fup/8+VB4
        kgPNpvhc=; b=r7KNdbdfHNfCFsPZpRmxqKDb657MPDQKo/4+pexeu15Sk9hiQK3
        UEgfjrFrVQbFuXTcdQlDoHFlUInVLJQoMyYPW6N0an00nITcqQnk3tjRv6w1ME3s
        +iR8E4NHyYcRbTW45aSplC4livr8ZIOJvXkoLnmB/TBG8ktAi9kaozADvMOZHWYa
        waeswq7XDTb8EhpXTxUD77dit7aWFVI7nfPpACEND5ymUet0/FKoJK2yqcC0yLJ7
        OjM4bNgMiCGdNGguMNMeRejgF78ZqTRJWfyHYIwEivV0RwkKAPuXoMKis3u6Dwkv
        69w9WuuWQSiTgGzKrznd1obGC8bEeSEnS4A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ecdRN2AHVOMm for <linux-ide@vger.kernel.org>;
        Mon, 13 Jun 2022 22:43:34 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LMcmk0Gy2z1Rvlc;
        Mon, 13 Jun 2022 22:43:33 -0700 (PDT)
Message-ID: <4becbd7c-c08b-0339-033b-0d8ad51f4950@opensource.wdc.com>
Date:   Tue, 14 Jun 2022 14:43:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/3] Make PATA transfer mode masks always being 32-bit
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220508204139.4961-1-s.shtylyov@omp.ru>
 <f4b5fd32-0182-53d4-ca6b-a1f11abbcba8@opensource.wdc.com>
 <446dab29-c8b1-22c6-156c-1a2d266ca30f@omp.ru>
 <7ab32324-c78b-2b4d-2cc0-f9a3f3bc4799@opensource.wdc.com>
 <970f1eae-6101-66df-60b5-3ac05b80ff02@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <970f1eae-6101-66df-60b5-3ac05b80ff02@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/14/22 04:20, Sergey Shtylyov wrote:
> Hello!
> 
> On 6/13/22 2:24 AM, Damien Le Moal wrote:
> 
>>>>> The PATA transfer mode masks (direct and packed) in libata are sometimes
>>>>> declared as *unsigned int* and sometimes as *unsigned long* (which is a
>>>>> 64-bit type on 64-bit architectures), while the packed mask really only
>>>>> uses 20 bits and the PIO/MWDMA/UDMA masks use up to 8 bits. Switching to
>>>>> the uniform 32-bit masks saves siginificant amount of the object code...
>>>>>
>>>>> Sergey Shtylyov (3):
>>>>>   ata: make packed transfer mode masks *unsigned int*
>>>>>   ata: make ata_device::{pio|mwdma|udma}_mask *unsigned int*
>>>>>   ata: make ata_port_info::{pio|mwdma|udma}_mask *unsigned int*
>>>>>
>>>>>  drivers/ata/libata-acpi.c      |  8 +++---
>>>>>  drivers/ata/libata-core.c      | 38 +++++++++++++-------------
>>>>>  drivers/ata/pata_acpi.c        |  2 +-
>>>>>  drivers/ata/pata_ali.c         |  2 +-
>>>>>  drivers/ata/pata_amd.c         | 14 +++++-----
>>>>>  drivers/ata/pata_hpt366.c      |  2 +-
>>>>>  drivers/ata/pata_hpt37x.c      |  6 ++---
>>>>>  drivers/ata/pata_hpt3x2n.c     |  2 +-
>>>>>  drivers/ata/pata_pdc2027x.c    |  4 +--
>>>>>  drivers/ata/pata_serverworks.c |  4 +--
>>>>>  drivers/ata/pata_sis.c         |  2 +-
>>>>>  drivers/ata/pata_via.c         |  2 +-
>>>>>  include/linux/libata.h         | 49 +++++++++++++++++-----------------
>>>>>  13 files changed, 67 insertions(+), 68 deletions(-)
>>>>>
>>>>
>>>> Are you going to resend this as a single patch ?
>>>
>>>    No, I'd like to avoid that... Please merge as is.
>>
>> Nope. I still have concerns about this patch structure. And reviewing
>> again, I think some changes are still missing.
>> E.g., patch 3 changes struct ata_port_info masks to unsigned int. This is
>> used in ata_host_alloc_pinfo() to set the port masks, but I do not see
>> where these are changed to unsigned int too. Which patch does that ? These
>> should be in the same patch.
> 
>    Sigh... they always were *unsigned int*! And I explicitly wrote about that
> in the commit msg of that patch... :-/

Nobody is perfect. I miss/forget stuff from time to time. All you need to
do is to remind me. So no need for the "sigh".

> 
>> I am OK with one patch for the packed mask, and one patch for the
>> {pio|mwdma|udma}_mask fields. Patch 3 is weird and should at least be
>> squashed into patch 2.
> 
>    Why? What does *struct* ata_device have to do with *struct* ata_port_info?
> 
>>
>> But given that patch 1 and 2 both touch the same functions, one patch
>> would be better.
> 
>    I specifically aimed at minimizing the patches....

I do not care about the number of patches it takes to fix/improve
something. I care about what the patches do. And for this case, I prefer
seeing a single patch cleaning up the mess of unsigned long/unsigned int
for all these transfer speed masks so that everything becomes unsigned int
in one go. With multiple patches we still have a messy situation of mixed
unsigned long/unsigned int between patches.

> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
