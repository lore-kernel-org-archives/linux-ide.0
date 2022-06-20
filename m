Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CECBC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 20 Jun 2022 04:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiFTEsH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 20 Jun 2022 00:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbiFTEsG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2022 00:48:06 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC07B28A
        for <linux-ide@vger.kernel.org>; Sun, 19 Jun 2022 21:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655700485; x=1687236485;
  h=message-id:date:mime-version:to:from:subject:
   content-transfer-encoding;
  bh=Fp1YV/H54fWKae49QTYpj5CNXERWqHTEkZJXLZ2XPUA=;
  b=mK/VKKzWQ1Y5PkHjUesFR6Ppu14MrWpx0E2mwGSvOn+JydsTbRCzP2EU
   9XVnqB3Qo8VN1iMYeG04bw664bZ2n/YKXSaV3W3/2GOo7l5ikdvdFVOBD
   O9Gey3tcv2uziCEc8YIO/wmjF4LLWM/FplTDwoaiQT44f3aQCiGLIVqO+
   S6ZpyF2OiPUVX4ibp6Y0AKJGKXQe0P5Xl9EfwE9GQ6DULMfPpND/iQlrT
   vGw2sCmiKeNGVEftd4caRisKgqtneRh6CthURSFwbT6/t7cR817fQPYD3
   AdtC3zMobUpZ1a5ZQyjo10Mktc8knOcm4a6lDNAIeaujabG6sfX1kH/qC
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="307907156"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 12:48:04 +0800
IronPort-SDR: WnklqgsQ3d1BH4IZ9NojsbWk+V2luouT3XHNmp3evQhaOZOsMJjSU3kcRbG1J25sZvEOJSqGCM
 1p6Vzk83gsKOYa8NwxVtDOsm5Wrn+ZKNHPscCr0L32N7kD25fioRpP1h5IaEongp0E+b3NMCrn
 R2LfqkMslSzFDModx2TF0SsiJACFMmuTC2i1j77SP/HLPo6b6L+U6MLIaxIRyZFS3svuuZVrtv
 sfawLnrTMSw936B9AoH2AuqyNdG3AuAYecw5/3fRiMdwKwULLg2T+FjoTU4OfmJiqUPMVujQpm
 TSLuBV0w8yE+w7k6mmpZq5Dw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 21:10:36 -0700
IronPort-SDR: XZf1r1G2mCRfemzAWtzD2KQNS/cgFxAHBJSyFwBXH9VxhO6Y3ic8iRzpQTLuJ7S31X8UmIEeba
 9+g6aU2IM/JaaMZK0MpBTCG+60JiOFDdVBcrjlY2uFgINkCpVLEmqLCUNAzkhKoEYDVGkaaYPC
 1I1EsnC+ZloLwMvSwvbvF80Sw3HOxttbvszOP21RJf5K7bhkJLqyzpvn0qkUFCanaB1Ov70Le8
 3ZJuDw0szoZAdxfqnJur9vE7IxtcHtjRHGQGahZ+VZqYuLk/+K0jIWr3On4vdZldZemq4RYN+y
 diM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 21:48:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LRHFw0qM2z1SVnx
        for <linux-ide@vger.kernel.org>; Sun, 19 Jun 2022 21:48:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :organization:subject:from:to:content-language:user-agent
        :mime-version:date:message-id; s=dkim; t=1655700483; x=
        1658292484; bh=Fp1YV/H54fWKae49QTYpj5CNXERWqHTEkZJXLZ2XPUA=; b=b
        Gqd4TEb8JP+lCMu8J3DFzP3uENPdLUsVfqp6+PJFvvRZmAbdDCR8By4r3RZH+0LD
        xlDjJE/vvMm/3q+P8KRt9qrULDhZhKY3Knql9QKE980Ovx66+2IsAiWEqTO/2Ou2
        2imQb4fchUMiCtYfjPRTdyJn8dWhAKbZmJfEWwA04LvYyF3Up+Ws+sC7FlkzAXv4
        pAJWadaWP1xzegB5fjGuM/rOupEhixpIDxfWTqCBaHnyHo0s8pDzrVHbT9W28whw
        oYQeoqcuFZy91vMCy6CXdfARKM7wmDdQuA4z2sWzZ69mCYcRAZWoIkr6YJeK/qTT
        d5K7ydPOS7Xkd9q0MCPyw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TG2hjUJl_Jtn for <linux-ide@vger.kernel.org>;
        Sun, 19 Jun 2022 21:48:03 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LRHFt55WDz1Rvlc;
        Sun, 19 Jun 2022 21:48:02 -0700 (PDT)
Message-ID: <a5a3527c-d662-5bd1-e1dd-ad4930d10b3a@opensource.wdc.com>
Date:   Mon, 20 Jun 2022 13:48:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Brian King <brking@us.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Do we still need the scsi IPR driver ?
Organization: Western Digital Research
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Polling people here: Do we still need the scsi IPR driver for IBM Power
Linux RAID adapters (IBM iSeries: 5702, 5703, 2780, 5709, 570A, 570B
adapters) ?

The reason I am asking is because this driver is the *only* libsas/ata
driver that does not define a ->error_handler port operation. If this
driver is removed, or if it is modified to use a ->error_handler operation
to handle failed commands, then a lot of code simplification can be done
in libata, which I am trying to do to facilitate the processing of some
special error completion for commands using a command duration limit.

Thoughts ?

-- 
Damien Le Moal
Western Digital Research
