Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9556CA0FF3
	for <linux-ide@archiver.kernel.org>; Tue,  5 Sep 2023 16:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239860AbjIEQVA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353894AbjIEIdV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Sep 2023 04:33:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38501CC7
        for <linux-ide@vger.kernel.org>; Tue,  5 Sep 2023 01:33:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFA4B60AFA
        for <linux-ide@vger.kernel.org>; Tue,  5 Sep 2023 08:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A67FC433C8;
        Tue,  5 Sep 2023 08:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693902797;
        bh=3tETCQLe38qNhYC0q8cJQJn5fixCewMg1ZI5PI671Fo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ktZGDozscxbaD+HT/TlGfnN4J/yQKXbwe+M2HZZj7u1w5iWp3w6ZbdJthU7S5YbH8
         v1FrqJsMJe/H0buoWOjIHnmsu3Hh6Dx1SYqQxygrfWokYtzqGdq1S/bX+eX0odlfxH
         J0sym7P4ICy2waFmTaAhOvBtyiUuxOVpIwq+ptxTuH5bPdYsJ9BJQ8XSBsujcnCYJQ
         xoaf+UQzSPJaIWCKFFYKHo8om8Qm3v9cHBhrxQT2pwwIauFiuP29KccBxbdWZU2PGB
         khJcc/tcg5oAN83AGBmXz6oEr002MAJXt+dMR8BIVnBjfDqpHQa+HAOasPMthgQ0kV
         iXwWj3eybTFnQ==
Message-ID: <93dbc1d0-10eb-ae53-4be4-74e5a148a4c8@kernel.org>
Date:   Tue, 5 Sep 2023 17:33:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: libata: disallow dev-initiated LPM transitions to
 unsupported states
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Niklas Cassel <nks@flawful.org>,
        Runa Guo-oc <RunaGuo-oc@zhaoxin.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20230904204257.3296685-1-nks@flawful.org>
 <f83f8d45-b506-118f-d038-507bc87eeeef@kernel.org>
 <ZPbmQiQR8yU6L5Nx@x1-carbon>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZPbmQiQR8yU6L5Nx@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/5/23 17:26, Niklas Cassel wrote:
> On Tue, Sep 05, 2023 at 11:29:13AM +0900, Damien Le Moal wrote:
>> On 9/5/23 05:42, Niklas Cassel wrote:
>>> From: Niklas Cassel <niklas.cassel@wdc.com>
>>>
>>> In AHCI 1.3.1, the register description for CAP.SSC:
>>> "When cleared to ‘0’, software must not allow the HBA to initiate
>>> transitions to the Slumber state via agressive link power management nor
>>> the PxCMD.ICC field in each port, and the PxSCTL.IPM field in each port
>>> must be programmed to disallow device initiated Slumber requests."
>>>
>>> In AHCI 1.3.1, the register description for CAP.PSC:
>>> "When cleared to ‘0’, software must not allow the HBA to initiate
>>> transitions to the Partial state via agressive link power management nor
>>> the PxCMD.ICC field in each port, and the PxSCTL.IPM field in each port
>>> must be programmed to disallow device initiated Partial requests."
>>>
>>> Ensure that we always set the corresponding bits in PxSCTL.IPM, such that
>>> a device is not allowed to initiate transitions to power states which are
>>> unsupported by the HBA.
>>>
>>> DevSleep is always initiated by the HBA, however, for completeness, set the
>>> corresponding bit in PxSCTL.IPM such that agressive link power management
>>> cannot transition to DevSleep if DevSleep is not supported.
>>>
>>> sata_link_scr_lpm() is used by libahci, ata_piix and libata-pmp.
>>> However, only libahci has the ability to read the CAP/CAP2 register to see
>>> if these features are supported. Therefore, in order to not introduce any
>>> regressions on ata_piix or libata-pmp, create flags that indicate that the
>>> respective feature is NOT supported. This way, the behavior for ata_piix
>>> and libata-pmp should remain unchanged.
>>>
>>> This change is based on a patch originally submitted by Runa Guo-oc.
>>>
>>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>>
>> Looks good, but don't we need a Fixes tag for this ?
> 
> Sure
> 
> Fixes: 1152b2617a6e ("libata: implement sata_link_scr_lpm() and make ata_dev_set_feature() global")
> 
> Can you add when applying, or do you want me to resend?

OK. Will add that. No need to resend.

> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research

