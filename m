Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96782C64EC4
	for <linux-ide@archiver.kernel.org>; Wed,  8 Mar 2023 08:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjCHItg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Mar 2023 03:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjCHItZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Mar 2023 03:49:25 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFC798E98
        for <linux-ide@vger.kernel.org>; Wed,  8 Mar 2023 00:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678265354; x=1709801354;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=x1g6KQIf6mq6mxi3VGvVhexXGqywvU+LYyvu/s+U7WE=;
  b=aeTMr8tpqTZnhx5iePOWTuRLp3hj34dFXeLM3679lRElDtTpjSprtqOa
   JVKvNrWFJW7if43sOyquVJMx9+C9N4ExpH3HoI4Rv7JBjmjKDQioQyvjf
   8zGACfP21bVWMRAoKJZluDayCw0A8aG4cVbfsLVmwrARexyn6qK5/P+Wi
   hSBvh3Llqu0K0mXSeu998HBoS3Z2V57kiZeRHb4Or/z/h9PcD6clUuKGy
   bC4asdFPxUokyiNxxvcAw2jflJxuAIkxTq3IdjeFEy1IKW1hROpqGynmY
   Nhkg+1bcV7VP5kvU3iUX9vlDWVbjQOIL5ACojgbpaNWAb1TThxse33fOi
   A==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="329448361"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 16:49:13 +0800
IronPort-SDR: cbsvrnjVYPVQAq18iWa/zTlX4LcGZr/blmzFrkezWV+2huqVzWXPUtCr5bQQwzf3ZI9kiG8cAp
 pwpgjYJyjP40oPboToDiSGggO3EuY3j5RjjiPTT/s6Wvo6b/AVOYel7jF9mobiX6vhxe2XxK8k
 /e0sGiDDDhFr1JMIxZzHIQpnJ/x8bYhc01xajPd7aPW61zBcSXQDq+GryxPQHI+Cc+/TVRkjeI
 BWU4WKiBYgdqnJ6jQYPE99WARvPgT0eN0ZiFDBNx20S5trILmrQ13q7dc291ZG488cTr0zPqux
 y9s=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:00:10 -0800
IronPort-SDR: gTY3souY+n7LogTGLgT6s9Tgf4zGT2eO9MYCl/eGVSQVaP1nRWMPA9IeP8xuLa5/kw+qjUBn+9
 Nfzg6d0u2h4MV2WHw7eQnb2CxY4kN2tIQgBM0N1OqnKeaQXbqAuPJ5b0DaQLKGhQn2mhlG/bR/
 O9nxa6+UnmImg+lcHiAjStmxakc19XCKBoF7OV1DlCjSLBH5k7l7UWEu3zr20MivRZg0RXWYip
 0F3IaNNT2e7yUYrIu/A0FMTdmsXK/bB1wZDYjFKA0SeOQlNAnlZxBgzzoBWFQYycGe+/UnpOAP
 +BY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:49:13 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmFh6g0Nz1RvTp
        for <linux-ide@vger.kernel.org>; Wed,  8 Mar 2023 00:49:12 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678265352; x=1680857353; bh=x1g6KQIf6mq6mxi3VGvVhexXGqywvU+LYyv
        u/s+U7WE=; b=j/EpUggPR15Od6yyAzFKA2fM+z1HeVVKuYOgmG5NA8MxfoJor0q
        0qoxI0GLxS+fZDWiy6+HfCZEpzDiRFErKrd67bbuXRrgqxW7HG0T5VeItOC5W4cq
        xCnuU8zrazUBC4GNmhDcsV1PSin0Q/37hPcMDG9jaSIHbRPAQvHFDNvCg7dhjBJ2
        jo3Ir0pT4nihN4B7rmliCis9F+OI2pmG33ZMSf6ruscvxb9wIhATAijD9Jgtlanm
        ygdR3J7DHgx1x7TYryqupDe+L7hNRMkxAC8NvJLX9jfzPw0i5ZMSYho2MsCBi1H+
        37ArJXpsjH0xClOqXbZDAdVw3lMXPsJwIDg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id b31TSBzU4D0S for <linux-ide@vger.kernel.org>;
        Wed,  8 Mar 2023 00:49:12 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmFh24GCz1RvLy;
        Wed,  8 Mar 2023 00:49:12 -0800 (PST)
Message-ID: <34737e2c-2f2d-edf2-5afd-1228a3e8c647@opensource.wdc.com>
Date:   Wed, 8 Mar 2023 17:49:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/2] Drop unused helpers from <linux/ata.h>
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20230224204024.9982-1-s.shtylyov@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230224204024.9982-1-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/25/23 05:40, Sergey Shtylyov wrote:
> Here are 2 patches against the 'for-next' branch of Damien Le Moal's
> 'libata.git' repo.
> 
> All the functions moved from drivers/ide/ (with a rename) to <linux/ata.h>
> by Bart Z. (back then drivers/ide/ maintainer) never saw any use except by
> drivers/ide/ -- thus, when it was removed from the kernel, these functions
> became unused; 3 of them have been dropped by Niklas Cassel, and now I am
> dropping 2 remaining functions...
> 
> Sergey Shtylyov (2):
>   ata: drop unused ata_id_to_hd_driveid()
>   ata: drop unused ata_id_is_lba_capacity_ok()
> 
>  include/linux/ata.h | 71 ---------------------------------------------
>  1 file changed, 71 deletions(-)
> 

Applied to for-6.4. Thanks !

-- 
Damien Le Moal
Western Digital Research

