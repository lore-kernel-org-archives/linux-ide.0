Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2B1C636D4
	for <linux-ide@archiver.kernel.org>; Tue, 14 Feb 2023 03:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjBND3R (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Feb 2023 22:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBND3Q (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Feb 2023 22:29:16 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF0A17CDF
        for <linux-ide@vger.kernel.org>; Mon, 13 Feb 2023 19:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676345355; x=1707881355;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BuoAC+qEMmR3CjmH12htgWfOLvyg89Oblgx670snAuY=;
  b=rbillNz/ljmA5Z+GSm70S3fe621fqYAQ9o5f+UEyehn/YTxwadkxGEAC
   VynGwOQbaMxXrwS9+CuXpw7ZhMJm0aZ+RwKju7OeMEHVnuj1VXH0Ek1le
   TphyVkjqCNI7UkMFNlfCMMYqrjdHN6xnZaPx9IN7EyW9BYoWfQp+lFFDF
   S1wajqYrMH99i5dZHMpeBJG+q9x9TDQ0F+orYp5pbtJeMqfsTe20fxUy6
   FWxSCNB5dzflgLTWwlKz9TzQsOAlHnAQrMFLia8RSYUNT6eEO8649yqAn
   nsY0la0SybZpzw/uIvlRVYbegjbMAtZkvSh82PkyHW8wQjauzaqs/rvSd
   g==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669046400"; 
   d="scan'208";a="335201562"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 11:29:14 +0800
IronPort-SDR: 9tkQJpZVbjsM0NfGNS+e8t1NIh2kdjPsycBAyc/cvaEAHxjOb4aIC2La+vDYoBOWDcPIAWObEC
 wbPv7J9zZ8S1NbjNLFqyFK92n2NFvxdjz4H08mX7N+QNTapeWolY70jYNapudzu+VLMKDhjj4e
 dcaCR5Y7zg+Vw7HfeXHauLg3JGMb894DlvHJ0laGBLY0tHTipv4t5iUiuaDRjj2iON4owiYygI
 GYWpxN9ioIuD/t4na6TTp2Ep8aHZfVvdHRKMfZ/ctPpGMEAyDwU051kUw5PO1ut21k7ZQhiZBq
 AlU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 18:46:22 -0800
IronPort-SDR: wGL3GepQKtwdHWq7igkCCols8NFWhbMND+XMoPpA5+Y1f9zakqxA0PmCsjP/C/zhxtj8fHRVpY
 HqPve1FquMGTbeq4LnWMERkzlOZL39FcT76r+rj9hBfNHA7YY2CgS5GuQYDceyOyG8JWstq01P
 QkYTuFOL5pOO7L+TuTASBr8spzfAp0PaeEqers/uISVwM0fYGyJouGgAUrcWfIXWzoJNJZswaC
 NH5GTxF8VyZMNelvFBlmbAOMLm7vtMSNa+zZu+lE3a2xe0OTcRIrYnrGS1q8Ryzkz1bAloPUvG
 LCU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 19:29:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PG6Bf0mQ0z1Rwrq
        for <linux-ide@vger.kernel.org>; Mon, 13 Feb 2023 19:29:14 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676345353; x=1678937354; bh=BuoAC+qEMmR3CjmH12htgWfOLvyg89Oblgx
        670snAuY=; b=uWWsdQ4wpDa7GFWu9TnZ82/w3oxW3oLX9CQRi+yF3TSHq/07XzW
        M0G0Rv0Y9PqbN/D899p7wN5G2vAJe6JBKLsWGzDiKtTBDwE3s0i7mFBR1i7wZYGJ
        Lwy3ZL1PoCfhkosehSwOiatYMogcebYIMt5qxqOmsdnrrxDuUa8m1AQ0+rnLExW4
        sY6/6Eze8NP5iXFV0yici9iUQJoKIbFcojItI0Bee7fQoi3Zp69mmkfIDK0vNAC1
        wHK7vnJPNoI69bgaLv4AJtMKr7X5f8qYxU8MT+G+XmG35x2L4PYA2jCPynm6pPBj
        5zoJVZnZqfE6q7Xk7WtASz/+pqqqbVNmf+Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hne4tvul44YR for <linux-ide@vger.kernel.org>;
        Mon, 13 Feb 2023 19:29:13 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PG6Bc4XSkz1RvLy;
        Mon, 13 Feb 2023 19:29:12 -0800 (PST)
Message-ID: <86c6d901-2dc6-7b3c-c72d-effb7f08b12b@opensource.wdc.com>
Date:   Tue, 14 Feb 2023 12:29:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ata: pata_octeon_cf: drop kernel-doc notation
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-ide@vger.kernel.org
References: <20230213212549.29914-1-rdunlap@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230213212549.29914-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/14/23 06:25, Randy Dunlap wrote:
> Fix a slew of kernel-doc warnings in pata_octeon_cf.c by changing
> all "/**" comments to "/*" since they are not in kernel-doc format.
> 
> Fixes: 3c929c6f5aa7 ("libata: New driver for OCTEON SOC Compact Flash interface (v7).")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/all/202302101722.5O56RClE-lkp@intel.com/
> Cc: David Daney <ddaney@caviumnetworks.com>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-ide@vger.kernel.org

Applied to for-6.2-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research

