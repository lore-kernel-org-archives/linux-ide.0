Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67E0C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 21 Feb 2022 00:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbiBUAIb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 20 Feb 2022 19:08:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245369AbiBUAIb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 20 Feb 2022 19:08:31 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB3341F99
        for <linux-ide@vger.kernel.org>; Sun, 20 Feb 2022 16:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645402089; x=1676938089;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=INQ4qjmKgxlG3LlT2P+TAJjjJ12/Pdm1j/xRYnXsrKQ=;
  b=gk1ZmMZSf1HLD4MVcX5cZSKWDptMiacp2n8F+ZHBbt24e7QjjIHq26xi
   LlYaPWMtPLbsqUHQSPJHxIlBe0mxrb1kVcJK4v5wliNnv72caAhyTczlF
   SoslGxr55RtpdyTZLh+KK9NhRuydosSoH2LPGV+9eqnkRR+uf1XMivShp
   qPj/APmDSINV/Lo+7cTuzOFz5Dt1Fbr6abxtwix4hsPI9X6gb9Ho1pfj4
   b4oPYiwk2ochwj/vHlnYL0kVEk7UG+TgSblFFxp8xNYYSPEd43uwoe5yZ
   Ci2M2UiRUFueZJ6/u6dlzdjqgNcq6fJ+t374N25dufFFEPRna7a/Nd64Y
   g==;
X-IronPort-AV: E=Sophos;i="5.88,384,1635177600"; 
   d="scan'208";a="192401835"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2022 08:08:08 +0800
IronPort-SDR: uSDjg3C4IfiQmws4E91weOUPR3kYUJ25btq3JSH742btQ3IRSLDpsOeyMxi5OfHWq0gnat48nS
 0Z82BdHFCMqKpHq4g7erSk1G/XXnN31rfSl8qNZmh3XzNeRawakrIaOtxIyJ6apJyuNAmGszFm
 T7gHyPztG12EG9G09YmBX9/7gxmXfIlwYgn1vFNp8ADSYBVfn9Chk5wMYGz0gNMNVGnIKoBsy3
 EDl8H0hq8nUsDamb9N4/B2RAwRS53urefTFsbjurnNUdt5v2uxsjN5LaogLGcY9X7Y1g+ek57Q
 XFvPjfk9NfrLXN7nb//yiLiS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 15:39:42 -0800
IronPort-SDR: pN3K9PiSC6dEKrunZl5q/xqXLuEKWKzK48Daq+XccYWmDW/g0Akd6j3+rCQZlY8+e4mthFomO1
 mpt8O3dCGcVpNA8qjTHpMuAiN5f9lcpcnQSD0JW2YbZFaJj2XV7h3ku0zi9p5B+hubaz4HXy75
 envw2BP8eodBLHnSzC9cp2c+o2tcv8+5we9N54oXEuYDye+XVc/Sw7m0Ff0En8CyNkdGT6tXnr
 D4BfMuqaOCXD5foeAzoLTm4EtrkqvdiHiGoe+pQTrTsrpKkfgF9fSAwyfaX9t5pTEW3n2mQMbP
 Lbw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 16:08:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K22gr1g5Fz1Rwrw
        for <linux-ide@vger.kernel.org>; Sun, 20 Feb 2022 16:08:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645402087; x=1647994088; bh=INQ4qjmKgxlG3LlT2P+TAJjjJ12/Pdm1j/x
        RYnXsrKQ=; b=l7oufEhmQhERXHXWlKOj9igG2/sm5i6Ko+KYhqjkyx3qsY6W9rG
        KfAcSR3wzKCsy8Q+YMyTlIeSH5hbhgzm70yRrLdSWZ3sn9MlDgiswTDg4qXuBYSP
        YAkwmE0mt63FhkjbPrFCd755HdqU6ZY99jbNiex7/FnasYpNcymZBklkTJPj+0oH
        K9b6NF+H8jIy5b61ucwXOpeSZYLsYIW5JNk0Jckpksi8iLYcIEYfBa/i9p944MPO
        k7rBiGfROGWdKBcm+4kZ4J4GoGKUjnzjcB8Q/f9YgUOWLWs0KBh5dXBvRur6FgSk
        22umAJ4OnVwfQKkkY8g6zE2ZV+lFBtsyZJA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oiASHh_vx-fo for <linux-ide@vger.kernel.org>;
        Sun, 20 Feb 2022 16:08:07 -0800 (PST)
Received: from [10.89.87.236] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.87.236])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K22gq4St3z1Rvlx;
        Sun, 20 Feb 2022 16:08:07 -0800 (PST)
Message-ID: <bb1a9512-202c-f04d-a86f-232a013f0fa1@opensource.wdc.com>
Date:   Mon, 21 Feb 2022 09:08:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH] ata: pata_hpt37x: fix PCI clock detection
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <02715925-4a0f-30dd-86b8-85786cf6484a@omp.ru>
 <9b5390aa-cd68-9b59-928a-c98e5de1a9e2@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <9b5390aa-cd68-9b59-928a-c98e5de1a9e2@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/02/21 2:19, Sergey Shtylyov wrote:
> On 2/19/22 11:04 PM, Sergey Shtylyov wrote:
> 
>> The f_CNT register (at the PCI config. address 0x78) is 16-bit, not 8-bit!
>> The bug was there from the very srart... :-(
> 
>    Start! :-)
>    Damien, maybe this description is too terse? I can try to be more explanatory...

I think it is clear enough.

> 
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> Cc: stable@vger.kernel.org
> 
> [...]
> 
> MBR, Sergey
> 


-- 
Damien Le Moal
Western Digital Research
