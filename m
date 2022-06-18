Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75567C43334
	for <linux-ide@archiver.kernel.org>; Sat, 18 Jun 2022 06:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiFRGyh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 18 Jun 2022 02:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiFRGyh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 18 Jun 2022 02:54:37 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C7229C83
        for <linux-ide@vger.kernel.org>; Fri, 17 Jun 2022 23:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655535276; x=1687071276;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+6bmdYR8RDV7Rai4MRodjarsFAmrM8zJ0RVsVV2+CCE=;
  b=p6VpgH8yZGCagNZw17RzM//lpEMrlAPWpqsa3fvnjPhex+GNZDMvtNe3
   XDLeE1pGLUznchvjwqt7dOySW2bFrEjLWwOPTqQIDkMZTD/MRClsg7tZZ
   frQaTvKR1VBL59f5qFHa8vptX2IdN8g7NVXiSL3pUHX+FbnAn7PTix3m8
   FpP+hE/vGvmlA0/soMDG7JuLmixxwAKj/JI5agbZvZepN0zAKqnAof/wG
   PQa9gKF4tWAxn7WN7zcUwNbeF4R+rGe0aOk7ILZV7t1m50qX9HnY3zhoC
   Rl8ruzyb3IsC0SmiQaKD2XN0W5VNRDU/+lDLTbRTjtpF9470/NSSqyAr2
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="202203489"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2022 14:54:35 +0800
IronPort-SDR: smYCPOs8ox5gN1qPt2tbYK7Go2A/XNTYLtBH3w1vroYRANLWRVapA2onfqem//KVK7Qzx4plY3
 Fpz467Lx7cNoGL19law6YZl1jk4Wbw6E1HKWxUi/8oj5MLuf4GGl+L+vkDWOocXZutK88I9l8U
 nyKJjvSO720y1NfekzHSK2Il/zjt/wBmljCTUkM3UWXVu6rAwbZsuj0QQTWd304QN+ciiSf884
 NOuxbvt+HMDZkrfOrNpB03YPfq05OJCcX1oTnrcXlnSK2A95TAt+HD5FyIXZsCwTlKSE51PUY5
 iDSdxco7qi1mkrks6ScSQe9Y
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 23:12:46 -0700
IronPort-SDR: cwWHGL8zDOYJgSyHL5Gml6wG0HFtGyY+ZgV/FkubnPgiVfRsYyABPs+94JggHQD8P37rdih5SX
 A2jIPmDA5lV3VDyD8inrqp5ELqcQUzlWEbQPrpKye35R4Q8kmDjPlN99P+cJG0Xz0nbKXMVw0Q
 gXz4b0h/ZBE43RnueCoZebxeaHZu6PGK46noCtoEVPRTddLd8SOMXYcbwyCkRb9CHwgq6DQUIj
 eFDvI4bORbECtHnGwigluKeSCKyWdMIZL9myZ7Xb354RxISeghSg6uihAW4bidIurR415nNIGs
 gNg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 23:54:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LQ68p6Q3dz1SVp2
        for <linux-ide@vger.kernel.org>; Fri, 17 Jun 2022 23:54:34 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655535274; x=1658127275; bh=+6bmdYR8RDV7Rai4MRodjarsFAmrM8zJ0RV
        sVV2+CCE=; b=pKJhH2iF8UOgOTx2Qeafz7q4FMyajYT0Ko/rfBb4hEmxrzfLg+A
        iM8H0itRWP4bycB0wh1ftrw6HEz9PGn0lNYyHq3wwTWQGOxUupmyIC8WVMgn6FeX
        qnQhG6sCjH5CdfQlzRekJrDHVsQOHZv0d3ZRcTtzt0APu3Pqm6RCIu3eKcDtw1Zh
        f7nSjcDpby3oZeL/wB6E495bYzBY2GbxhWgGywYnsy8q6wAEFKHUy5IFERi0PBrN
        42LBROzTCnn/Mx1kTA+tNy5Ra/BZJJ3rlh2zEEgHU7AsAceNHHwPi2sWDqaLS78r
        H+6KPVL1SZyNwjoVKufkihTmZaK1XZb7X9g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gDQIEqVw8WNG for <linux-ide@vger.kernel.org>;
        Fri, 17 Jun 2022 23:54:34 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LQ68l4Cd6z1Rvlc;
        Fri, 17 Jun 2022 23:54:31 -0700 (PDT)
