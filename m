Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A231C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 25 Mar 2022 07:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241746AbiCYHRp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 25 Mar 2022 03:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352993AbiCYHRo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 25 Mar 2022 03:17:44 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFABC74B5
        for <linux-ide@vger.kernel.org>; Fri, 25 Mar 2022 00:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648192566; x=1679728566;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eLLwiPKD2U0a683U2lfzB76IHku6idfYMN58fEhY/XU=;
  b=VG8Xf7jsu5kjWB3pd8FFEj1GVoZ5Wt5CNxPhAEiBwYLbAbYqOCyn9IUI
   +PaSMEnmtuW6oZ8ISuI4NAH/9TRDvR9N02PSyFuLNtLvsA+dNnfWN8FGi
   KJbwctGOIiniOwxHoayiJ5/r9xG864Nu1t/XBMCDB5kAPgWbAv5yW0FvM
   PuHD5CZsDbj+Ykw34845WsJtn8VLSZ4tO59mZVJK0Fcjb7ty43znY0TYy
   qVLvsY0nn1rq+p6Q5RSyPqnLXrSU+mZBBzY53ewiUCOsAhOPGhIUgsguC
   81407yhUvb0zhChIWVo+08e2FLuLDpbqgof3icgKyw4faGv1npxqCq/hu
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,209,1643644800"; 
   d="scan'208";a="197166603"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2022 15:16:05 +0800
IronPort-SDR: n5q6UnxUZp3rpuNZRy/SqZw2E+7pXxYttikh4e2xOwG0grdXV0jPKM3ZnQrmXgCKo4X6Dph7zF
 1Y5Ra0gk3nX6Job3Vsh6PJ067AMjhSAaJ1fVwpLPjM07k5X8HBKc1bpa35Z6+9xI8Uz4eAncJL
 Tfi31StyU6Ij3qApfsWVsHhyN59BW3abbqjgAySuMMMbok7FjmkGMK1zXNQTtU5fx5X/86lGC/
 DcrOueqRVoihFG4q7jkt4PpT55JEyPgFQAwSgg5rz+qvO1kEnvXffKxmpsUBmgrhrHXZVp04se
 BSJk9YdU/TS0d2GBEfEI5LlY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 23:47:00 -0700
IronPort-SDR: R8z65DHqAbhIUvKoquE/7gArUt/XCKs/8E0UAj7k5of8Lrfw6xv90ZInZ/Zmkg0wJf/BfS5yrx
 wuKZZuqfnx2x/gwPEZkG3kYRIfoyY4xDxa9JnVojX7MQYw7unIbTPZFDlUNjns8lM96vE5ZL2x
 9s2vm+cA8zGM9mzz8cEzxtN4Hi9QMiBFSEa5ZhDwcN1+l5y0nIRcdj3GVSnQyENcmzEMJYznNq
 bXwPTkMoftVYcUxzm3Hkbf8AuMNryK8l5TKXpwD/GWg2zxW+RbPq3QsedB+P9PCajVXry6ukRq
 wj4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 00:16:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KPtfs0Wx7z1SHwl
        for <linux-ide@vger.kernel.org>; Fri, 25 Mar 2022 00:16:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648192564; x=1650784565; bh=eLLwiPKD2U0a683U2lfzB76IHku6idfYMN5
        8fEhY/XU=; b=DZul3GmA5bTDGBOMYasg875ERJhp22LTXhgoIj1277MhZmoXKPi
        DSAWHJlGdTjGowRGeDHRAM/CxktY+3POK6eqRKKIieSwP1Bv7x0fGW7HWhgo72BM
        nRV6pcqeTl8H05onzdZT9CarpY9M4pQAyGN4ABHXjmueyOiFj/AKOvBUshqQI0ty
        l+Uae36qgEtekJnQmgL36zL++EQ7hn8S4X6wn/n4deq+ChhAAiePFEXfTeAX+6sY
        CCLyGYGkmYg1tSiia3kD0s0UpCyY37lOaF5uD0DUcnFT5LC4cBHGkDxBom4I5AmW
        XeksOcaG8+WthrEKNBaQW/QyR/xEA0TOSQQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id W7_freDTYsmn for <linux-ide@vger.kernel.org>;
        Fri, 25 Mar 2022 00:16:04 -0700 (PDT)
Received: from [10.89.85.67] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KPtfr2jpNz1Rvlx;
        Fri, 25 Mar 2022 00:16:04 -0700 (PDT)
Message-ID: <b67b1be6-1546-0a9a-5d05-2f11cc5c798b@opensource.wdc.com>
Date:   Fri, 25 Mar 2022 16:16:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] libata: CONFIG_ATA_SYSFS_COMPAT
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org
References: <20220324123204.61534-1-hare@suse.de>
 <20220324123204.61534-3-hare@suse.de>
 <e1e36f35-deee-1ec5-732b-575a68579610@opensource.wdc.com>
 <14a82e42-bf46-05fe-0e32-c6d5a3fd0e81@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <14a82e42-bf46-05fe-0e32-c6d5a3fd0e81@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/03/25 16:12, Hannes Reinecke wrote:
> On 3/25/22 04:01, Damien Le Moal wrote:
>> On 3/24/22 21:32, Hannes Reinecke wrote:
>>> Add a config option 'ATA_SYSFS_COMPAT' to create a compability
>>
>> s/compability/compatibility
>>
>>> 'ata' symlink in the PCI device sysfs directory.
>>
>> I am not yet convinced if this new config option is really necessary... 
>> We could create the symlink unconditionally, no ?
>>
> We could, but why?
> The sole point of the compat symlink is to preserve compability with 
> previous releases. But we don't really know if this compatility really 
> is required; I haven't seen any difference in behaviour with or without 
> the symlinks.
> By having a config option we make it clear that the symlinks will 
> eventually vanish.

OK. The default is "y" for now anyway, so it is safe.

> 
>> In any case, I would like to at least reduce the number of #ifdef. So 
>> what about something like this on top of your patch:
>>
> Sure. Will be doing so in the next round.
> 
> Cheers,
> 
> Hannes


-- 
Damien Le Moal
Western Digital Research
