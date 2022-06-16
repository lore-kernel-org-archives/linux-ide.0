Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C500C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 16 Jun 2022 00:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343724AbiFPAZ4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 15 Jun 2022 20:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241758AbiFPAZz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jun 2022 20:25:55 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB0F1F2D8
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2022 17:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655339154; x=1686875154;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3O+o768OC3iqAiJUZClTU8MbjeZHe54EszKexKJRWLg=;
  b=ekgzRZ81ABkg4U3PnfTwQ038W0Dpj5g+/WLqTFzS2jmrV4Bw7zQ1NTFJ
   63PKTBv3eA8Vb+w31RYiXPOHw5EF/imCfYM3kp61uOUmMkRcprZQKPcYr
   pt67dVRWpss//hf7renmiwnSFbWwtRuRG6LPv0tTFezLcvOHlzD7SuykW
   be25awIxM25p+mALUFpkTLwl0CadioCWOGGWSvvX6764wS5/NGowUEff1
   UBBbi3jAi5aMFfuAxwU3xM7kWRlZMaqhmBP33kQJnAvlI6uGZe7kSuih4
   m9OCFKLtljxs/ngp4LW8OyrUMOB/U8UptmNAvYqoPimeROvjDQh6Z+xFJ
   g==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="315352713"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 08:25:52 +0800
IronPort-SDR: R6MH+nbSgnguAbxgeXUHpphsBFxrGqp7CL2KtTWVi1J2EdhtDlkXcmFJm/MMK1o6pps9FFdDGZ
 gOpUMpV8nWX+bds4p6v+YTwQTidAGPzbiNcUoQaM9n18w4srq1QbP7u1G68wkNhNzTmxiHYHo7
 pjd9GIx8pTLsnvspZYyc1SZ4W+AQxl3OWe5XSzxWJNHpcpM7r+w4lo/4RmNmE9RtduBGTzoSil
 DigW/40SaZMNdjXSWnj/t3nJgwg3MGQxFwNxUQjGaADp0JBCArI1Dy+C98v5mztysUeOTsTTkR
 yp+V3MD0u9wSpyc7y2DxYjmt
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 16:48:42 -0700
IronPort-SDR: OhE28f2XbTlGd/FuUPgYW1P+0hzZlJyvbz9nXD6E6U6ulaWAxVCipHTciPkwPf0jZr5HHN9FMR
 Keb5lue9i2T8v8DLsEqTC36LUGv9gXDFsP+z+VVTlin65sdoOyaZejPmAyiX69vsJpjape8vqu
 3iXFme7S996qVT/sQL6vyS772XuWieGVHRtWdhZ/CJlt+cvEx0N/C5LPKShwLjPDbzb/wsiu1M
 c+NwV3ciRjonjP12rJ6vZTporoede/kBVdhFGYaAj8GPwM0xqe20yk9OHlIl8bw6S6p51k/xTO
 jV0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 17:25:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNjdD32tGz1SVnx
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2022 17:25:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655339151; x=1657931152; bh=3O+o768OC3iqAiJUZClTU8MbjeZHe54EszK
        exKJRWLg=; b=S+tY2y1wHtR8fC9ecLVgckNzkJOyDYraBIvctmw2wMv3rIXC8gu
        Cb1CYDkv3mouD7iTx1w67ubCb3LLA3lM75hWyizqrJewNo1yMXv9nPcwRMafftgV
        Zwlvegz6UW9fyLBrwtD2C49EGiSokBjGr11QivKQBeQ6wUEh3k+XzsApf/+G/7an
        zmkijV2uiwTojsFfVDe2JR2xNOG0uQOBMyAu1451YN0CL33MXoWmQW4IcBYct0Ct
        q+xq6vCXG15RquGQRAd+eMnjZ1R9wONDwecWaLvK4I2RdMQAUdV0D70MWUVIBIsP
        smOjU3A4+n38d9Gn/2WWe6qfz2fKzoXq4PQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mm_StWzCclhK for <linux-ide@vger.kernel.org>;
        Wed, 15 Jun 2022 17:25:51 -0700 (PDT)