Message-ID: <ae75e0a8-8f02-cdf2-8200-a570c6afa03a@opensource.wdc.com>
Date:   Sat, 18 Jun 2022 15:54:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 19/23] ata: ahci: Add DWC AHCI SATA controller support
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-20-Sergey.Semin@baikalelectronics.ru>
 <6c02f8ef-8aea-8f80-590d-343f67a96f8d@infradead.org>
 <20220610215850.ju76kxjquwef6kd3@mobilestation>
 <73716f9f-892c-41c5-89f0-64a1985438aa@infradead.org>
 <20220615213029.3upsmasnnhigqozm@mobilestation>
 <bfaf0208-8416-c159-93f8-8cc31dbc7ef5@opensource.wdc.com>
 <20220617203649.wa2b3etx6gpm3s5g@mobilestation>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220617203649.wa2b3etx6gpm3s5g@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/18/22 05:36, Serge Semin wrote:
> On Thu, Jun 16, 2022 at 09:31:30AM +0900, Damien Le Moal wrote:
>> On 2022/06/16 6:30, Serge Semin wrote:
>>> On Fri, Jun 10, 2022 at 04:34:13PM -0700, Randy Dunlap wrote:
>>>> Hi Serge,
>>>>
>>>> On 6/10/22 14:58, Serge Semin wrote:
>>>>> On Fri, Jun 10, 2022 at 09:34:46AM -0700, Randy Dunlap wrote:
>>>>>> Hi--
>>>>>
>>>>> Hi Randy
>>>>>
>>>>>>
>>>>>> On 6/10/22 01:17, Serge Semin wrote:
>>>>>>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>>>>>>> index bb45a9c00514..95e0e022b5bb 100644
>>>>>>> --- a/drivers/ata/Kconfig
>>>>>>> +++ b/drivers/ata/Kconfig
>>>>>>> @@ -176,6 +176,16 @@ config AHCI_DM816
>>>>>>>  
>>>>>>>  	  If unsure, say N.
>>>>>>>  
>>>>>>> +config AHCI_DWC
>>>>>>> +	tristate "Synopsys DWC AHCI SATA support"
>>>>>>> +	select SATA_HOST
>>>>>>> +	default SATA_AHCI_PLATFORM
>>>>>>
>>>>>
>>>>>> I don't think this needs to default to SATA_AHCI_PLATFORM.
>>>>>> It might build a driver that isn't needed.
>>>>>> And it's incompatible with "If unsure, say N."
>>>>>
>>>>> Basically you are right, but this particular setting is connected with
>>>>> the modification I've done in the drivers/ata/ahci_platform.c driver
>>>>> in the framework of this commit. I've moved the "snps,spear-ahci" and
>>>>> "snps,dwc-ahci" compatible devices support to the new driver. Thus
>>>>> should I omit the SATA_AHCI_PLATFORM dependency their default kernel
>>>>> configs will lack the corresponding controllers support. If it's not a
>>>>> problem and we can rely on the kernel build system ability to ask
>>>>> whether the new config needs to be set/cleared, then I would be very
>>>>> happy to drop the default setting. What do you think?
>>>>
>>>
>>>> I'd prefer to try it like that.
>>>> If it becomes a problem, we can go back to this v4 patch.
>>>
>>> Agreed then (seeing Damien is silent about your comment).
>>
> 
>> I have not thought about it :)
>> I do not use SATA PLATFORM at all, so I am not familiar with its dependencies.
>> Will have a look and do my usual build tests anyway.
> 
> Ok. I'll be waiting for you reply in this regard the before
> re-submitting the next series version.

Please send a fixed-up new version. I will use that to look at builds and
config dependencies.


-- 
Damien Le Moal
Western Digital Research
