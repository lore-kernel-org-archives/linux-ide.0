From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.23-rc3] Regression: "spurious completions during NCQ"
Date: Wed, 15 Aug 2007 16:32:39 +0900
Message-ID: <46C2AC17.2070606@gmail.com>
References: <200708132005.14697.elendil@planet.nl> <46C17FC5.8090605@gmail.com> <200708150921.32160.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:19517 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbXHOHcr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 03:32:47 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2435424wah
        for <linux-ide@vger.kernel.org>; Wed, 15 Aug 2007 00:32:47 -0700 (PDT)
In-Reply-To: <200708150921.32160.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-ide@vger.kernel.org

Frans Pop wrote:
> On Tuesday 14 August 2007, Tejun Heo wrote:
>> Frans Pop wrote:
>>> I've been running 2.6.23-rc2 without problems. Today I compiled
>>> 2.6.23-rc3 and shortly after boot got the following messages in my
>>> logs:
>>>
>>> kernel: ata1.00: spurious completions during NCQ issue=0x0 SAct=0x7ffc7 FIS=005040a1:00000020
>>> kernel: ata1.00: cmd 61/30:00:73:96:db/00:00:04:00:00/40 tag 0 cdb 0x0 data 24576 out
>>> kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM
>>> violation)
>>> [...] 
>>> kernel: ata1: soft resetting port
>> How reproducible is the problem?
> 
> Not reproducible at all, at least it has not happened again. Guess it may
> have been unrelated to rc3.
> 
> I had rebooted with a change in the BIOS config, but that was only to
> change the active video controller. Don't know how that could affect this.
> OTOH, I pulled that video card out of the system later and that solved a
> longstanding issue I've had with powering off this system [1]...
> 
> I did find one other soft reset in my kernel logs (which go back to Okt 2006,
> 2.6.18); that was on Aug 1 with 2.6.22, but after a different error:
> kernel: ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action0x2 frozen
> kernel: ata3.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x1b data 0
> kernel:          res 40/00:03:00:00:20/00:00:00:00:00/a0 Emask 0x4 (timeout)
> kernel: ata3: soft resetting port
> kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> kernel: ata3.00: configured for UDMA/66
> kernel: ata3: EH complete
> 
> As ata3 is a DVD-RW, I'm a bit less concerned about that one.

You don't need to worry too much as long as errors are properly
recovered.  All commands are retried and you won't lose any data.
Please report if the spurious NCQ problem happens again.  Thanks.

-- 
tejun
