Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5210CC636D3
	for <linux-ide@archiver.kernel.org>; Wed,  8 Feb 2023 23:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjBHXAq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Feb 2023 18:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjBHXAo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Feb 2023 18:00:44 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EB615CB5
        for <linux-ide@vger.kernel.org>; Wed,  8 Feb 2023 15:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675897239; x=1707433239;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cENqs3JHGSS5a+nmrrgBN2wiPWrByhi6oM4315XeNxc=;
  b=ZxFqcVLQemD5HHOBEZ7L9s4o7oAvBTMmcq8dkcnS4ns/g9gadWs1gQ9f
   FdgBqja8Jhgjxu5ILzgkcznZuZzGH7FlNLXlfkNLVHGogBL9UiQyqK4v1
   qB2uTAKmgaRJpwl17hTPHymI4o73b8Ztgqw3Upgxzt5V5cDHQb/4CDe7T
   /hThF0f97QyUWzVc4VOtpDkw1futZOyjK1Aaypwgx3Ee8jP3sjgg20u/C
   iLTa0q5SByJ8biub5HxJxZnHm1RNevsFt5U5XZbn1aezkYVGwQPXZy40U
   pW2tEt0RFs2c5s28xM2n1wBBIGVYV1ATGf913HhwArtbmqJ2sSEz6Ampk
   A==;
X-IronPort-AV: E=Sophos;i="5.97,281,1669046400"; 
   d="scan'208";a="327151156"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2023 07:00:38 +0800
IronPort-SDR: iQGZq1hjlg19oxIPxNh2osIy0dcHGU3/spFATmhQoIsyGFsvXE3RXy4a/omf2JQVvw6gEXDJPJ
 Mu+MfJEru8VF4F2L6SeP4mECQ5f8wPOQS/WfG0LgzY68QqB7yFEalf10gVNiESS2WWVdnEqxPe
 vpUHEJfAZxUyxzRQg6VVoVz25YUTWRDIoOwUWcKH8f7gfpY7bwqUAOEo7gbGF8ncBoxj2OftBm
 ygrK1wA7dTbEsVSGgIJd7dPjSz6iYjOe72+rKsybpxHrQauceWjfXP18eU1UoQfBePjc1YfJiJ
 tXQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2023 14:17:53 -0800
IronPort-SDR: b7qswGOcAWaD6qn5DfoNUGMhlejlj2h+S4c42EV7O6Xjz70wKT+ZbgCIRjuHuwvDRFN4PNPs9J
 UEfRKekzr/2vAbKMJrPOXfZs32PDhcuWrDSPNUHiNI72WSo/OG8+YLrDNbuyChSxQ1KoU6qzEJ
 snydEAi8a43UzsoZcwEapkwq8OHt8+C82m4WJbD9VpIMRVIIddaalRomLChVNsDYTT9yB6GZ0V
 FO0MPxpLbGQnU0Otur20V9LjSnoIdgFBGTqRtTBiwZKIktpzslwKgu1FamrXe5Ml1PWTtU0B4r
 o8w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2023 15:00:39 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PBwT23PV5z1RvTr
        for <linux-ide@vger.kernel.org>; Wed,  8 Feb 2023 15:00:38 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675897238; x=1678489239; bh=cENqs3JHGSS5a+nmrrgBN2wiPWrByhi6oM4
        315XeNxc=; b=H8sy2JGrfyEs7Ph9MNvbsMT7UzYJ4i9mT0Z36A9VfRf9MSPuiUa
        +tKflrJrbDIClnbcGvifqevLWNYVi/78tn3/fK3N7pPmL46YQzZK+SC2GO6suU2n
        maLhOCBAV8s0CCPpzEyMy4KPOptCLX3CdnI7ndOdvFfzqd/XzTV5Wdjl3N7Y9Z0g
        oHZpWJN3SwKbwYinj0TLafisD42lb9Au/NPJBwK9r9QG48F2LOSRRzyk2nkah+rd
        g8ToyejHuKezTwweXPM6pu+IXFZdzad4Hw447TlvrZX0J5XId+BSmr38H+X/OwNU
        ry2e/5URyYtgiD3n1KXgckprhCafo3XK1XQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5gyQflRt46RF for <linux-ide@vger.kernel.org>;
        Wed,  8 Feb 2023 15:00:38 -0800 (PST)
