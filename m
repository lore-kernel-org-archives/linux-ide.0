Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F6DC43334
	for <linux-ide@archiver.kernel.org>; Fri, 17 Jun 2022 07:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380215AbiFQHrn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Jun 2022 03:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiFQHrl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Jun 2022 03:47:41 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBE4DEED
        for <linux-ide@vger.kernel.org>; Fri, 17 Jun 2022 00:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655452061; x=1686988061;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=6tbHq7YJk3KMT+0ZRtruwdz1xUj/PS+SYyS4F6JuC14=;
  b=jRkhm93BurUN2AZ9ACsfEF1eWwxVBZbdi43XZ5YY1aPQQ1iHDniJ3a7p
   xKDVsyaNn/BTG4lubTakYFrAcKjwy1UE3w8R0GyM/w4lxWvpbi4WMzIib
   Ssni4xYbOR2LUl2Cf7ANbwPonxuHSJ46dOdN1YSmXUaW9iOl5sNpBQyXh
   KcazHP7/uNmo/XVzTYWXqYRjjgmLlgnvWDCmNOY2CQt+kNXQVvW5JBUfq
   Mh56gSsttijSjfVAUdathsDomETmGXb4fc+2+YV7inMMqJAD4hnenaD98
   a0G220d+cxlF/fV0XrPdR3UKRW1jhWs4DBzci0pMZ02MEqbXR3+LZSMMe
   g==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="204169060"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 15:47:40 +0800
IronPort-SDR: hKmlzV0mrcPi9QgMQeMUxFjPRaXBp7qk8ddmEOpbxLrOEVEPDehd2zfFStFVdz72ioElgfb9PB
 EfVgYDQMKWFpQn7ERDQIWwXdApd4CTT4DOWqQGfpa17aF5xrqo/H0Cl1CGh1usE5oq8qWQyu00
 LkS9jy3Pjy+LyFOirDVPMbG26uEDt4c6A8fueqm5PGvv9hGVTu5yJxiOR0wZMwH+93hsB83RzH
 9/xofjgXKHLGViD3JkuhskREn/woLK5KFABOWd9Cwc3gCPeAA1nIY8Mrf9qb+WPfHd8Ik8pbQN
 XlKJVFCS/DtqogKou0m9ORxa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 00:05:52 -0700
IronPort-SDR: FiNC8jzXqsA3DkJSOiC+BHXt/dVkEMK/yVZ4ojBXaxjwWaVC1LLgzbLAkQspNXWthx/nwrjSyc
 6/o50++XRBNz+Ky58/g1MBDk9tx5fe8oVi3jnV3t0+lapc/Eg8/C4v4rWjrCAVImUjuv7FwVo4
 7z8xvPlCv5v5XNwcjv6OzdFEA4Xjb9o6/cLjVIuKeZHRtlpn26x5Hl0Mi3Yhl+f7FqiCQ7stmt
 xaWoe0eSlnbV34iSv3OsJ/o4CwIE9qokpt/1A07zpggYh996Q4Ba11xwMKhSJ6nO4ZG/M40TY6
 dt4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 00:47:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPWNX1H4Rz1Rvlx
        for <linux-ide@vger.kernel.org>; Fri, 17 Jun 2022 00:47:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655452059; x=1658044060; bh=6tbHq7YJk3KMT+0ZRtruwdz1xUj/PS+SYyS
        4F6JuC14=; b=egp4Gmx5NRnnG88gPOAyU80K/45nIMTkcenj13bSYJMD6vd4J9f
        BbCAqoDzwArpityeIA6/v1oGEqi8Q/A+nOIoOptOoJcaF/EcCvhFIJEZVN4AYQ8x
        PgpF2FdZRwoOCjmEgL2m0Bu0mPfkW/nHrCOm8YfRJESdAUmkPzDU0IM4hXn6c+0J
        PZ2VSEfapakIn1nHgKATgU2cGOY2PsHOFBKuzu0t9QBqQntk+gKyoUFloF6XUu9j
        /4r6ar8NleSoyhlBvU2f6bjIzlk5vLX1C8aF0NZYgZNiTcAcvMFdtS0eHRiX9o8y
        U5HRW3tpaoAurgjh6DkUgg2WxbxqQDWHwTg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XlD0dBOiAnia for <linux-ide@vger.kernel.org>;
        Fri, 17 Jun 2022 00:47:39 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPWNW3Tj7z1Rvlc;
        Fri, 17 Jun 2022 00:47:39 -0700 (PDT)
Message-ID: <bdbb75df-7afd-99a2-16c0-09df3e1ed937@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 16:47:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: make transfer mode masks *unsigned int*
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <e958e03f-0cb0-e457-33d3-6700d0eb709e@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e958e03f-0cb0-e457-33d3-6700d0eb709e@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/15/22 04:51, Sergey Shtylyov wrote:
> The packed transfer mode masks and also the {pio|mwdma|udma}_mask fields
> of *struct*s ata_device and ata_port_info are declared as *unsigned long*
> (which is a 64-bit type on 64-bit architectures) but actually the packed
> masks occupy only 20 bits (7 PIO modes, 5 MWDMA modes, and 8 UDMA modes)
> and the PIO/MWDMA/UDMA masks easily fit into just 8 bits each, so we can
> safely use (always 32-bit) *unsigned int* variables instead.  This saves
> 745 bytes of object code in libata-core.o alone, not to mention LLDDs...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-5.20. Thanks !

-- 
Damien Le Moal
Western Digital Research
