From: Pavel Machek <pavel@suse.cz>
Subject: 2.6.25 -> 2.6.26-rc1: pcmcia flash card changed name from hda to
	hdc
Date: Thu, 15 May 2008 15:23:13 +0200
Message-ID: <20080515132313.GA1558@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758764AbYEONWZ@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>
Cc: bzolnier@gmail.com, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi!

After update to 2.6.26-rc1, CF card (in pcmcia slot) moved from hda to
hdc on thinkpad x60 (and broke my scripts).

Is that intentional?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
