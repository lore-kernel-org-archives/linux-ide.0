From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [smartmontools-support] inactive SATA drives won't stay in standby
 or sleep, PATA models did. (fwd)
Date: Mon, 13 Oct 2008 09:03:54 +0200
Message-ID: <18674.62170.845285.407281@harpo.it.uu.se>
References: <D73D40172004714D95D7A84AC3E68EC802282133@wdscexbe03.sc.wdc.com>
	<48EBFE9B.9070503@gmail.com>
	<18674.4081.839329.116533@harpo.it.uu.se>
	<48F2D9A8.1030502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756684AbYJMHEc@vger.kernel.org>
In-Reply-To: <48F2D9A8.1030502@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Christian Mueller <Christian.Mueller@wdc.com>, Bruce Allen <ballen@gravity.phys.uwm.edu>, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Tejun Heo writes:
 > Mikael Pettersson wrote:
 > > - smartctl -n standby waking Linda's disks from standby is probably
 > >   a disk firmware issue or a smartctl issue. I see no evidence that
 > >   sata_promise is to blame for that.
 > 
 > /me agrees.  I think it's most likely a problem in the firmware.
 > 
 > > - hardreset in sata_promise seems broken. I'll take a closer look
 > >   at that in about a week's time (I'll be busy with other work the
 > >   next couple of days).
 > 
 > This looks like a rather serious problem, so please take a look at
 > this.  Also, after the drive went down, does unplugging and replugging
 > the signal cable fix the problem, if not does doing the same thing
 > with the power cable make any difference?

I couldn't bring the port back up with any combination of signal/power
cable hotplugging. Even rmmod sata_promise; modprobe sata_promise failed
to bring the port back up. Hence my suspicion that hardreset is borked
or doesn't kick in.
