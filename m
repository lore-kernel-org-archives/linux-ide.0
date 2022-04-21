Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEDCC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 21 Apr 2022 23:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442630AbiDUXow (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 21 Apr 2022 19:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442627AbiDUXov (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 21 Apr 2022 19:44:51 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF8764E4
        for <linux-ide@vger.kernel.org>; Thu, 21 Apr 2022 16:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650584519; x=1682120519;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6VjHqbVwWhUfXX9jLz8xlfmJRICTMPmX0u83Z3Qbkqg=;
  b=nj33cJIDdC/0nTuWG7d90l1RbJyOywwrDM+hZd/p1DOspsaIFeYfbUQK
   i90mnmtS5EU2kEZrblEOA6PVRKOlfB++6Xz7KeHQh5/wyfmAdKURCXteO
   H4/V3lTcukU0c7b6lwTh+woldKLLaE6AUCX9wdtvqL+mJxfdl0xj+ibx7
   Atpu4sLO62plm+gDVbHw6kVQCMQO+jvzLYCIyyc7fCdiV6p1LriERqXw7
   aHzpgImliBxwpTgfAM7ESYcsEETF05rtHambsmznl8ainI67CfqAlbZL1
   I+83/Szeg9pPP1jJ3602lP+UMwvrVJk9y6q7du9ZQA4cvkj7HNkRxdgZ9
   g==;
X-IronPort-AV: E=Sophos;i="5.90,280,1643644800"; 
   d="scan'208";a="198510227"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2022 07:41:58 +0800
IronPort-SDR: sSk/WTVbNoshhXAMJNaANuWddgy777J6iyYsjJFEE71R1ROixhW2zj/E+WA+WStVM0eemZ/LHi
 YgRnnq7+lMclYOk5/nz3fpD4S+24//vLdEHnDgJQ8OtM0ioGS4JqTrC6g1k1tIPXxSWBcxHuXm
 2J3pkwDNQFY7qUuLMW5oR9o9fGM3GrOtMchH34Su4LVQ6AIz84S3VhuQIQsHI7/zqJ+T6nJsPk
 0T/w1eBHimGWDSAeocUPFoQ1HoV7mWbDqDRrqARZVt/yo19elVehd3xpiG6hp9y9IoBB3rPzd7
 TfbFEIVJ89Z7876exJX56mYx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 16:12:16 -0700
IronPort-SDR: jWxTShyKTsB6otqobyGOfGa5J3unejs6FlgBIroKcT1FRYvUi8XK4sReoCEbL74lHtp8pn8js7
 3dCG8M75MVDwe4Vn0B9+9trLbcaku0aYcFFSawe+w5ZXA7egj/0NAifJ2wNp3nAl0Oq5Sp6FJH
 XcATQ7HB39rflREvNPctlP4PXhQVfERLH07Q/Hp82HxTyq1nhkqz0QIaTY1YIha1GsKKT62V3w
 RxsIs+TnuNKMqSFT9Ouc1Dp9iZgAEL5NMZ0B8BcEQqybNidrI72MlMedni9qVaYE3LILBI5fCJ
 5yM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 16:41:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KkvFz0m3Qz1SHwl
        for <linux-ide@vger.kernel.org>; Thu, 21 Apr 2022 16:41:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650584518; x=1653176519; bh=6VjHqbVwWhUfXX9jLz8xlfmJRICTMPmX0u8
        3Z3Qbkqg=; b=XFuIfxcPK795pKDoH8MycvbUN86JqBVZxEzRq3TYyV2PKdvf8um
        con/ZHDoTrBz69LwXPNzdLhH71LaDNLjhEx6NkLIcfyx2UPEt/NTObFQQ6ocX75T
        eIbp79esrnzYVTsyaCTWoPyMFmR3H14dlg01QaaUZsa+Ikax1le4fA53ksFMQLgK
        KXLtCa7zF0nTLm7P2mPPnzq7fLpcjejN7isTM2ihpbOCvYFgWjBBfEarua5KIdE5
        Pl0sUfa7bp8J+MfhG923KrKxcHOZ1rN/03QbypnKNwYbFyu3uPaVrIPt5qqK0hL4
        Y0WLGzyC64VfvQpZPPheHi1xmgm4m3QGCPQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PM_ahXwrc37V for <linux-ide@vger.kernel.org>;
        Thu, 21 Apr 2022 16:41:58 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KkvFx5vHxz1Rvlx;
        Thu, 21 Apr 2022 16:41:57 -0700 (PDT)
Message-ID: <48a77e02-7eba-6361-7d89-534b9f03da14@opensource.wdc.com>
Date:   Fri, 22 Apr 2022 08:41:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ata: Make use of the helper function
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     cgel.zte@gmail.com, linus.walleij@linaro.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
References: <20220421084412.2615081-1-lv.ruyi@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220421084412.2615081-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/21/22 17:44, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> Use the devm_platform_ioremap_resource() helper instead of calling
> platform_get_resource() and devm_ioremap_resource() separately.Make the
> code simpler without functional changes.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

Applied to for-5.19. Thanks !

-- 
Damien Le Moal
Western Digital Research
