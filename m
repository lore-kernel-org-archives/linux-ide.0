From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [git patches] libata hibernation fixes
Date: Tue, 4 Nov 2008 22:08:42 +0100
Message-ID: <200811042208.42982.rjw@sisk.pl>
References: <20081104062734.GA4420@havoc.gtf.org> <alpine.LFD.2.00.0811040823350.3419@nehalem.linux-foundation.org> <20081104203036.GE5862@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755409AbYKDVE0@vger.kernel.org>
In-Reply-To: <20081104203036.GE5862@ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-ide@vger.kernel.org

On Tuesday, 4 of November 2008, Pavel Machek wrote:
> Hi!
> 
> >  - quite possibly: we just should not spin down disks at all, and just 
> >    flush them and do the "park" command thing. If we're _really_ powering 
> >    off, the disks will spin down on their own when power goes away. Maybe 
> >    that's what Windows does?
> 
> I believe that 'emergency' spindown (on power fail) is different from
> regular spindown, and that emergency spindown damages the disk more.
> 
> But perhaps park + power fail is similar to regular spindown?
> 
> (Is park command normally supported on modern disks? IIRC hdaps people
> had issues with not all disks supporting it?)

I don't know really and that's why I'd prefer it if Tejun commented here.

Anyway, I created these patches because the people who discussed this issue
believed it was the right thing to do.  They are based on a Tejun's patch
posted as an attachment to http://bugzilla.kernel.org/show_bug.cgi?id=8855 .
Please look into that bug entry for further references.

Thanks,
Rafael