Received: from [10.89.84.185] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.185])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNjd95DxZz1Rvlc;
        Wed, 15 Jun 2022 17:25:49 -0700 (PDT)
Message-ID: <6d16fe23-012d-39fb-21e5-39ce50f7b03a@opensource.wdc.com>
Date:   Thu, 16 Jun 2022 09:25:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 08/23] ata: libahci_platform: Sanity check the DT child
 nodes number
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-9-Sergey.Semin@baikalelectronics.ru>
 <c388835e-3bc1-a69c-82a7-6036c7adec1b@opensource.wdc.com>
 <20220615205328.chwruabvksdbnaex@mobilestation>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615205328.chwruabvksdbnaex@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/06/16 5:53, Serge Semin wrote:
> On Tue, Jun 14, 2022 at 05:23:33PM +0900, Damien Le Moal wrote:
>> On 6/10/22 17:17, Serge Semin wrote:
>>> Having greater than AHCI_MAX_PORTS (32) ports detected isn't that critical
>>> from the further AHCI-platform initialization point of view since
>>> exceeding the ports upper limit will cause allocating more resources than
>>> will be used afterwards. But detecting too many child DT-nodes doesn't
>>> seem right since it's very unlikely to have it on an ordinary platform. In
>>> accordance with the AHCI specification there can't be more than 32 ports
>>> implemented at least due to having the CAP.NP field of 5 bits wide and the
>>> PI register of dword size. Thus if such situation is found the DTB must
>>> have been corrupted and the data read from it shouldn't be reliable. Let's
>>> consider that as an erroneous situation and halt further resources
>>> allocation.
>>>
>>> Note it's logically more correct to have the nports set only after the
>>> initialization value is checked for being sane. So while at it let's make
>>> sure nports is assigned with a correct value.
>>>
>>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>>
>>> ---
>>>
>>> Changelog v2:
>>> - Drop the else word from the child_nodes value checking if-else-if
>>>   statement (@Damien) and convert the after-else part into the ternary
>>>   operator-based statement.
>>>
>>> Changelog v4:
>>> - Fix some logical mistakes in the patch log. (@Sergei Shtylyov)
>>> ---
>>>  drivers/ata/libahci_platform.c | 13 ++++++++++---
>>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
>>> index 814804582d1d..8aed7b29c7ab 100644
>>> --- a/drivers/ata/libahci_platform.c
>>> +++ b/drivers/ata/libahci_platform.c
>>> @@ -451,15 +451,22 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>>  		}
>>>  	}
>>>  
>>> -	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
>>> +	/*
>>> +	 * Too many sub-nodes most likely means having something wrong with
>>> +	 * the firmware.
>>> +	 */
>>> +	child_nodes = of_get_child_count(dev->of_node);
>>> +	if (child_nodes > AHCI_MAX_PORTS) {
>>> +		rc = -EINVAL;
>>> +		goto err_out;
>>> +	}
>>>  
>>>  	/*
>>>  	 * If no sub-node was found, we still need to set nports to
>>>  	 * one in order to be able to use the
>>>  	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
>>>  	 */
>>> -	if (!child_nodes)
>>> -		hpriv->nports = 1;
>>> +	hpriv->nports = child_nodes ?: 1;
>>
> 
>> This change is not necessary and makes the code far less easy to read.
> 
> elaborate please. What change? What part of this change makes the code
> less easy to read?

You changed:

	if (!child_nodes)
		hpriv->nports = 1;

to:

	hpriv->nports = child_nodes ?: 1;

That is the same. So the change is not needed in the first place, and worse,
makes the code way harder to read for no good reason.

> 
> -Sergey
> 
>>
>>>  
>>>  	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
>>>  	if (!hpriv->phys) {
>>
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research


-- 
Damien Le Moal
Western Digital Research
