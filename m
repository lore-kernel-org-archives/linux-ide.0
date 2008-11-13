From: Linda Walsh <lkml@tlinx.org>
Subject: FYI: BUG in SATA Promise 300 TX4 (2.6.24 - 2.6.27-3) w/Linux
Date: Thu, 13 Nov 2008 13:21:19 -0800
Message-ID: <491C9A4F.1020801@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ishtar.tlinx.org ([64.81.245.74]:50419 "EHLO ishtar.tlinx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628AbYKMVWP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Nov 2008 16:22:15 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, linux-ide@vger.kernel.org

FYI -- ever since I switched to using SATA, I've not had a stable kernel.
Sys uptime went from near infinite (striking planned take downs), to less
than a week consistently.  I'd been using the Promise 300 TX4 with 1-2
Seagate drives.  (PDC40718, rev 02).

Finally an explicit problem regarding that controller under Linux, with it
timing out a drive returning from suspend during 'SMART' operations, got a
suggestions from the community (Tnx, Tejun Heo) to try a _cheaper_ but
better featured Silicon Image controller (SiI 3124 Sata).

Not only did it NOT have the SMART problem (that would hang the drive or
machine), but my random hangs seem to have gone away.

My main server has been up nearly 21 days now on 2.6.27-3 SMP
(vanilla-i386).

I'd had problems with the ranging in kernels going back to 2.6.24 or so
when I had first tried adding SATA to the system.

So Tnx again to Tejun --

and NOTE: the card or driver (or both) for the Promise 300 TX4 isn't
stable for production use -- and has a repeatable problem of timing out
some drives before it can spin-up from standby (just the drive -- not the
computer).  The error logically removes the drive from the system until
the next boot (unplugging, and replugging in the SATA cable on the drive
would hang the machine within 5 seconds of replugging in the cable).  Not
an instant, hang as might indicated a HW upset plugging in cable, but a
couple second delay after plugin -- before keyboard would lock up --
pointing toward the software trying to re-add+initialize the drive.

Needless to say, I'm only using the Sil controller now, and things are
stable.


