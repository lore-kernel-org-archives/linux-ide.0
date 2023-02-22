Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94144C61DA4
	for <linux-ide@archiver.kernel.org>; Wed, 22 Feb 2023 23:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjBVXoB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 22 Feb 2023 18:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjBVXn7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Feb 2023 18:43:59 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B0E37546
        for <linux-ide@vger.kernel.org>; Wed, 22 Feb 2023 15:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677109434; x=1708645434;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=7psvwOaN8JOXUE0Duh6n3tJpFd1+f83WsHIMyBx9cU8=;
  b=gg7bjbiplHVf1RCwf8f2c0lQdeIw5etjPMmJviqefE64JRo1SyGDOXJJ
   iOeVbMvH0rnchXdcQZD2Ys0Vv6LTKieSMqKMY7DQjPjbvwI9mWA1wUR1j
   hfmn94IPICG83xYfWfZsDx7dF9d3UJinsYKBrfT4XRtuEf8kMnf/QQIb3
   R7WwzGqn+kBE0poL1d5RMScZtjDAB1WZeFeHkAyuml/U2JWkfNxNFLly5
   TpnmMWVw88ws7+3PuyONYjNaC0MyBz1Z9J/1JrYqIr/sOqMaM2s+lOx++
   fzdoJo/phiEPXOzbEjuks+kBu5xwlzY7libi7a7Jiu3682rpz+j6J0Juf
   A==;
X-IronPort-AV: E=Sophos;i="5.97,319,1669046400"; 
   d="scan'208";a="222234555"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2023 07:43:53 +0800
IronPort-SDR: CESi8WohGhAcr9Xtq+Q/ySmypKeyV5MwTo0wmyBgj6bWTOsvWHVKJWRbPcH2FAY6mmxZCx6Ll3
 L+/Z/vhzhuECYzeswn2yptRpLt5CJgjTTtEnN8C3k0bN4HlaAponCQfW8/+G70HD23oRRaUqom
 nyXk+o7dA1FIVit78r7JRjvQ4BPlPPud+4ZGYIJZVSz5zYtnaln7BYYHooHiliHRk91C1D7y2W
 MID0YaDmBG3Q1JYOP4QdzQ4ojQNegaR+AYq+PPt8Do4idLRjt0V3kLskoh+C3ZjSNa98NaSd+r
 2V8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2023 14:55:06 -0800
IronPort-SDR: 9m3PQtxvw7y8+h1NcG2jPAL0ubJfB0iBZtHWCK37PYRoaBX5y2T459qsUFRCSxfE/+g+R3+9jh
 TmQXjVycxRUmT0Y0YL5BAqzHS2SfYMBvW2U4TsJoCk5o7spbIx7m9BA3CS+SLSNqJD1W5KV2BO
 ycj4a2HCUZrjs0TqJo/OZyrPX14cXFNqrMsWdVBf26x58E16Twgr4x6KsRYNc2HvljwmeGXU90
 MHBpMgjoy3aPM35+E0a8ueevMv7+P2v0iHcspfHqsle5NkZfSZ9jUi8Ghlzs4TwqUeATr0CNFl
 em8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2023 15:43:54 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PMXmT0LcHz1RvTp
        for <linux-ide@vger.kernel.org>; Wed, 22 Feb 2023 15:43:53 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1677109432; x=1679701433; bh=7psvwOaN8JOXUE0Duh6n3tJpFd1+f83WsHI
        MyBx9cU8=; b=lD3WzDn9sIg5ZJG26kOOnhl8vUni1NTHu10MTIa91SPwoqheh3d
        41OJxawwP7myjxyIIjTl1XXFd1QVXgR7fRbjH3CVvNeW0N2uYvg6yGc4o79omCiL
        I627/FIp98yIFQMqOhin/Edex5h9mMd0eqenIBfeL0EFc3H19nTYe0shjLl9URaZ
        57nDwU8FdXCMu1GdXtv7DnBVDSZPJRzLCmH+aa8ZERFn8HITNI/fhcQ0s9TIt1i6
        /ALCizBJOoxfTd2hji/JYvtA87uqyjd9IAGcCMmc0Z6timIw1FFSZHZrO7sG24+d
        OIs8vvorGhFqVgRZp28mUWF0Y+FU22dYzcQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XcAr1zIKqJak for <linux-ide@vger.kernel.org>;
        Wed, 22 Feb 2023 15:43:52 -0800 (PST)
Received: from [10.225.163.26] (unknown [10.225.163.26])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PMXmR4Smdz1RvLy;
        Wed, 22 Feb 2023 15:43:51 -0800 (PST)
Message-ID: <5c99651c-01d8-e396-f817-802ad6f1017e@opensource.wdc.com>
Date:   Thu, 23 Feb 2023 08:43:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: The SATA_ini162x.
Content-Language: en-US
To:     Ioannis Barkas <jnyb.de@gmail.com>, linux-ide@vger.kernel.org
References: <CADUzMVb+JbwxiKxrxjAep8Gbom_ynM7Os67_gTEHC-dJFAVL0g@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CADUzMVb+JbwxiKxrxjAep8Gbom_ynM7Os67_gTEHC-dJFAVL0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/23/23 06:28, Ioannis Barkas wrote:
> Hello Magnus,
> 
> I will give you more details about it since I reported the issue with
> this controller many years ago.
> 
> Yes you can activate the driver but you will need to enable this
> driver and build your own kernel. That is needed since the driver is
> disabled by default. There is at least one underlying issue that has
> got unnoticed and has not been solved yet thus the driver is
> considered experimental. My PCI card has an eSATA connector routed to
> port 0 and a SATA connector routed to port 1. Back then, I had tested
> the SATA port and believed that the driver could only handle port 0.
> 
> Damien if you are willing to investigate this and help me fix it, I am
> at your disposal. I still have the card with this controller, the
> datasheet of the IC manufacturer, an AMD based PC with a PCI slot and
> lots of disks for testing. What is more, I had done some tests back in
> December and the issue remains. Here is what 6.1 prints:
> [    1.947670] sata_inic162x 0000:05:06.0: version 0.4
> [    1.947716] sata_inic162x 0000:05:06.0: inic162x support is broken
> with common data corruption issues and will be disabled by default,
> contact linux-ide@vger.kernel.org if in production use
> 
> Here is the problem:
> [    3.285163] ata8.00: native sectors (1) is smaller than sectors (976773168)

Are you using drives with HPA ? (host protected area, see:
https://en.wikipedia.org/wiki/Host_protected_area).

That normally is drive dependent, not adapter dependent. And with TCG now, HPA
is not really a thing anymore and not used on any recent drive (that I know of
at least).

Could you try with recent drives (HDDs or SSDs) that do not have HPA ? And maybe
also try to see if the libata argument "ata_ignore_hpa=1" helps.

You could also try adding a horkage for that HPA drive (see
ATA_HORKAGE_BROKEN_HPA examples in libata-core.c, ata_device_blacklist array).
Note to self: there is unfortunately no libata.force= argument for hpa. Will
need to add that.

> 
> I tested the eSATA port and it behaves exactly the same as the SATA
> port. I have also performed some modifications but those were in the
> wrong direction as I completely broke the driver thus it could not
> detect attached devices. That brought a libata bug to the surface and
> I need to send a patch about it. Back to sata_inic, I have not figured
> out how it works with both channels.
> 
> Hope to get better Magnus really soon!
> 
> Best regards.

-- 
Damien Le Moal
Western Digital Research

