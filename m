From: tytso@mit.edu
Subject: Re: ATA 4 KiB sector issues.
Date: Thu, 11 Mar 2010 10:25:51 -0500
Message-ID: <20100311152551.GG1497@thunk.org>
References: <4B947393.2050002@kernel.org>
 <472A4C80-30CE-4875-8073-F7E61659B6F0@mit.edu>
 <1268318374.2798.2.camel@mulgrave.site>
 <201003112035.26743.knikanth@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201003112035.26743.knikanth@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikanth Karthikesan <knikanth@suse.de>
Cc: James Bottomley <James.Bottomley@suse.de>, Damian Lukowski <damian@tvk.rwth-aachen.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Matthew Wilcox <matthew@wil.cx>, "Martin K. Petersen" <martin.petersen@oracle.com>, Tejun Heo <tj@kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Mark Lord <kernel@teksavvy.com>, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, aschnell@suse.de, jdelvare@suse.de
List-Id: linux-ide@vger.kernel.org

On Thu, Mar 11, 2010 at 08:35:26PM +0530, Nikanth Karthikesan wrote:
> The real problem, here is just that partitioning-tools should create 
> partitions that can work with both XP as well as Windows7. May be distro 
> installers, should ask the user which compatibility he needs.

4k aligned sectors will *work* with Windows XP, will it not?  It's
just simply a matter of Windows XP, being really ancient, doesn't
create properly alligned partitions by default.   

And how often are we going to see Windows XP systems with these new 4k
physical sector drives anyway, where the first OS to touch the
partition is Windows XP?  And in the case where this does happy, the
resulting partition will be result in terribly performance for Windows
XP as well as Linux.

What's the specific scenario which you are trying to solve, and how
likely is it to occur in real life?

					- Ted
