Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DA9C678D5
	for <linux-ide@archiver.kernel.org>; Wed,  8 Mar 2023 08:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjCHIsq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Mar 2023 03:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCHIsm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Mar 2023 03:48:42 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C70C9438D
        for <linux-ide@vger.kernel.org>; Wed,  8 Mar 2023 00:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678265320; x=1709801320;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nKMxQoiaejKfmdpJhbMJCkmPnEhIS9AxPbvCXG85D28=;
  b=Txc08BaJCjE7u9xhoUrKnoZ33EPLzg7xJPDgYu5OxWPUXgd14r/lbLi+
   rQPRvUq01vikQj5MIO9xZ/OIAfMpV+F5ni5WEz0UghU4TFt4hNWvu/KBa
   zizXuSX2qV/IYENhAs8WhDBoOYmDi7dD2Tt+3j7zBodVYjPsxJ6qc/vTY
   Mb/QX8NBGVFHNw1dxA0XYzu7cM8NoUafBq4WqEaLsJZLvjEBb8m04yfIS
   r4OaXN06FtVZifvqcH5CRd0PoqIgb7lAhkLoPXDC07+85H+wp3lmvy6iY
   xiyxXCUra5ty5qI8bN1xgnd1fNHnclA9KWxALs9Pf/byJpK58iWOabLMG
   g==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="225101353"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 16:48:39 +0800
IronPort-SDR: BTgVG8X8OgYHCj/xzpdoW5M2fIVl+v7ps+ohgBOS5SHpeFUCaJQAIBbpqtD7JlDtFTj0+yXANw
 6wDSVTEeDXJCk7UbmXAnFLSligFXvk+04ZzUHcR5yjSR+8QV+rZOjpCr1+XuhWYZIETWJaVGsE
 pUEOoco2L28XXV6tcsP1V11d4JWxfrssz7ERmFrg9M5cgNwz2UDYm4cVGQ2c9yVObe0o5VwX2X
 87pQfAgQVjPJwvonAgvPmkZ2nFPZjrM1HNxHmepcjx7dpDNL1peWdOKKINB8uuvp+yowPRUzgN
 sWs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2023 23:59:36 -0800
IronPort-SDR: ndGUxVlQEzemhVziUCSqpIy07U9psa3dOkwC/rqwz8jOIDLJqNblf+OL75H0rXXObB3FpXALuB
 aB7G0gSJmSNC5+A8dELvSgW2FW19QiTjJi/Bzz1jaYG+x6vjmbh0nUnn+yQOogL5rsHmnikR01
 A0EvZxn8xO9O8mhYLZH9EHFqFbZOuYhR1NqmtLmVyHp1qEUAigvN9RpKaooT8xMvfksQ8JmV2l
 Akb8VOjDWnRIrI838dnTxXXF90OtWwFQSH1ZvM+i7rsRfuPZIcd1raENtPBW9EqovDai0SGTri
 y9M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:48:40 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmF32VCQz1RwtC
        for <linux-ide@vger.kernel.org>; Wed,  8 Mar 2023 00:48:39 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678265318; x=1680857319; bh=nKMxQoiaejKfmdpJhbMJCkmPnEhIS9AxPbv
        CXG85D28=; b=BmgjmQi1AEDeztx+T3AeCww/VpJukjqB5Nx9MioJPqMkTFv9jfD
        wwF+oQPUI0hn5EjIK6bHCEaZm7l68tMvHvu2CUlJs+/AulrL/gsmNk9NQihiwKQE
        viDJZQVugkGh9I/VeGd6xP2Z6BTEYs6C2+CiFAZTcBks9HOeflzKMZtz2XCwNPzA
        ezLi5DGA1nidVeI8rgRz7btQ4mgtS+NsnBajlkcRpTSAUOCci4txm9PpmSgYAjE5
        fdkkSfnkuMUHu23n5U5c2oN05E2QP4gctBPjMpe99KXy7uIQcW99FBIajURXu51/
        j6ybSueyMv6d7htQ6GXwO9hw08kw6OVqStA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 99qV92xrDqFv for <linux-ide@vger.kernel.org>;
        Wed,  8 Mar 2023 00:48:38 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmF140Qhz1RvLy;
        Wed,  8 Mar 2023 00:48:37 -0800 (PST)
Message-ID: <b121dbf4-abc4-07ce-f0b1-52050fce3818@opensource.wdc.com>
Date:   Wed, 8 Mar 2023 17:48:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] dt-bindings: ata: Add UniPhier controller binding
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230222155906.19403-1-hayashi.kunihiko@socionext.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230222155906.19403-1-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/23/23 00:59, Kunihiko Hayashi wrote:
> Add UniPhier SATA controller compatible string to the platform binding.
> This controller needs three reset controls for Pro4 SoC, or two reset
> controls for PXs2 and PXs3 SoCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Applied to for-6.4. Thanks !

-- 
Damien Le Moal
Western Digital Research

