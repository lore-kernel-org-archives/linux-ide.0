Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6152CC6FD19
	for <linux-ide@archiver.kernel.org>; Thu, 16 Mar 2023 07:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCPHxQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 16 Mar 2023 03:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCPHxP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 16 Mar 2023 03:53:15 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52161EB48
        for <linux-ide@vger.kernel.org>; Thu, 16 Mar 2023 00:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678953193; x=1710489193;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RXkfFrZ4cJbq5mA2q725lauWqEHcqyRQeVT3Aao/9Qw=;
  b=B+UddsAzbSWBoGvnXjs2uMRStuMCwk1xFTd7Etjj2n6NeqIiWPFYlk50
   tc+8Veq+X2QIxe6QddGvHlBA1BxIUpSmDbOC1F6owVNrsnmZ/3R+4AOyz
   hDv1IOZnzYC4sF+DW3zuLSRrocotG4TbVmdRw4MZopqpoG4MAkeahYUJc
   SAcgPEB4A+TDA3CwI7MBUjENEIX0b3OOypaMPapz+RSQMIedtt/7ID6T/
   8X7RtGdQK4cfCAKyPGM7Opf7u5eEVka+jDW/sR/2+mZajMqpBcPTtU6IP
   ggQzFWn1dW9en71ycC+xOSP3ZS82POxA29IzLC3V+wUUadyZNkeLhOUmR
   A==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673884800"; 
   d="scan'208";a="330149599"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2023 15:53:12 +0800
IronPort-SDR: 522q5AbiSuLP+ZIje4gMFOloepqKQ7lOIBHvexq2gu4P/G+Fx4pQ97bI3MP3XE0p17Mzs0R5sU
 qtddmQve1GwuUq1nJJsnLmxE4+SkOtJJjwlLcsKYosHn+QyOjHSIkEDL3IxTM0rhFmfnqmRtxn
 l3D0db19VF9CP/OyTiHLMDhWS0vUpoKo1b9EscjBoO6S6gNv7nZpqSqM6FGKdxAcbvlDTV1xOt
 npCOEh++jhHFbD0p5ABuZR6518W0gMMob5QmW+03QPr/NF8mzI6BZuKNJnkArHStArBwA3sncu
 0Cc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Mar 2023 00:09:38 -0700
IronPort-SDR: QDOXPGjhP4CSnORVBIadoWXQeDWllJLg9whQy6tiuKJqusHo4T1Fv0VxjgewVFZR1Sauq4TYcm
 90nCixkBQxYjoNpW3L38KvI+pQjMnpamgIpcxUAy1IfW2/K4KMgknMVsD1QBa06v+QxWZxDhFg
 4t217T51K5IEu1QmP7BvjyZVe0hitw1eeTRSl6EuuEupK2On1IEoad/bCEk0o/ft6aqYjx8Z9C
 KefwBFksiU6XMRcUnVKNDAWemhr5/AfAOKOICTadbrSzSM5aQfts3hApj7R5OSK/EHzuK4dFl5
 bOs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Mar 2023 00:53:13 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PcfdN13Nkz1RtVp
        for <linux-ide@vger.kernel.org>; Thu, 16 Mar 2023 00:53:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678953191; x=1681545192; bh=RXkfFrZ4cJbq5mA2q725lauWqEHcqyRQeVT
        3Aao/9Qw=; b=DIG7KAu3wMdekvKQcingmQSqSs4fueFQoXvHqyjox234L/dSEnJ
        4ApWYRt8E95IJUM6s0FrJ3iaS3St6PDKFc23HG6ahIqPYxx+WxstlEP5ggyGV/yG
        1rp1+qakICc9f6hSIjtmUzsmdhTgOW4Z9h8JxwdX68o30/lBodQMLk9ihQxIXwUT
        qGXw96CHc9jZKm45oGYMNNLPZRkuEYo+un5hoVOsPrzOlQqy8xMP01cuPTSM6Unr
        REmnZ1r8YbKxu7bryo72OF18xSxKuJKYJr9rGAtIxCigoUoDkq3mQnSgBCpFN6AR
        582oCAHYbUImHrPQjuPJnqp1zGJPWCXS/cQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id d8wekahMB-WI for <linux-ide@vger.kernel.org>;
        Thu, 16 Mar 2023 00:53:11 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PcfdL2lflz1RtVm;
        Thu, 16 Mar 2023 00:53:10 -0700 (PDT)
Message-ID: <2fa6c8ec-c25f-5338-ac78-eee422935ab8@opensource.wdc.com>
Date:   Thu, 16 Mar 2023 16:53:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] pata_parport: fix memory leaks
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cf8c7b34-3c5d-2b9e-b410-d83f4af7274a@opensource.wdc.com>
 <20230314225805.9124-1-linux@zary.sk>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230314225805.9124-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/15/23 07:58, Ondrej Zary wrote:
> When ida_alloc() fails, "pi" is not freed although the misleading
> comment says otherwise.
> Move the ida_alloc() call up so we really don't have to free "pi" in
> case of ida_alloc() failure.
> 
> Also move ida_free() call from pi_remove_one() to
> pata_parport_dev_release(). It was dereferencing already freed dev
> pointer.
> 
> Testing revealed leak even in non-failure case which was tracked down
> to missing put_device() call after bus_find_device_by_name(). As a
> result, pata_parport_dev_release() was never called.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202303111822.IHNchbkp-lkp@intel.com/
> Signed-off-by: Ondrej Zary <linux@zary.sk>

Applied to for-6.3-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research

