From: Mark Lord <kernel@teksavvy.com>
Subject: Re: Is there a reliable way to ID a SSD?
Date: Tue, 04 Jan 2011 10:47:59 -0500
Message-ID: <4D23412F.2080802@teksavvy.com>
References: <AANLkTimRUqg4cJzV1O1-Cf+KsX6sRjYrz48Ty1-qMX-c@mail.gmail.com> <4D2223BF.8090901@canonical.com> <AANLkTinbFHFv-x6VWxAmuCn0o8BSzvUmXoeTv1XGq7A+@mail.gmail.com> <4D2247A3.2060506@canonical.com> <AANLkTi=Kv8f3e8zhSkDohkgJqOv+XKQ_dPR=aFbpzm27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:2901 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751719Ab1ADPsP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2011 10:48:15 -0500
In-Reply-To: <AANLkTi=Kv8f3e8zhSkDohkgJqOv+XKQ_dPR=aFbpzm27@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: "Peter M. Petrakis" <peter.petrakis@canonical.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 11-01-03 05:50 PM, Greg Freemyer wrote:
>
> Would it be better if hdparm looked at /sys/block/sda/queue/rotational
> instead of just using word 217 of the identify block?
>
> The current divergence is:
>
> 1) The kernel routine  ata_id_rotation_rate() (in ata.h) is only
> trusting  word 217 if its ATA7 or higher.
>
> http://lxr.linux.no/#linux+v2.6.36/include/linux/ata.h#L799
>
> 2) There have been a couple proposed kernel patches to libata-scsi.c
> to quirk in a HORKAGE flag to set the rotation_rate to 1 (meaning SSD)
> for some known devices.  I don't see those being ACKed yet, but if one
> ever gets in, hdparm will diverge from the kernels info since its
> going straight to the identify block for its info.

That's what hdparm is for.  It reads only from the identify block
for most of the -I output, so that we (kernel developers) can see
exactly what the drive itself is reporting.

This reporting is what makes it useful, rather than simply parroting
whatever is already reported (or not) in /sys/

Cheers
