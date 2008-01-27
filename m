From: Jim Paris <jim@jtan.com>
Subject: Re: 2.6.24 sata_sil Sil3114 drive clicking / restarting?
Date: Sun, 27 Jan 2008 13:33:32 -0500
Message-ID: <20080127183332.GA19385@jim.sh>
References: <76366b180801271019w47e5fafan6ec6b7f3086e3c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:47360 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751831AbYA0Sdl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Jan 2008 13:33:41 -0500
Content-Disposition: inline
In-Reply-To: <76366b180801271019w47e5fafan6ec6b7f3086e3c2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: linux-ide@vger.kernel.org

Andrew Paprocki wrote:
> I've been noticing something strange on an AMD Geode LX board that I
> have.. I have two SATA drives connected to the onboard Sil3114 chip,
> and the drives appear to be continually restarting (soft resetting?)
> during normal operation when nothing at all is happening on the
> machine. You can hear the drives doing it as well as feel it
> physically if you touch the drive. They are spinning down and back up
> again over and over again. All the while the OS never prints out any
> ata/scsi problems. The only manifestation of this in the kernel is
> that if you're doing something w/ the drives, it pauses momentarily
> while this happens (for instance, during an ext3 format).

It could be drive power management.  Try "hdparm -B 255" or "hdparm -B
254" to turn that off.  The output of "smartctl -A" output can also be
helpful to figure out what's causing it.

-jim
