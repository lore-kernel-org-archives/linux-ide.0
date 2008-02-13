From: Bernd Schubert <bs@q-leap.de>
Subject: sil3114 corruptions (was: Re: [PATCH 3/3] faster workaround)
Date: Wed, 13 Feb 2008 11:12:02 +0100
Message-ID: <200802131112.03292.bs@q-leap.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.q-leap.de ([153.94.51.193]:50408 "EHLO mail.q-leap.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754629AbYBMKMG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Feb 2008 05:12:06 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Hello Tejun,

On Tuesday 23 October 2007 10:08:01 you wrote:
> Jeff Garzik wrote:
> > Alan Cox wrote:
> >>> 2) Once we identified, over time, the set of drives affected by this
> >>> 3112 quirk (aka drives that didn't fully comply to SATA spec), the
> >>> debugging of corruption cases largely shifted to the standard
> >>> routine: update the BIOS, replace the
> >>> cables/RAM/power/mainboard/slot/etc. to be certain of problem location.
> >>
> >> Except for the continued series of later SI + Nvidia chipset (mostly)
> >> pattern which seems unanswered but also being later chips I assume
> >> unrelated to this problem.
> >
> > The SIL_FLAG_MOD15WRITE flag is set in sil_port_info[] is set according
> > to the best info we have from SiI, which indicates that 3114 and 3512 do
> > not have the same problem as the 3112.
>
> I don't think this data corruption problem w/ sil3114 is related to
> m15w.  m15w workaround slows down things quite a bit and is likely to
> hide problems on PCI bus side.  There are reports of data corruption
> with 3114 on nvidia (most common), via and now amd chipsets.  There's
> one on intel too but IIRC wasn't too definite.
>
> According to a user, freebsd didn't have data corruption problem on the
> same hardware.  I copied PCI FIFO setup code (ours is broken BTW) but it
> didn't fix the problem.
>
> I'll try to reproduce the problem locally and hunt it down.

the problem just came up here again, as you and Jeff already guessed also with 
the the workaround patches.
I guess you didn't find time to look into it yet? Is there anything I can do? 
What would you have done after reproducing it?


Thanks,
Bernd

-- 
Bernd Schubert
Q-Leap Networks GmbH
