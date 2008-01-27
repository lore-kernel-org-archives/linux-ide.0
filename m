From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: 2.6.24 sata_sil Sil3114 drive clicking / restarting?
Date: Sun, 27 Jan 2008 14:21:00 -0500
Message-ID: <76366b180801271121kf3119d7w89bca2f0315a4ca9@mail.gmail.com>
References: <76366b180801271019w47e5fafan6ec6b7f3086e3c2@mail.gmail.com>
	 <20080127183332.GA19385@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:49669 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbYA0TVC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 14:21:02 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2516788wah.23
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 11:21:01 -0800 (PST)
In-Reply-To: <20080127183332.GA19385@jim.sh>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: linux-ide@vger.kernel.org

Both drives already had PM disabled, visible in hdparm -i:
"AdvancedPM=yes: disabled (255) WriteCache=enabled"

Looking at the smart reporting, it is showing both drives have a
FAILING_NOW condition for Seek_Error_Rate. I don't know what to
believe, because it seems like whatever drives I attach to this system
are chewed up and start showing Seek_Error_Rate failure conditions.

/dev/sda:
 7 Seek_Error_Rate         0x000b   046   046   067    Pre-fail
Always   FAILING_NOW 393853
/dev/sdb:
 7 Seek_Error_Rate         0x000b   044   044   067    Pre-fail
Always   FAILING_NOW 2556544

I swapped in 2 more drives of the same model, and one exhibits the
same Seek_Error_Rate FAILING_NOW condition. I now have 4 out of 5 of
this same model drive which are failing. They appear to be from the
same batch, so I'm not ruling out some kind of manufacturing defect,
but this definitely seems strange. I guess I'm just fishing to see if
there is anything on the system that could have damaged the drives.

Thanks,
-Andrew

On Jan 27, 2008 1:33 PM, Jim Paris <jim@jtan.com> wrote:
> Andrew Paprocki wrote:
> > I've been noticing something strange on an AMD Geode LX board that I
> > have.. I have two SATA drives connected to the onboard Sil3114 chip,
> > and the drives appear to be continually restarting (soft resetting?)
> > during normal operation when nothing at all is happening on the
> > machine. You can hear the drives doing it as well as feel it
> > physically if you touch the drive. They are spinning down and back up
> > again over and over again. All the while the OS never prints out any
> > ata/scsi problems. The only manifestation of this in the kernel is
> > that if you're doing something w/ the drives, it pauses momentarily
> > while this happens (for instance, during an ext3 format).
>
> It could be drive power management.  Try "hdparm -B 255" or "hdparm -B
> 254" to turn that off.  The output of "smartctl -A" output can also be
> helpful to figure out what's causing it.
>
> -jim
>
>
