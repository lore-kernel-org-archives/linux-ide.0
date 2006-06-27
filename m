From: Tejun Heo <htejun@gmail.com>
Subject: Re: regarding ata_msg_*()
Date: Tue, 27 Jun 2006 14:03:20 +0900
Message-ID: <44A0BC18.7040604@gmail.com>
References: <449E7FB9.4080305@gmail.com> <20060626074132.GA10695@gollum.tnic> <449F9427.1080806@gmail.com> <44A0B846.4090206@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.198]:25135 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932458AbWF0FD1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jun 2006 01:03:27 -0400
Received: by nz-out-0102.google.com with SMTP id z31so1540691nzd
        for <linux-ide@vger.kernel.org>; Mon, 26 Jun 2006 22:03:26 -0700 (PDT)
In-Reply-To: <44A0B846.4090206@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Borislav Petkov <bbpetkov@yahoo.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> ATA_MSG_ERR
>> ATA_MSG_WARN
>> ATA_MSG_INFO
>> -------------> all above are enabled by default
>> ATA_MSG_DEBUG
>> ATA_MSG_VDEBUG
> 
> The current ATA_MSG_xxx were best-guesses, and only now, when the 
> conversion patches begin to be merged, do we see how well those guesses 
> match with reality.
> 
> I do agree that the above list matches the current code, but the 
> ATA_MSG_xxx and Becker schemes are aimed more at verbosity+severity 
> levels, than strictly severity levels.

Yeap, agreed.

My point is that as we need selective message enabling, let's do it by 
first implementing 1:1 mapping and think about message types later.  As 
we already have ata_*_printk() wrappers, embedding ata_msg_*() and 
converting KERN_* to ATA_MSG_* should be enough.

> <thinking aloud>  For libata, the best mapping might be
> 
> 0: critical problems (errors)
> 1: non-critical, recovered problems or "troubling circumstances" (warnings)
> 2: terse info from exceptional events (probe, hotplug)
> 3: more verbose info about exceptional events (IDENTIFY hex values as 
> shown today, sector count, features)
> 4: terse command-submit tracing
> 5: terse command-complete tracing
> 6: verbose hot path
> 7: function ENTER/EXIT tracing
> 
> Thus illustrating the general goals of (a) enabling fine-grained tracing 
> of specific portions of libata, (b) ordering messages in order of 
> severity, and (c) ordering messages by likelihood of producing tons of 
> log spam.

Generally agreed.  I don't think your and my ideas are that different. 
Mine looks like..

ATA_MSG_ERR
ATA_MSG_WARNING
ATA_MSG_INFO	/* I think intial config msg should be in this cat */
(ATA_MSG_VINFO maybe) /* revalidation messages, EH progress... */
-- debug below here
ATA_MSG_DEBUG
ATA_MSG_VDEBUG
ATA_MSG_CMD	/* issue / completion */
ATA_MSG_SG	/* SG map/unmap handling */
ATA_MGS_TRACE	/* function enter/exit */

> Eventually we can use blktool to turn on terse command-complete tracing 
> for a single SATA port, and not have to suffer the current log spam and 
> coarseness that results from using today's #defines.

Yeah, we really need that.  I currently use /dev/hda as my root when I 
need to turn on those debug messages.  :-P

-- 
tejun
