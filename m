From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: FYI: BUG in SATA Promise 300 TX4 (2.6.24 - 2.6.27-3) w/Linux
Date: Sun, 16 Nov 2008 12:08:02 +0100
Message-ID: <18719.65298.689618.835202@harpo.it.uu.se>
References: <491C9A4F.1020801@tlinx.org>
	<491FB7E2.2030105@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:53269 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbYKPLQA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 06:16:00 -0500
In-Reply-To: <491FB7E2.2030105@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Linda Walsh <lkml@tlinx.org>, LKML <linux-kernel@vger.kernel.org>, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>

Tejun Heo writes:
 > > and NOTE: the card or driver (or both) for the Promise 300 TX4 isn't
 > > stable for production use -- and has a repeatable problem of timing out
 > > some drives before it can spin-up from standby (just the drive -- not the
 > > computer).  The error logically removes the drive from the system until
 > > the next boot (unplugging, and replugging in the SATA cable on the drive
 > > would hang the machine within 5 seconds of replugging in the cable).  Not
 > > an instant, hang as might indicated a HW upset plugging in cable, but a
 > > couple second delay after plugin -- before keyboard would lock up --
 > > pointing toward the software trying to re-add+initialize the drive.
 > 
 > Some promise controllers seem to suffer transmission problems when
 > combined with certain drives, which often show up as timeouts.  The
 > hardreset of sata_promise wasn't as robust as it should have been and
 > in some cases it wasn't able to recover a link after error condition
 > causing the system to lose drive after such events.  The hardreset
 > problem was fixed recently by Mikael Pettersson.  Can you please try
 > 2.6.28-rc5 and see whether sata_promise still loses drives after
 > failures?
 > 
 > Mikael, I think the hardreset fix is worthy including into -stable.
 > It should be safe for -stable too, right?

The hardreset fix was included in 2.6.27.5. I wanted it in 2.6.26-stable
too, but that branch seems to have been closed now.
