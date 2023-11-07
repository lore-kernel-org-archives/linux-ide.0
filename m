Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01EAC4332F
	for <linux-ide@archiver.kernel.org>; Tue,  7 Nov 2023 22:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbjKGWCX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Nov 2023 17:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbjKGWBz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Nov 2023 17:01:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0127825A5
        for <linux-ide@vger.kernel.org>; Tue,  7 Nov 2023 13:59:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0328BC433C9;
        Tue,  7 Nov 2023 21:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699394399;
        bh=gC1KvDFYoUFoqwRDLq0ddmRLQ4YoAzBeqV7/VJoVO/w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N9dL41hrAPINNB3NcYva3UbUXa0I+PolVo8UE2OBV+ol3pnqFt1XvSwHBojICd3Fx
         VLCRFNftaEAKQ01NafHMDdsTR6bz211bhJwh0k34eTqjKMtBNfCali6dnZAcbJv/iJ
         5vnuCHLceqOKzAAwfZz2jwnbK3j0xHqZ3pq/a88yElV/vA1qk6v4mtiaghDNG6PqvM
         23yS8xp1oemIeOZT8UuXPO1tigPPq2i1ZsoXSKty1KQkQzG/G10vEpWHLRX8Tzrn5X
         SZ2RyTpg/D0A2QO3J9gmpC4yCX9HL4ZlA1INxGWLiLfzOtNeKbnvnp9nsq2foBTPyh
         pFdc/d+mvm6Ug==
Message-ID: <5c0ae578-e736-4dd2-b87e-fa499223f469@kernel.org>
Date:   Wed, 8 Nov 2023 06:59:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/23] scsi: sd: Differentiate system and runtime
 start/stop management
To:     Phillip Susi <phill@thesusis.net>
Cc:     linux-ide@vger.kernel.org
References: <87edhz3bry.fsf@vps.thesusis.net>
 <672365d4-bdd6-47c9-b0be-6756f523db59@kernel.org>
 <871qdyh9na.fsf@vps.thesusis.net>
 <ff334ece-ca5b-490b-91d7-6bb51fd2e2b3@kernel.org>
 <87sf63hnbg.fsf@vps.thesusis.net>
 <969790e6-7050-43b9-bb0b-4b55baa21cc9@kernel.org>
 <87h6m24srm.fsf@vps.thesusis.net> <87wmuyqw5t.fsf@vps.thesusis.net>
 <e469fbc3-9b7f-422d-8ff7-08c426eafbaf@kernel.org>
 <874jhxn15u.fsf@vps.thesusis.net>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <874jhxn15u.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/7/23 22:27, Phillip Susi wrote:
> Damien Le Moal <dlemoal@kernel.org> writes:
> 
>> That is because the PM operations are defined for the *port*, not the *device*
>> (struct ata_device). With the missing PM ops for the device, PM core simply
>> sets the device as active.
> 
> The ata device appears to be entirely internal and not exposed as part
> of the sysfs device tree.  It is the generic block device that seems to
> be the one that actually implements runtime pm for the disk.
> 
> I think the problem is that the ata port is resumed first, then later
> the block device.  Thus, setting the block device to suspended in the
> port resume is later overruled by the system resume of the block
> device.  I'm thinking what is needed is for sd.c to query libata in its
> system resume callback and then set the runtime pm status depending on
> whether the drive is active or not.

Nope. The correct way to do this would be to define PM operations for the ata
device. However, currently, the scsi_device (scsi_disk) parent is the ata_port,
so to make sure that the PM status of the parent propagates to the child
correctly, we would need to have the scsi_device parent set to the ata_device.
As I said, correcting this is not simple and will involve a significant amount
of changes.

> By the way, I have noticed my system logs showing that the ata port that
> my dvd+rw is on is "Activating" twice, back to back.  Any idea why it
> would be trying to power up the optial drive twice?

Please send the exact messages you see in dmesg.

> 

-- 
Damien Le Moal
Western Digital Research

