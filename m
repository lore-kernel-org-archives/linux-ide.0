Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E868C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 28 Mar 2022 09:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbiC1Jpj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 28 Mar 2022 05:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiC1Jpi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Mar 2022 05:45:38 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A411EC76
        for <linux-ide@vger.kernel.org>; Mon, 28 Mar 2022 02:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648460637; x=1679996637;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4R1u0oMa67AUaqyCL1Ybnb0EqSnlxEykfKbXBCUGAhA=;
  b=NcfuJbjnjsVvQ3XnDg6Znk6WYyYVHC/ct9mp0V3hL7jhBK5eSJJrXMNk
   iArW9v7M0wtuWpEnoBMVRRMq66XPNIAb5jU4aqn/zJOkcF90+H/FbBdNV
   BymWJla+f9NqeJRQR0yu+DHJCD6lrqsdbATO6XIHlGApzo9VbepyDGWyb
   e8JmthhEJOXteb+me2vjFV+gO7EkB1bGZjEUuo3AjBQeN24eZxEipAW5X
   SuBHbdF46XK5W5VepUROblfJuECOkDco7VsXZPw2sxzxU7GIuyj18nJSC
   pTriWY8LRcrORdXHf7acyPgxM3qoM4AHPDX++gxRcYjLtC/HguN7Ti0ku
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,217,1643644800"; 
   d="scan'208";a="300579957"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2022 17:43:56 +0800
IronPort-SDR: IA1IKKpNPAeevRk1Dh8aPnAn1vfWVFhrxivsYe+PJQAs+BL1rsR1InZtB5Tq3M5M+12Rj4Cb4q
 tpOl7w6gDImsEsojanaMZKk5+OLHIZz0MWMsWnCC5hJjOsxJ1llVTIuY5tsN0mcvIknFG4PLgr
 ExdwTak8Uon61TuDBsK+H48nE68Hok6IfrFzuKcuiMmCLcuix5Ip/p3UvsPcwi6h8D8e3d+gES
 2lupkUgk0TRZHXPGRZKWIGqdfEJ4igfqCTJRmeBdsGMys7AeByuAYMrM0p1Ur9xdJFCTkGCn3L
 7oJ+NX++oeQWCz9KjCqxwblz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2022 02:14:50 -0700
IronPort-SDR: NbYlUr609vxq55rxiQzQAsKUg/PryP0Jvzdqaw4lYKJIPOPJ3jyJCy+jdQME0H6qC8Gl3q8Jzf
 9bRHozeOd/mfni59qicgVA6i2EvTCFJg3hkq2V0Ug9ckSLxqL6lauzpUGWkPSrVf5kDoEFWH88
 SPUICFiDizU8cagNIKoTpX+I5JbvpBzSGZsoXrVXaQxzLtSdqYa+VxywfsXOkFd6bbfzjMVmor
 RX6lJVutlY8EhkP8iQMbTeT5CD4wcR/ZKZeOPssW0XPXHrNUtZG83ldKwuxwLoEoYdFc1SKA5b
 UvU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2022 02:43:57 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KRnp44yZfz1SHwl
        for <linux-ide@vger.kernel.org>; Mon, 28 Mar 2022 02:43:56 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648460636; x=1651052637; bh=4R1u0oMa67AUaqyCL1Ybnb0EqSnlxEykfKb
        XBCUGAhA=; b=Y2eC1A/2KwX9ed1fkVth8e80Wuc+2YUIzIVjFUJYs1RDmUTzR6/
        S11lLh8hwbnFz8ZPp376lGC/lYLKA9FUtJZ+qqNE7gg2HpI+0eVDOuhbiAZfWDFk
        kCyPDMk5+LCOj3ueHbKK/Y88/8ET1lowh6piXnPfPqtYsW7r1LQZ3zQs7xmtYWiT
        u91rAppdEX0SufOGm3KBJJs0NrI9slXy+c8ay8Z2cDgY3RXUKF3yTwXEeB9spWtT
        g3Kexle65P+lDhKpM4j2+9muX4GL/R2Dh33Z1uF/5tYYC8huhZugmkaOP1dvtoKb
        hChTUlcktqh1zbq/rGohXRtCYtch55td1Ow==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8RF9_oEsHMSO for <linux-ide@vger.kernel.org>;
        Mon, 28 Mar 2022 02:43:56 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KRnp35y6lz1Rvlx;
        Mon, 28 Mar 2022 02:43:55 -0700 (PDT)
