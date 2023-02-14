Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFDEC05027
	for <linux-ide@archiver.kernel.org>; Tue, 14 Feb 2023 09:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjBNJ2u (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Feb 2023 04:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjBNJ2g (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Feb 2023 04:28:36 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B921BCF
        for <linux-ide@vger.kernel.org>; Tue, 14 Feb 2023 01:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676366871; x=1707902871;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6Ckkp53UAyC9U2WznllXQH3WfWvQ+d2yQVlYyIbkiWU=;
  b=GXP4rMTs5wmeeR1uVlGekjObytmTwg5WwvaC4V97UEWxzY3gDkqAJhWC
   l7zPWRzVhQ+5l7X5uj8flSnLZ1bFukZsPiBc5gV3XJcnY42QQXV2JywDt
   hrrjIt7ceEl00PmANgfirzjBHyGAeBmqQ+tl7nWG04bz4xfWQaQWwy3Rl
   123dXmqW0hcnqnYjFecWgyimKYjT3YakyPSj2nTLQTH7RaSco7izJsdI1
   nEXCH3MMHiZwzdP64cOYZIHBcWqmb9jQ5UcBbt/jNJV4y5ZN/NTZ2hO5H
   8fCtjWkHIgARhm40CJvqnGs/GqZlmJLQMCDz9LTKGbNumj+zVTX+ns56k
   g==;
X-IronPort-AV: E=Sophos;i="5.97,296,1669046400"; 
   d="scan'208";a="228227568"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 17:27:10 +0800
IronPort-SDR: xOH9lo7x30RL8Bx0fff5tUfYuI7FdhWc4HbHS1XJGcd4V4Lh4szWb6oerT6bfVrobLXWEtDO0X
 /eq8BHG1VvSP4P3BwJh1RrwfjApPKvY2MhE2eYuBvL6xrqi/I2tO7G5mut9qFQ6XPElM8teFPy
 IGhIBlOJwX1I3taIcvg2Eau1dE+MgtGzspxkQ+gc39Fyc9thpTB67Djoqm+Uqj+atXqgtUXpiL
 oy5MFDjr5CratQvbkuBwSJEfuabQAZNI/hqgUmnsluH7gs2DJunu7dGDdLHhry1cxO+wCo6ZVB
 LTc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 00:44:18 -0800
IronPort-SDR: xON/v23tadDL5CIiz+1OQKRbU4nnmsT2zv/EfYRikL38+SZKj1+8TNIstkxADn/aMV2Gqdp1D9
 mqhpnJYrXdrMmPMCs26ts3f+GM/ccGtVwapmc3oTPhuKcFQfvOsRkxe4lEPFgImLayh6SQm5dt
 P0i6oeNu6NjQkAVUhqzHi1NgnIPY8+pr2QJSTOklr6U9rjYaXvThj2e7XJwaY4UIvbXt9VD3PP
 s0O3W/V/Z5aUINUk+yb6Bd8/TitQ2AZgp8jjTJR7/wcNN39tNEMKO2ryy8brRb9M+L86IFxQ5C
 k94=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 01:27:09 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGG7f0wBpz1RvTr
        for <linux-ide@vger.kernel.org>; Tue, 14 Feb 2023 01:27:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676366829; x=1678958830; bh=6Ckkp53UAyC9U2WznllXQH3WfWvQ+d2yQVl
        YyIbkiWU=; b=iV9yNS5ZYFVB7mzxp3NevnIeRSzx5l17oS4vccRmbxFVaQ4mGp0
        /tmY2xIRXPuciHRUIpZJIU4AkIYCTpMdornPtAgoyfbK5xF928VN7hRW13q1pInf
        tR4GMh6bNFoZ+Uz31UR9/8AHf3eyE0ru7jKZE7Et7p25HWd3Ob0pHO+oBRPcvyxB
        nMuN4RfgCyxU5Sq8gz4AxO1vwvABU9+/7A/O4ncn+m8+31+ZoA/6O9KszOqVplSZ
        cn53Whj6VyQAkdYO8jtvWdDXcmwr1qMrOZuGyslpIccO6lLQMPLQJ0Vk8rp+3qZp
        auBkb7bddZd+dJaSGLyrV8MLeCa32Gk4tAQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cNDWicdCGKad for <linux-ide@vger.kernel.org>;
        Tue, 14 Feb 2023 01:27:09 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGG7c312yz1RvLy;
        Tue, 14 Feb 2023 01:27:08 -0800 (PST)
Message-ID: <dafa3a1f-3661-72d3-6423-22e8399b333f@opensource.wdc.com>
Date:   Tue, 14 Feb 2023 18:27:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ata: pata_octeon_cf: drop kernel-doc notation
Content-Language: en-US
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-ide@vger.kernel.org
References: <20230213212549.29914-1-rdunlap@infradead.org>
 <51fb5b13-3e9c-785f-b96f-6f398389d434@gmail.com>
 <c67e4b38-7bec-0901-b13d-6390c1d51cd8@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <c67e4b38-7bec-0901-b13d-6390c1d51cd8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/14/23 17:35, Sergei Shtylyov wrote:
> On 2/14/23 11:33 AM, Sergei Shtylyov wrote:
>> Hello!
>>
>>    Hm, why didn't you CC me?
>>
>> On 2/14/23 12:25 AM, Randy Dunlap wrote:
>>
>>> Fix a slew of kernel-doc warnings in pata_octeon_cf.c by changing
>>> all "/**" comments to "/*" since they are not in kernel-doc format.
>>>
>>> Fixes: 3c929c6f5aa7 ("libata: New driver for OCTEON SOC Compact Flash interface (v7).")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Link: https://lore.kernel.org/all/202302101722.5O56RClE-lkp@intel.com/
>>> Cc: David Daney <ddaney@caviumnetworks.com>
>>> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>>> Cc: linux-ide@vger.kernel.org
>>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
>    Oops, replied from a wrong account... :-/
>    Damien, please let me know if you need this fixed...

Nope. That is fine. A review is a review :)
I can fix it with your usual email if you prefer though.


-- 
Damien Le Moal
Western Digital Research

