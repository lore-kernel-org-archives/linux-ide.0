Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388C8C4332F
	for <linux-ide@archiver.kernel.org>; Mon,  6 Nov 2023 02:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjKFCc4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 5 Nov 2023 21:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjKFCcz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 5 Nov 2023 21:32:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03407D6
        for <linux-ide@vger.kernel.org>; Sun,  5 Nov 2023 18:32:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D129C433C7;
        Mon,  6 Nov 2023 02:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699237972;
        bh=WLdP1MtfipHOEX5i8gjLWUGJTuwStA0dYSQURRItWoY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PeBZxjSOQjGDO5zkso/Ix2e8E5Ki1UaFHFRrVZsDJL/UvIZJd8WiNX7jb0jETut4i
         VmkSsCnjrNbtybSSFrw1G6j1Oihl3SNB7wzpzhY0BodnyEkhmXVeuyYQdL3Mj0xen2
         o3lkwED7ul6qpdFaCZtoA158hUA8zhIfhmu6ql23YBjBTgEZ3gblnbogVvkAk5nw2Y
         VwBsl894HKHRRZPvbor4ExbBG8QxeasdSfg8bhlnoIEjZ5KPKJbXwWRBMMVzUGwIi2
         iqQA4zLb2ox0jaOiNbz11lOi2lElC8wXrpgqC+rcJYCf/xdw6rNHgP8lRqUTiHAsHn
         p+ukzUdqqsMzQ==
Message-ID: <e469fbc3-9b7f-422d-8ff7-08c426eafbaf@kernel.org>
Date:   Mon, 6 Nov 2023 11:32:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
Content-Language: en-US
To:     Phillip Susi <phill@thesusis.net>
Cc:     linux-ide@vger.kernel.org
References: <87edhz3bry.fsf@vps.thesusis.net>
 <672365d4-bdd6-47c9-b0be-6756f523db59@kernel.org>
 <871qdyh9na.fsf@vps.thesusis.net>
 <ff334ece-ca5b-490b-91d7-6bb51fd2e2b3@kernel.org>
 <87sf63hnbg.fsf@vps.thesusis.net>
 <969790e6-7050-43b9-bb0b-4b55baa21cc9@kernel.org>
 <87h6m24srm.fsf@vps.thesusis.net> <87wmuyqw5t.fsf@vps.thesusis.net>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <87wmuyqw5t.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/4/23 08:01, Phillip Susi wrote:
> Here is the patch.  The hang I saw before appears to be related to how
> I'm trying to force the runtime_pm status in
> ata_eh_revalidate_and_attach().  If I comment that part out, the hang
> goes away.  I'm not sure why I can't work out the right way to force the
> runtime pm status of the block device to agree with the actual status of
> the disk as known to libata during system resume.  Even with a disk not
> behind a PMP, while it does not cause a hang, it does not manage to get
> the runtime pm state to reflect reality.  It still says active even
> though the PuiS disk was left asleep.

That is because the PM operations are defined for the *port*, not the *device*
(struct ata_device). With the missing PM ops for the device, PM core simply
sets the device as active.

Also, the port PM runtime resume operation is synchronous with EH, that is, it
waits for EH to complete before returning. This wait is done with the device
lock held, so calling any PM function that takes the device lock within EH
context can deadlock... That is very likely what you are seeing.

-- 
Damien Le Moal
Western Digital Research

