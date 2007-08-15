From: Frans Pop <elendil@planet.nl>
Subject: Re: [2.6.23-rc3] Regression: "spurious completions during NCQ"
Date: Wed, 15 Aug 2007 09:21:31 +0200
Message-ID: <200708150921.32160.elendil@planet.nl>
References: <200708132005.14697.elendil@planet.nl> <46C17FC5.8090605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml18.kpnxchange.com ([213.75.38.118]:40815 "EHLO
	hpsmtp-eml18.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752189AbXHOHVe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 03:21:34 -0400
In-Reply-To: <46C17FC5.8090605@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Tuesday 14 August 2007, Tejun Heo wrote:
> Frans Pop wrote:
> > I've been running 2.6.23-rc2 without problems. Today I compiled
> > 2.6.23-rc3 and shortly after boot got the following messages in my
> > logs:
> >
> > kernel: ata1.00: spurious completions during NCQ issue=0x0 SAct=0x7ffc7 FIS=005040a1:00000020
> > kernel: ata1.00: cmd 61/30:00:73:96:db/00:00:04:00:00/40 tag 0 cdb 0x0 data 24576 out
> > kernel:          res 50/00:08:7b:97:db/00:00:04:00:00/40 Emask 0x2 (HSM
> > violation)
> > [...] 
> > kernel: ata1: soft resetting port
>
> How reproducible is the problem?

Not reproducible at all, at least it has not happened again. Guess it may
have been unrelated to rc3.

I had rebooted with a change in the BIOS config, but that was only to
change the active video controller. Don't know how that could affect this.
OTOH, I pulled that video card out of the system later and that solved a
longstanding issue I've had with powering off this system [1]...

I did find one other soft reset in my kernel logs (which go back to Okt 2006,
2.6.18); that was on Aug 1 with 2.6.22, but after a different error:
kernel: ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action0x2 frozen
kernel: ata3.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x1b data 0
kernel:          res 40/00:03:00:00:20/00:00:00:00:00/a0 Emask 0x4 (timeout)
kernel: ata3: soft resetting port
kernel: ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
kernel: ata3.00: configured for UDMA/66
kernel: ata3: EH complete

As ata3 is a DVD-RW, I'm a bit less concerned about that one.

Thanks for the reply,
FJP

[1] http://bugzilla.kernel.org/show_bug.cgi?id=6879
