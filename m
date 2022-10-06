Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8899AC433FE
	for <linux-ide@archiver.kernel.org>; Thu,  6 Oct 2022 08:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiJFInR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 6 Oct 2022 04:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiJFInQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2022 04:43:16 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B064294134
        for <linux-ide@vger.kernel.org>; Thu,  6 Oct 2022 01:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665045795; x=1696581795;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FcJkuxesVv/tbGFvODo0PePW/pFVpB+iYt9q3UH3uY4=;
  b=cAWeQD6OFFa/Yzq1x0SzhS8KN9enIsedaaQv9UrL05Z5tYKhXXXnpF85
   vMzyRQDQU+k65WoHnNtoOb1aDkrJWE5MK+eZIPpOpiUn4tkc/MtXYgc3a
   1RzWLCiR4IR5yJsEUupQRrCOhNHhaXCgs8c/U/zzsS8FHamSVbwAWQ4AT
   8BJHpOGN25W0/TwKe8btE241CpUATAiruMCxsrz6z/jMn96IeIwoITeQK
   oEpYo5OWKIQSNKZREaD4NeyXOiP2xpCTTExoIWdBLGV4OjyQtmWelzOYa
   THZVymc1Rvq70meRCi2jIJ7ZXlLD/Y8VLxiJb5icIsUGsK0QZm+2gJCLB
   g==;
X-IronPort-AV: E=Sophos;i="5.95,163,1661788800"; 
   d="scan'208";a="218298452"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2022 16:43:14 +0800
IronPort-SDR: +2RyoNeVgLiXRBm+lOFn1akmICPXUm1I6e1oJ0KWhCrUHhOK1+KrQPKc6ImBJKCK1uAqThWgm3
 VmUotrKGGzorMy3az7EJXYS0gKp5V5SiBKLrwHu0bHaLwYZljcwB4Ard1h1nkSZJiqIo+VlM4M
 2G2EAEbls/uCCPoNYrWqtwTiLYNd1Q/UxfBElOcDU2ZhQ3tBhkG79Qge6ny/A/7c5Wl9J7kxO+
 ISNJ1d1Nbx5oJzD9bSgM3TkHowntSSN9OFJLoVxmGpqIvsXkINGRJ9NM3oFgsQHywKaJcmT7vD
 M5F23K4uGDHHwbJQ7zaaWpKD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2022 00:57:25 -0700
IronPort-SDR: vivICvZXiptkHbvsPsUHevpTj/XQYtRVlV+ygpNB7l9xonr+PJK9wIp2o+1cqNp5eOoZtP/5xn
 JP9kVF3GUZcT0XJ7JFfTPg7gan4FdJpd+r1y34s7th3duuh1bT9M35c7xLHynyzhDHOMLxEraM
 ET/fzL4r97dzGzDYE9LKz5YYvrYdC9GbHXrgIuP4JzK7WDTwQQEpwy81fbHf06snCzy640H3TQ
 maEIeeTs0KheMtYUnUAQoNg8Qjg9PIF57XaHzt2Vni1LJlZ/MuI/RGjKS+Ev7he9g0YgiMsp4K
 c2I=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2022 01:43:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MjlMQ0VgFz1Rwrq
        for <linux-ide@vger.kernel.org>; Thu,  6 Oct 2022 01:43:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665045793; x=1667637794; bh=FcJkuxesVv/tbGFvODo0PePW/pFVpB+iYt9
        q3UH3uY4=; b=kK06tU19qQYS1x95KNebaAMqA4jVkFqIu4ed/S+Wdkl1BXHGD9k
        9WCGeHaqTS/CjLQwVpLmwoCUaDDKF2DbP+Kku65XRdARPIKnFBKvZ62Jh4GW8sN0
        sQkAfOaW9J1+6Gvqy1VIg4TT2Ed5T+qt12xkUpZjz9bAEYpBNhZrsAkkDgfW983V
        gqrYXmErqHXJlbzjzoHCTm8Wyujb2BWstU5OAnvSfSSGxy/15qcy5vxiAKkF7NEs
        o91sakrcjGxq2nd9CGZuNRcb5W4WY6xCgGsjYzadrtJymiVBE6ZHOU2VVnF99q/g
        EGz6vm6gpb8VcF8Y4Z2UZDHPHvzK5sPfM1w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wvdVZN0yuhdO for <linux-ide@vger.kernel.org>;
        Thu,  6 Oct 2022 01:43:13 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MjlMP05wrz1RvTp;
        Thu,  6 Oct 2022 01:43:12 -0700 (PDT)
Message-ID: <80583d1d-4434-bd33-5fc7-7e72037e1ed4@opensource.wdc.com>
Date:   Thu, 6 Oct 2022 17:43:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] ata: pata_mpc52xx: Replace NO_IRQ by 0
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <a8c87c6d8dd6d9e57c515036a333ff89fc56bcbf.1665033366.git.christophe.leroy@csgroup.eu>
 <3a89c963-df7c-8fac-7213-d37c1b04f864@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <3a89c963-df7c-8fac-7213-d37c1b04f864@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/6/22 17:37, Sergey Shtylyov wrote:
> Hello!
> 
>    Perhaps s/by/with/ in the subject?

I can fix that when applying.

> 
> On 10/6/22 8:17 AM, Christophe Leroy wrote:
> 
>> NO_IRQ is used to check the return of irq_of_parse_and_map().
>>
>> On some architecture NO_IRQ is 0, on other architectures it is -1.
>>
>> irq_of_parse_and_map() returns 0 on error, independent of NO_IRQ.
>>
>> So use 0 instead of using NO_IRQ.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> [...]
> 
> MBR, Sergey

-- 
Damien Le Moal
Western Digital Research

