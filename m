Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B87C6FD1C
	for <linux-ide@archiver.kernel.org>; Thu, 23 Mar 2023 03:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCWDgK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 22 Mar 2023 23:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjCWDgJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Mar 2023 23:36:09 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E064EE0
        for <linux-ide@vger.kernel.org>; Wed, 22 Mar 2023 20:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679542567; x=1711078567;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zJPbLxoP1pBf/mk3Bb605sEbphPqRHSwPTxsCBsywmE=;
  b=AV8hOD7Pl7oAKpvGRYBn6WE/bCvKDazDOmzKXR6nWgfHHexUBfrt5W38
   3gAcsXJzC6Mms1vuLBdg892t0g+pFEnb9wBwYR4PBGFDn8lB4aC8xRwaE
   TCfIw2CvTETA+XKRFMJ5hCrN7dAQXMgbaNBKCnd8c6O86558B1K1A2a30
   pvf3oIJD3XZ7yRwvU2x7MBmcTa7TqjfWxAe/N1GcTU7m734+VhUsmCgTe
   IsPYhEHJl9QmPVFcU4hWeXVxDlqUSge0j0sM8RJVY9wt0v/cOkrpl85Qn
   KcXiqiSrf4avQJkuKpRIvIQiG75AaOb5lhI1QualVyRwQimfKLkgB3Tc8
   g==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="338347095"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 11:36:07 +0800
IronPort-SDR: JLC+KZrpPAfHGogY7Os0komBGbdVy9uAFj9lFCzRKz61BkIGYaqU2KDFnduZFFo/rmO9BkPvHz
 0vXbDZTBk/q8LezQ+AbfOon8HkMxMmu06XOZRFG2r/u5yxLktcwnbtSNLnC73fAmuuqXYOc+W7
 AbCgARTI0ZAW1NOJnDYdv3Pyuu9iUD2E6duz7ZBEFzxbYfYa0v8dgsDla/+1Mt/Xog2C/Emt2Y
 DZLxWD2FX/smdNwz76WTtH2V3KTDEJ01zqJxoC5jqBggWWQxMMPOGAJfhWXz21EapfZFYFsbb7
 8ZQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 19:46:43 -0700
IronPort-SDR: teUO1ztkJGlpSI0cJJFHcaYAYj6LKmDVJ/xsawCOz5ZIoWwvK4VssWTjG5q1/iqiqmVtZLdK7Y
 A+Z6/mUxjEQz65n++xsO7Uoa8YchYvIpWgtR2SsAlkNqWgyepelTZ2tw8qE8s2NtA5tkFjaX6E
 ELjL0BXFBreNDolw2GdHhqAh4U3loMLaYIpJgL0kvKfG2yKiGg0ugOLbwnkOuTJ6STXA68jSQp
 SNeBAXEU5b69CNq/aZs2FCs7PO5/u2sFRuL9VYeRk7vCDYrzgU91bGKu22suRloVt2jxGU64kt
 66Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 20:36:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhrbV6cjFz1RtVn
        for <linux-ide@vger.kernel.org>; Wed, 22 Mar 2023 20:36:06 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679542566; x=1682134567; bh=zJPbLxoP1pBf/mk3Bb605sEbphPqRHSwPTx
        sCBsywmE=; b=o53779bWip6GSo7pfx0g1YtrTarkB4b9KbQ1NFES9gONSMoxnkA
        la32FvqcUoAeFcmH9xkS0rL/vo4g21V3lZBGIyqB0shA2zO8D2NUriEFYN4qWX0p
        /4cgC5yLQBkpo4uZLvhNaGlU2qpG72uIGWv0NhOkoI8RQOzHRg0XciqVrX9N788I
        8V9n9T7qj8OBSu+Id1QqLaj3hUOeY+2PJacgrqkZx7oBnNJxcGchXVwXAUiSwm4Z
        BgASrR0YPC9AC5KG9cvvEeb8S1DpVW15WKo0pF5YOPxUJ3Ce7ZpNoz7wXTHtfuEw
        rwiA/1HH/dLT32rISVaT29ZsiYG5VNBZi4g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CSxeCZnG2y3A for <linux-ide@vger.kernel.org>;
        Wed, 22 Mar 2023 20:36:06 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhrbT1jJmz1RtVm;
        Wed, 22 Mar 2023 20:36:05 -0700 (PDT)
Message-ID: <58c264dc-cea9-7bd5-cf3c-43ec5131cedc@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 12:36:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 00/32] pata_parport-bpck6: rework bpck6 protocol driver
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org
References: <20230307224627.28011-1-linux@zary.sk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230307224627.28011-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/8/23 07:45, Ondrej Zary wrote:
> This patch series simplifies bpck6 code, removing ppc6lnx.c file to match
> the simplicity of other protocol drivers. It also converts the direct
> port I/O access to paraport access functions. This conversion revealed that
> there's no 8-bit and 16-bit EPP support in parport_pc so patch 11 implements
> that.
> 
> Tested with Backpack CD-RW 222011 and CD-RW 19350.

I applied this series to for-6.4. The code style in some places is far from
ideal. So follow up cleaning would be nice.

I also noticed a couple of issues that I fixed locally. Sending patches for them.

-- 
Damien Le Moal
Western Digital Research

