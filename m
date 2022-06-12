Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08493C433EF
	for <linux-ide@archiver.kernel.org>; Sun, 12 Jun 2022 23:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbiFLXYu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Jun 2022 19:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiFLXYt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Jun 2022 19:24:49 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E2C483AD
        for <linux-ide@vger.kernel.org>; Sun, 12 Jun 2022 16:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655076288; x=1686612288;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=r/vpf7WqnwmUh3cAABvm9Oz9TedniOl7KYjP6rTWY5k=;
  b=KJdCucPpRk7gQI9IZkqRBxixfyzG24AAzFQ0rLfbP3FdmdsqrC/cteZo
   zJppH1nD2U2Tav0ihALGTo1Ln6mFjCOzj99mP+epHoHJ/cKUd1L8klItz
   xbtPJlqNssuQ0Itd19RSCzvKDRZfW7QWnwMJg+C02mWcNVfirrNza3hux
   b+bKzIplzLek4ZdtSirLRHhmF+6VOQMWCmkdZHYmPgMznfYP4orYP7wKv
   w4ziSSws9DVxuVIE8E+n00+kWgEd7MA/VioZ0DA6Vl2jzUYJCuH+A6eBr
   +RJPSY97HGygkY7hY4eSac8wc6zdqip9lGyV3ZOQMo0NyXunF+cXjwEiu
   g==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647273600"; 
   d="scan'208";a="307228783"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2022 07:24:47 +0800
IronPort-SDR: 0Fj7eWp6GNWnGUBc9shlh3Xxo8oRxpJzB05pnZBiWKfjtuSFQoe3czBHOzu7lnadijccj8fFNJ
 2Evhh5gR8D8KMFH8ZrVasYqY37wPUFH+FrnrFhki9O1jvMYqGpzuN4O9U3dDJ9jdkgu1AIoqKd
 hTUJw4FXkcfWc+FhqxdqbE+PnwfjW31sRjm5I4dfB/PsXvv9rB2qRXVUNiKWqwYolQ/WXyf/x9
 2TCQred+oLdA+pjEHg0XN96z0SpwtIfmP+KUNshKqxVFgL9C5n2wqBB8r5Rd2KQGOiP1VM4G7F
 z4t13NNH7eoH5iZMphFPspdz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2022 15:43:28 -0700
IronPort-SDR: 4JMGRjAGrwJiaMe6nma2c7kMFa21dJGU84+9FSU5xCfJbDBR8fTsPzudtk2Sy+/hcZALpNPJkH
 /sxdnfDUEKtIqcW70GikV5/Q+Ldy5xB2fwiSyIv2u+SxdzteRb0E6yrQ5LXmhjUZEnQoLGgI0o
 WmYje1YBDCxkRfRp+b5YzNQubN/TS91loHRuFgQAarbFAc7tApNfWqoBtYhLpk9PNogGXZIp2R
 dSAkqQEoxjNTJDCc9lUXRVjtc9vufoWYO/NR7SJRlgx0/XSd1tsnJFhD2VoKBwlV0AEe0FtzEo
 0+w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2022 16:24:47 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LLrQ74DFwz1Rvlx
        for <linux-ide@vger.kernel.org>; Sun, 12 Jun 2022 16:24:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655076287; x=1657668288; bh=r/vpf7WqnwmUh3cAABvm9Oz9TedniOl7KYj
        P6rTWY5k=; b=Ts+LZP6pSRtcgLE0XhtWim44xL0xIP4Oejj2a3NC2S/80QNWWPW
        9O9J0h5n4Zjh1PUzjeUHn2XEcxfFCOG3wF7IQ1Jh8BcHpZa25QeikbSv/SGFF1tx
        3hU8QOKrhNhq1SGSD+8oQzmRy+s/c3ByaZnxFrhQjT1jHXUCYVs5aHoXDWAzWNAg
        DcLUCuRSrERAxSi/MC4M+9luQOWpPcXKU0kZdetqYEe+o+CaTrefmcCGTXseIdYK
        57c9M3w5bdSpotYWH1U0i3O4jOn49VIaQyWxL2q7kFTp+O46K5pi4hvV1mDF1UWL
        +ikD0Q9qNnMIbXb90My+jK5twpr/+6smdNA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vssGa_NSeosr for <linux-ide@vger.kernel.org>;
        Sun, 12 Jun 2022 16:24:47 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LLrQ65y7Kz1Rvlc;
        Sun, 12 Jun 2022 16:24:46 -0700 (PDT)
Message-ID: <7ab32324-c78b-2b4d-2cc0-f9a3f3bc4799@opensource.wdc.com>
Date:   Mon, 13 Jun 2022 08:24:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/3] Make PATA transfer mode masks always being 32-bit
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220508204139.4961-1-s.shtylyov@omp.ru>
 <f4b5fd32-0182-53d4-ca6b-a1f11abbcba8@opensource.wdc.com>
 <446dab29-c8b1-22c6-156c-1a2d266ca30f@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <446dab29-c8b1-22c6-156c-1a2d266ca30f@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/11/22 06:20, Sergey Shtylyov wrote:
> On 6/8/22 9:44 AM, Damien Le Moal wrote:
> 
>>> The PATA transfer mode masks (direct and packed) in libata are sometimes
>>> declared as *unsigned int* and sometimes as *unsigned long* (which is a
>>> 64-bit type on 64-bit architectures), while the packed mask really only
>>> uses 20 bits and the PIO/MWDMA/UDMA masks use up to 8 bits. Switching to
>>> the uniform 32-bit masks saves siginificant amount of the object code...
>>>
>>> Sergey Shtylyov (3):
>>>   ata: make packed transfer mode masks *unsigned int*
>>>   ata: make ata_device::{pio|mwdma|udma}_mask *unsigned int*
>>>   ata: make ata_port_info::{pio|mwdma|udma}_mask *unsigned int*
>>>
>>>  drivers/ata/libata-acpi.c      |  8 +++---
>>>  drivers/ata/libata-core.c      | 38 +++++++++++++-------------
>>>  drivers/ata/pata_acpi.c        |  2 +-
>>>  drivers/ata/pata_ali.c         |  2 +-
>>>  drivers/ata/pata_amd.c         | 14 +++++-----
>>>  drivers/ata/pata_hpt366.c      |  2 +-
>>>  drivers/ata/pata_hpt37x.c      |  6 ++---
>>>  drivers/ata/pata_hpt3x2n.c     |  2 +-
>>>  drivers/ata/pata_pdc2027x.c    |  4 +--
>>>  drivers/ata/pata_serverworks.c |  4 +--
>>>  drivers/ata/pata_sis.c         |  2 +-
>>>  drivers/ata/pata_via.c         |  2 +-
>>>  include/linux/libata.h         | 49 +++++++++++++++++-----------------
>>>  13 files changed, 67 insertions(+), 68 deletions(-)
>>>
>>
>> Are you going to resend this as a single patch ?
> 
>    No, I'd like to avoid that... Please merge as is.

Nope. I still have concerns about this patch structure. And reviewing
again, I think some changes are still missing.
E.g., patch 3 changes struct ata_port_info masks to unsigned int. This is
used in ata_host_alloc_pinfo() to set the port masks, but I do not see
where these are changed to unsigned int too. Which patch does that ? These
should be in the same patch.

I am OK with one patch for the packed mask, and one patch for the
{pio|mwdma|udma}_mask fields. Patch 3 is weird and should at least be
squashed into patch 2.

But given that patch 1 and 2 both touch the same functions, one patch
would be better.

> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