Message-ID: <e93d4893-123c-c5df-51cd-5841a2124fc7@opensource.wdc.com>
Date:   Mon, 28 Mar 2022 18:43:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/4] ata: libata-sata: Improve sata_link_debounce()
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org
References: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
 <20220323081740.540006-5-damien.lemoal@opensource.wdc.com>
 <8933f892-aa56-cd21-8acc-744d9a89f66e@molgen.mpg.de>
 <890cac19-a94f-cfc7-7eaa-c05b74f69669@opensource.wdc.com>
 <8c09cd9f-f0b2-5887-d0ad-54b71fcd4734@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8c09cd9f-f0b2-5887-d0ad-54b71fcd4734@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/28/22 16:41, Paul Menzel wrote:
> Dear Damien,
> 
> 
> Am 28.03.22 um 09:19 schrieb Damien Le Moal:
>> On 3/25/22 18:10, Paul Menzel wrote:
> 
>>> Am 23.03.22 um 09:17 schrieb Damien Le Moal:
>>>> sata_link_debounce() polls the SStatus register DET field to ensure that
>>>> a stable value is provided, to reliably detect device presence and PHY
>>>> readiness. Polling is done for at least timing->duration if there is no
>>>> device detected. For the device detected case, polling last up to
>>>
>>> last*s*
>>>
>>>> deadline to ensure that the PHY becomes ready.
>>>>
>>>> However, the PHY ready state is actually never checked, leading to the
>>>> poll loop duration always reaching the maximum duration.
>>>>
>>>> For adapters that do not require a debounce delay (link flag
>>>> ATA_LFLAG_DEBOUNCE_DELAY no set), add a check to test if DET indicates
>>>
>>> no*t*?
>>>
>>>> device present *and* PHY ready and bail out of the polling loop if it
>>>> does.
>>>>
>>>> While at it, add comments to clarify the various checks in
>>>> sata_link_debounce() polling loop.
>>>
>>> Were you able to verify that the check now terminates the loop on your
>>> devices earlier?
>>
>> Yes it does for me. The function goes from taking about 100ms to taking
>> only one iteration of the loop, which has only one 5ms sleep.
>>
>>>
>>> Are below the right lines to compare? On the Dell OptiPlex 5055 (AMD FCH
>>> SATA Controller [AHCI mode] [1022:7901]) I see:
>>>
>>> Before (this very patch)
>>>
>>>       [    0.428015] ata1: hard resetting link
>>>       [    0.696316] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>>>
>>> After:
>>>
>>>       [    0.428907] ata1: hard resetting link
>>>       [    0.648092] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>>>
>>> So a decrease of (268 - 219 = 49) ms. Nice.
>>
>> For a regular boot, sata_deb_timing_normal duration is used. So the save
>> is 100ms almost (there is still one iteration of the loop needed, which
>> takes interval = 5ms).
>>
>> Together with the long 200ms sleep in sata_link_resume, the gain overall
>> should be about 300ms.
> 
> To my knowledge this was a regular boot (`systemctl reboot`). So where 
> did the 50 ms go? ;-)

The device also sometimes need time to reach DET == 3 state... This is an
optimization that reduces the time waited to reach DET == 3. But we still
wait for it :)

On a hot reboot, as the device are already ready, I do see the time
reduced to one interval (5ms). But for a cold boot, it takes longer sometimes.


-- 
Damien Le Moal
Western Digital Research
