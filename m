Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED87FC433EF
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jun 2022 23:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiFSXPh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 19 Jun 2022 19:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiFSXPh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 19 Jun 2022 19:15:37 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF436170
        for <linux-ide@vger.kernel.org>; Sun, 19 Jun 2022 16:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655680536; x=1687216536;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=gwpnJwpjwbNWS6M/sJrs1yPFrFKwNFi8+3yrb0GjKkg=;
  b=h9zUaQUmvTddo40BA39PSQCc0ULokJHwx75HGsVkEimRWqVHqMQyoUHx
   GaqMP8MH6Nk1pIuKDKF3GBjId7Cp7MEBC1ltQgDNzG1LbgjoiiOnT2+WH
   Q/V3cRmoVzAAaFBjeJC2olrlIEauQTKwwGNzWGOGlWok5ErHmws8iF3gZ
   5gXHPckhkwSZjFh40JYgQzg2N1TTA9QklOXDGotSAwzzV/1wkQyJt2tEv
   3IouMrLlbC6VIdDgMoPU1AbATYb0Av630VJrc4jD+shg5D0u/M9VqAJsS
   CLXUxw3InJ+zBOm/MHt3lqvlGBG4ZCSUb/pUHabiG7yDItcjiFhl75DLg
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="307887336"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 07:15:35 +0800
IronPort-SDR: pma6jd/ssXInGXiz9vDa4t621JAGSdh2B/qc+i/n6BAgoxBWwo5HFwcCd5tkzgFvCEOLhYm0+i
 mi/YouVGZzKexuW6/6mtAK2UDnPmi4AqYh0uN08Tsu+6j7lS0Iyq8yezuuBpBwHudPU/m6wIxn
 P2Tg+/TgzI7PEHGP/aYfdYFQmA5+ZkOiWJmuCXAHvm3Wr6iJBdDTDLLI2qwPGvDEIumxuLhTKQ
 T2xDVcz69NFQl3ft4TtjPzykW/UrGw5895NqXMdK2DZM9Cd4uKdUvoWPiOdlUhAM34FL6NxvGW
 TbqpnWZBpoKNKI7to0vG6VSE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 15:33:44 -0700
IronPort-SDR: tKQU4ho586Jw9TNBf0EtFB9mWP/iBkR8zDegQPTZxMUC4mWS1Tjle5n/gB35pO3XAYgS2YrR0b
 JfSA0pj/BpVONDE9geOfhAMVBUXfl9M5wGd3BdllMC77nYohTPrxlVLB8v4JZLRddyP/lDO3Fv
 GfA3gMTI5nL0Pzwg4Rhr/VJ/Z87Bhmy76Rerx+bqs+aIfqqRM94YOeojC3ZtqwM1uAoHRfPCSh
 uMrzp2R7O5+xR5stPwCnFMx3Jbb/FnhuRRkFf20VabvMkKdtb19q0wogpapeYNl26ZBzYp7X51
 NZ8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 16:15:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LR7tG59bcz1Rvlx
        for <linux-ide@vger.kernel.org>; Sun, 19 Jun 2022 16:15:34 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655680534; x=1658272535; bh=gwpnJwpjwbNWS6M/sJrs1yPFrFKwNFi8+3y
        rb0GjKkg=; b=Dv7ED4VGhlWg0etQqiUIlfgQFRjkeACGaQko4uqjQwIuaoBBCOX
        yf9Ta5i1aEJ4hYnCNj0440bWuyVcDJ0jvy43B6v6qkSa5FgkvsUaZHGfqsgunIle
        6J9Cc5ulOfYb4Pr+jkaQW+WXg1hVjyMKqIK/wUK4aGXRSszzoxLnfPbipFq+SB2l
        itGfxvPtdOskAmiYU8WZxp0ptCACt/MLS4yCxUWD580GNqCFBR9vcdVAhescnIvL
        IYyBFVaoZdS8+bY2+IjEX1HavV7CgrQaHVVSP8dUrsIQzDxiSRbTqrTtmeWxY2WE
        ydh8kUSsfUKIy7IrG0gmrX1Piy3uoR0BEdQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aTX_7RizNiNo for <linux-ide@vger.kernel.org>;
        Sun, 19 Jun 2022 16:15:34 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LR7tF59w4z1Rvlc;
        Sun, 19 Jun 2022 16:15:33 -0700 (PDT)
Message-ID: <82798f42-1a11-db2a-c5c6-3fec6c0a627f@opensource.wdc.com>
Date:   Mon, 20 Jun 2022 08:15:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] ata: libata-eh: fix sloppy result type of
 ata_eh_nr_in_flight()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220616205149.16157-1-s.shtylyov@omp.ru>
 <20220616205149.16157-2-s.shtylyov@omp.ru>
 <2c352e63-e946-a1bc-77c4-4579e6f01854@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <2c352e63-e946-a1bc-77c4-4579e6f01854@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/18/22 03:16, Sergey Shtylyov wrote:
> On 6/16/22 11:51 PM, Sergey Shtylyov wrote:
> 
>> ata_eh_nr_in_flight() counts the # of the active tagged commands and thus
>> cannot return a negative value but the result type is nevertheless *int*;
>> switching it to *unsigned int* (along with the local variables receiving
>> the function's result) helps avoiding the sign extension instructions when
>> comparing with or assigning to *unsigned long *ata_port::fastdrain_cnt and
> 
>    Grr, a typo! Should have been *unsigned long* ata_port::fastdrain_cnt...
> Damien, coyld you please fix it?

OK. Note: please stop using markdown stuff like *xxx*. That is not useful
and that will avoid this kind of typos.

> 
>> thus results in a more compact 64-bit code...
>>
>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>> analysis tool.
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
