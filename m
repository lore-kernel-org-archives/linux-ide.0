Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA14C4332F
	for <linux-ide@archiver.kernel.org>; Tue,  7 Nov 2023 22:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjKGWNm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Nov 2023 17:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbjKGWNl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Nov 2023 17:13:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B697118C
        for <linux-ide@vger.kernel.org>; Tue,  7 Nov 2023 14:13:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C75C433CA;
        Tue,  7 Nov 2023 22:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699395219;
        bh=gE+ZMEmGhDDP65uUCxgrLTDxKOnIcuuxFDhx4fMtZqY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XwBQMWb9pwE8qw561BnRlnkWvsCYgIEEGlf3lvC71BqQSK3N+vQNeExEA9HLUXcVw
         DlODCqU1PMDcFQiSxBJPDBjDNQMQ5QZ094FXtnhAnG6cQZMcOk0xm+9YOSATaxcpCR
         nxLfS8N4fGJ5k5zDHpGvcHeaeSVXlujFnWWDhMyQc2ljxEjptQRScmq4f0N2CKE0TJ
         Tg0GTq44o+Ab485w86axNy1Oaz3Z4sj3vZGtOWWSytZmfG/rcPnZgutaVvVxTH8uM2
         aKLMBSEpVc+q32qv8OyI7LOBC3toEnFqHUnvJhmd61Hwu4nq+bCBAh6FX4AM0DkcjP
         qO1N32hhKv4pQ==
Message-ID: <6d2a2015-3e9b-4420-837e-e9fb8816ae78@kernel.org>
Date:   Wed, 8 Nov 2023 07:13:38 +0900
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
 <87h6m24srm.fsf@vps.thesusis.net>
 <9868ba0d-7d31-4671-84a3-33bca029f89d@kernel.org>
 <871qd1n0cm.fsf@vps.thesusis.net>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <871qd1n0cm.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/7/23 22:45, Phillip Susi wrote:
> Damien Le Moal <dlemoal@kernel.org> writes:
> 
>> Revalidation is needed to make sure that the device settings did not change, or
>> that the device itself did not change. This must be done before we start using
>> the drive again on a system resume or on a port runtime resume.
>>
>> The current code always revalidates the devices attached to a port on system
>> resume, unless the port was runtime suspended. If the port was runtime
>> suspended, then revalidation will be done on runtime resume.
> 
> I don't see any checks for whether the port was previously runtime
> suspended or not.  It looks to me like it unconditionally revalidates
> all devices on system resume, which is why I'm trying to patch it to
> defer that until runtime resume.

The current code for port system resume looks like this:

static int ata_port_pm_resume(struct device *dev)
{
	if (!pm_runtime_suspended(dev))
		ata_port_resume(to_ata_port(dev), PMSG_RESUME, true);
        return 0;
}

So if the port was runtime suspended before the system was suspended, it will
not be resumed and there will be no device revalidation on system resume.
But as we know, runtime suspending a port does not work...

>> The main issue here which make things messy is the fact that the PM ops are
>> defined for the port, not for the device. Separating things would be cleaner,
>> but I think that is extremely hard to do considering the cases where we have
>> multiple devices per port. For these cases, setting the link speed etc may
>> depend on all the devices responding. So leaving some devices sleeping may be
>> very dangerous to do.
> 
> Ahh, right.... you mean for PATA right?  Does anyone still have any of
> those these days? :)

Yes. Many embedded systems and people using old PCs still use that.
And that is not the only case. Port multiplier is the other major one since
multiple drives share the same link. In both cases, the drive "think" it is
talking to its own port, but the port is used to manage several devices. One
consequence of this is that the link speed for the port MUST be limited to the
lowest link speed of all devices. And to discover that, one has to probe all 15
ports of the PMP to discover the devices attached... Hence the fact that
bypassing revalidation being a really bad idea.

>> udisks2 issues passthrough commands, no ? We do not parse these currently, and
>> we will *not* start doing that. For other operations like sync etc which end up
>> as a FLUSH CACHE command, or any other command that require medium access,
>> triggering EH when we prepare these commands in the submission path is not
>> nice. Not even sure that can work. That may need some significant changes to work.
> 
> Isn't the NORMAL time eh is triggered is in response to normal IO being
> submitted?  Power management is kind of the auxiliary use of eh.

EH == error handler. So normally EH triggers only when there are errors. The
other case EH is used is for port scan, device revalidation, etc. Any internal
task that libata needs to do. The reason for using EH for these cases is that
libata internally issued commands are non-NCQ commands, which cannot be mixed
with the NCQ commands that result from the uppoer layers requests (block layer
and scsi disk). Using EH allows stopping these commands for EH to operate
exclusively on the device (or port). That is why suspend/resume use EH.

> I had another patch in my old series that had libata fake several
> commands rather than waking up the drive from SLEEP.  That included
> IDENTIFY, FLUSH CACHE, STANDBY1_NOW, and CHECK POWER CONDITION.  Those were needed to
> keep udisks or smartd from waking up the drive.

Patching udisk and smartd would be a lot more sensible. An application using
passthrough to talk to a drive without first checking if the drive is actually
active is not a sensible thing to do. Especially considering that runtime
autosuspend is a user initiated setup, systemd/udisk/smartd should respect that
setup and not attempt to poke at a disk that is sleeping.

-- 
Damien Le Moal
Western Digital Research

