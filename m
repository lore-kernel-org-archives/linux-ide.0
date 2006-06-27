From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: regarding ata_msg_*()
Date: Tue, 27 Jun 2006 00:47:02 -0400
Message-ID: <44A0B846.4090206@pobox.com>
References: <449E7FB9.4080305@gmail.com> <20060626074132.GA10695@gollum.tnic> <449F9427.1080806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:8411 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S933457AbWF0ErJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jun 2006 00:47:09 -0400
In-Reply-To: <449F9427.1080806@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Borislav Petkov <bbpetkov@yahoo.de>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> ATA_MSG_ERR
> ATA_MSG_WARN
> ATA_MSG_INFO
> -------------> all above are enabled by default
> ATA_MSG_DEBUG
> ATA_MSG_VDEBUG


The current ATA_MSG_xxx were best-guesses, and only now, when the 
conversion patches begin to be merged, do we see how well those guesses 
match with reality.

I do agree that the above list matches the current code, but the 
ATA_MSG_xxx and Becker schemes are aimed more at verbosity+severity 
levels, than strictly severity levels.

<thinking aloud>  For libata, the best mapping might be

0: critical problems (errors)
1: non-critical, recovered problems or "troubling circumstances" (warnings)
2: terse info from exceptional events (probe, hotplug)
3: more verbose info about exceptional events (IDENTIFY hex values as 
shown today, sector count, features)
4: terse command-submit tracing
5: terse command-complete tracing
6: verbose hot path
7: function ENTER/EXIT tracing

Thus illustrating the general goals of (a) enabling fine-grained tracing 
of specific portions of libata, (b) ordering messages in order of 
severity, and (c) ordering messages by likelihood of producing tons of 
log spam.

Eventually we can use blktool to turn on terse command-complete tracing 
for a single SATA port, and not have to suffer the current log spam and 
coarseness that results from using today's #defines.

	Jeff


