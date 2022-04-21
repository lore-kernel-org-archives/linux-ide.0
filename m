Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2B3C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 21 Apr 2022 23:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442623AbiDUXoR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 21 Apr 2022 19:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442612AbiDUXoQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 21 Apr 2022 19:44:16 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5C764E4
        for <linux-ide@vger.kernel.org>; Thu, 21 Apr 2022 16:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650584485; x=1682120485;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rouwVzr9o77gZhNql1KQUfGq0d1z2fsgjl4Ga2hTF7w=;
  b=JHnjOctRIRe+2V3F+mN4eHv1lKMSaeyRri0f05QiB3Gbic0ZlnH48Lq/
   DuATVdztuPehmRMnUVPeAIPcxFTsOIrIE44Gy7ovbEo++rrmASxxm0RmJ
   DzHPhFGtCFksdru22D21oRwltWp91iey9+/cZrdLwZ+qwgjySEu28v7Tq
   MiKXaD64wL2QA89JPph88tUvVgKQGHfLHwB23IYb8DB+sDg/3QCntuUR/
   /Hqtkh6QWTKrQtr6cJ9+4PoYPls7MvRBP5IPJTOdw84jIXxIpJ4we2Ox/
   7hVQVH18HdWJIon8Sb1cjnQU+eyYxOfSxShWD3p1PTyzEvVemLm0WXkSR
   g==;
X-IronPort-AV: E=Sophos;i="5.90,280,1643644800"; 
   d="scan'208";a="197365160"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2022 07:41:24 +0800
IronPort-SDR: h1JHCpJs2EPK/3zT5WKae/JIRl4w4c8uS5f4kKaFhemdlDtne+KxISgmcgNPSQJl6Tll7Vf7rg
 7q8JwbxfeGme+8ieUnGvYCUlQYZ/vdih82aSJKGcPanhaDotORD0Jd6o5WyoS8eMybWAuZVGCH
 OhorMxomyxiXKfnoGR5A8zzvoiNj4pA4kPTv/v0Wmvoab91y2unndmTRcsFn5jEzkcXaTtcj7d
 DZGnGXSOfxDGe+NkYMuM2DXGgROLL5EIWJMiB14Ib4YQurFPahJCaQ5Z9tRFdSGRkzVm0j8kPG
 dn2k/1M8QNoIlLsj2uu2jtIp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 16:12:25 -0700
IronPort-SDR: ml2ggoRHyaTPZQYYxA1D3Aqk9SrLDiFnecLholv2tuRKjRtO8xXpz3IlU9nI/nyZo5+jc/ZZOT
 gnHFg/YoGlu2n3qv08SSmEyE0aNvVyuF+iMkJqNYv4Ns8spun7q9hkRf/HY/rhQ418LuQrnWtF
 +C636CiSjT8yObbLLNJ88yTvvJgh4QRYTZeyE6mK/DVJZ/vpRuCaf5+Rb3KvjBsiJOrQ9s9Dtb
 lYG6iiPUE050kctxclbbxF1y9kTBkJVv8ekBHg+lVx367sFFDfFL+SOB144aXsvTieGvgFAxVC
 zbI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 16:41:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KkvFH6kJJz1Rwrw
        for <linux-ide@vger.kernel.org>; Thu, 21 Apr 2022 16:41:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650584483; x=1653176484; bh=rouwVzr9o77gZhNql1KQUfGq0d1z2fsgjl4
        Ga2hTF7w=; b=Fx2padbWt/AmFU5QS1cht8YoenHNSbIVjk8y29/DHmtldf3AYKx
        bf5+dVBC4w6vq90sCAtomx+gipf+UkyRxAvZTCcpkKY6pL6bgnv7aAyMXvLJjFj+
        et4Bc4i97inlC+e2QP/oHHeFyl2Hc5LIe41c4yZzUPTIqJ09T6dn0J5LB9ytvETU
        cvTPZeXLbSXxbLZY74Da/bJSGU0DXj9YM1Ha+bT+/DuaeccnneQ3pB8bJIGx6NoV
        blE03OOoL8VcT/h0Ms28+DIsqn5kf1fTdzZaovBUgpPV0YJU35bMr/fzrPL56+dG
        rGpySBMOQHMI2qQXiEhWROT0qDXKvFbw38A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QiRTDFZ8SgDX for <linux-ide@vger.kernel.org>;
        Thu, 21 Apr 2022 16:41:23 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KkvFH2GsHz1Rvlx;
        Thu, 21 Apr 2022 16:41:23 -0700 (PDT)
Message-ID: <b2850508-5f61-0688-74df-930a1447df0c@opensource.wdc.com>
Date:   Fri, 22 Apr 2022 08:41:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ata: libata-core: replace "its" with "it is"
Content-Language: en-US
To:     Diego Viola <diego.viola@gmail.com>
Cc:     linux-ide@vger.kernel.org
References: <20220421045423.17821-1-diego.viola@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220421045423.17821-1-diego.viola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/21/22 13:54, Diego Viola wrote:
> and "isn't" with "is not". The former fixes the typo while the latter
> just uses the same formal language.
> 
> Signed-off-by: Diego Viola <diego.viola@gmail.com>

Applied to for-5.19. Thanks !

-- 
Damien Le Moal
Western Digital Research