Received: from [10.225.54.64] (unknown [10.225.54.64])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PBwT14VZ4z1RvLy;
        Wed,  8 Feb 2023 15:00:37 -0800 (PST)
Message-ID: <f9781af4-667b-197b-807d-970df77286b6@opensource.wdc.com>
Date:   Thu, 9 Feb 2023 08:00:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <023692b9-d980-82fd-26b9-01a734bd649f@opensource.wdc.com>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
 <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
 <77b389a080646567b9f9d44caa42d547@psihoexpert.ro>
 <da1d366a494469a46eb066b167613e21@psihoexpert.ro>
 <d42ddd29171c69e9a6628bfc2b100aca@psihoexpert.ro>
 <44527e2f8583a8ce51b1241bf9e56595@psihoexpert.ro>
 <45337bf4a17c9c879f9439c1138bc443@psihoexpert.ro>
 <7fe0b96f30bf787d339ba656d5d2df01@psihoexpert.ro>
 <db3fa398d4a1dcadb9df02d1001a61c6@psihoexpert.ro>
 <c7e1b214fca6c2a08dbce60006442dd8@psihoexpert.ro>
 <009822d6-24b8-739d-e7ee-13adc1c7d548@opensource.wdc.com>
 <55834657003f5a4579b326ee61fe1e80@psihoexpert.ro>
 <8cd8066ac1059ae0fef280a3cf6ab03c@psihoexpert.ro>
 <9490768bca8f5a213d89214ca9324fa0@psihoexpert.ro>
 <071bf5d4-4007-6779-60fd-82ec58dd44fe@opensource.wdc.com>
 <d8abdd49a63106081b4f899f8bc53dbe@psihoexpert.ro>
 <6936c460663c956b5c77215eeef140d7@psihoexpert.ro>
 <235d8863945fb1da23c1e7b74831db38@psihoexpert.ro>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <235d8863945fb1da23c1e7b74831db38@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/02/08 21:17, marius@psihoexpert.ro wrote:
> February 8, 2023 1:40 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.com> wrote:
> 
>> On 2023/02/08 3:40, marius@psihoexpert.ro wrote:
>>
>>> [ 173.591831] ata2.15: Port Multiplier 1.2, 0x197b:0x0325 r193, 8 ports, feat 0xf/0x1f
>>> [ 173.600838] ahci-mvebu f10a8000.sata: FBS is enabled
>>> [ 173.605977] ata2.00: hard resetting link
>>> [ 173.937078] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>> [ 173.943563] ata2.01: hard resetting link
>>> [ 174.277073] ata2.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>> [ 174.283555] ata2.02: hard resetting link
>>> [ 174.617075] ata2.02: SATA link down (SStatus 0 SControl 300)
>>> [ 174.622787] ata2.03: hard resetting link
>>> [ 174.957074] ata2.03: SATA link down (SStatus 0 SControl 300)
>>> [ 174.962785] ata2.04: hard resetting link
>>> [ 175.297075] ata2.04: SATA link down (SStatus 0 SControl 300)
>>> [ 175.302784] ata2.05: hard resetting link
>>> [ 175.637072] ata2.05: SATA link down (SStatus 0 SControl 300)
>>> [ 175.642781] ata2.06: hard resetting link
>>> [ 175.977071] ata2.06: SATA link down (SStatus 0 SControl 300)
>>> [ 175.982781] ata2.07: hard resetting link
>>> [ 176.317063] ata2.07: SATA link down (SStatus 0 SControl 300)
>>
>> That is weird too. No point in repeatedly resetting if the link is up. So the
>> patch really screwed up something for 5.15.
> 
> Nothing weird here. There is one reset for each logical port. Only two ports are used.

Ah! missed the port number changing :) You are right.

> 
> I'm going to insert the debug messages in this kernel version too and test again.

Thanks. Did you test the other LTS 6.1 kernel too ? The patch was backported
there too.

-- 
Damien Le Moal
Western Digital Research

