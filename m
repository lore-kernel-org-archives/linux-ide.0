Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA0FC4332F
	for <linux-ide@archiver.kernel.org>; Fri,  9 Dec 2022 00:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiLIAeG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 8 Dec 2022 19:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiLIAeF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 8 Dec 2022 19:34:05 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBD979C1C
        for <linux-ide@vger.kernel.org>; Thu,  8 Dec 2022 16:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670546045; x=1702082045;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/HnCCRRoU4wG5Db3nLfi/tyruzNSYuVmE8Obd7yWstE=;
  b=SrS3cE57Qln2RKJTTbjrpZsq3WoCoR5RMu9VkT60sbhTb8Ckgy783s5b
   bctIIyO+k3T4EdA9MRorRr86yZlLyuCujPgp6CmNddPbEsjNzE0y8KBqv
   ZVhfadfW5iZcCe75lDtDqhJMNk50gN6pr90YvUYDXcCfI+xeHq3oEljHk
   De/aimz8ZdU06QD0pOt9jw0FTWF8QQZVebOo0TiYpDefUkutI9dMk4kTC
   YZ09TjwKerkFWrj3yP74SgGCoAMaS7N5a053ZrN5lE0ul8jQDtZIK214f
   sSxkMnrt2rE8UUiQ/ad9qjmLDkXLH09/lXMWQ1x1c8uPLDPJZPLiw4ZAb
   w==;
X-IronPort-AV: E=Sophos;i="5.96,228,1665417600"; 
   d="scan'208";a="218499598"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2022 08:34:04 +0800
IronPort-SDR: URrcykRF8YQ5dSUS/XnzMmzhfCvZpNWuw7/CLzRh5/jEuDejo6GYcy2DVHeaNffyhi/MnrT+vH
 0sQlfImCeDyg2kK3ZqNTuDbbYAEjRiBet4DIQshYWWt/9llQ8DOIHQAmDRhwD6O4QDFEk3i4pR
 BjcfBTdRIaMsLrwELaJa7DX/vjL9KSIF4YqyBks4lUo39HFoXzQnbatGScL6500ciTqg0Uu/2k
 xjhjZoGQ5zNHOl8OSO8sjprsbi99lVmgUZQSIv5Cx9hYZoP1S3VRcMJuendq8VoMUNugk4oBTm
 clY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 15:52:33 -0800
IronPort-SDR: epnOn5xioRqPtO2pyIcpBzx5QFW0xruldpiJ08h5xSdy4yEQ22//1fUrZ3XHM8zU/vEIyVydc3
 FcegqQ9KDQstbfUDTUkctcusxYdllAkHihOnLyj3Jm7Y4FteuivlEwGLXaAFhNBlwkRC3AIKqr
 tNRGeL91PwBnzEpkJwbEZblxufOpOE/9Mh9Z/qNMOjJA26tya+/w1Nr8KR+V/Qk4FZnXPfiqvw
 ShiU97JU0gqknvW0rsNvNx4DSj6+miqyF0RJXngLVml72TDG8Vt47Yg0e742aRElrXaQiyLyWP
 ris=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 16:34:04 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NSsTS42lRz1RvTp
        for <linux-ide@vger.kernel.org>; Thu,  8 Dec 2022 16:34:04 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670546044; x=1673138045; bh=/HnCCRRoU4wG5Db3nLfi/tyruzNSYuVmE8O
        bd7yWstE=; b=RVXYdNWY/+XChEaYM2cOkLyrz5f41cGCu89SylEcQR+xBu20osL
        oI0Hp3e5gSv5k/VyPUR0HanZHuP1j7Fw+TMUoS2aWGc5CcoXGSyVrqVSFbu+dLtA
        VgqvLVpsv7qZbmFpwtYFUHrRt6v/yoYaFadEBbEcaA9kY9OSMW2M+PFoc50BvmuJ
        YtK6Y3P3OF39+AL5LVZQfOrU9DdbuEAmCW89kmFyYoPjKDbUutSm7AEaCEyycErE
        JSLQsX+TgsZyEUnol+DfZRXA2tWi1XRsTvWNkFnRRyvzdWtXsgF5I0G14Sejh1ma
        FQgmIooKU+i5gFKvyMeHnOSCXn4YZ4ClCVg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GHHiACzSkHNR for <linux-ide@vger.kernel.org>;
        Thu,  8 Dec 2022 16:34:04 -0800 (PST)
Received: from [10.225.163.85] (unknown [10.225.163.85])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NSsTR6DY8z1RvLy;
        Thu,  8 Dec 2022 16:34:03 -0800 (PST)
Message-ID: <e7dcb220-d746-6762-bbfa-f83beae859fa@opensource.wdc.com>
Date:   Fri, 9 Dec 2022 09:34:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <f030af47-8522-cdef-8394-84f020c6ddca@opensource.wdc.com>
 <5b5d7816-5e43-88e8-1337-769cce825f78@opensource.wdc.com>
 <125bd8a6-7a1c-cd08-b5ee-da5a24f79f21@opensource.wdc.com>
 <dc9f74bd-91d7-cda1-8182-11d400e6bc3f@opensource.wdc.com>
 <a1b3b74b-1548-44d9-7d72-8eb428fa1788@opensource.wdc.com>
 <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com>
 <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
 <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
 <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
 <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
 <77b389a080646567b9f9d44caa42d547@psihoexpert.ro>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <77b389a080646567b9f9d44caa42d547@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/9/22 03:06, marius@psihoexpert.ro wrote:
> December 8, 2022 12:51 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.com> wrote:
> 
>> By the way, did you also try a cold boot ? Switching off your router,
>> connect the pmp box, turn on the router ? Does it change anything ?
>> ATA hot-plugging tends to have more problems, so worth trying. The
>> ahci_mvebu driver errata is for hot-plug, so this newer SoC may have
>> different issues with that too.
> 
> Yes. No change. Same errors.
> 
>> Can you try with no patches and no revert adding the following options to
>> your kernel command line ?
>>
>> libata.force=2:3Gbps
> 
> No change. Same errors.
> 
>> libata.force=2:1.5Gbps
> 
> This one works, without any error at the beginning, unlike the way reverted commit worked.

Interesting. So it looks like the adapter does not like speeds above
1.5Gbps, at least with pmp/fbs... When connecting a regular 3 or 6 gbps
HDD (sata-2 or sata-3), do you get higher speeds ?

So the temporary workaround is to use "libata.force=2:1.5Gbps" on the
kernel command line. For a better fix, we need to figure out why higher
speeds do not work... Difficult one. Let me have another look at the specs
& driver again. Might take some time though.

-- 
Damien Le Moal
Western Digital Research

