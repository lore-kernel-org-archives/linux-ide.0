From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Mon, 08 Mar 2010 23:54:59 -0500
Message-ID: <yq1zl2i6qn0.fsf@sermon.lab.mkp.net>
References: <4B947393.2050002@kernel.org> <yq1zl2ic058.fsf@sermon.lab.mkp.net>
	<20100308195847.GC18077@nb.net.home> <4B95B39C.70402@kernel.org>
	<3E0C3AE547FA504DA5E89EA5A24AC85803E2BD78@wdscexbe01.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3E0C3AE547FA504DA5E89EA5A24AC85803E2BD78@wdscexbe01.sc.wdc.com>
	(Daniel Taylor's message of "Mon, 8 Mar 2010 19:38:53 -0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Taylor <Daniel.Taylor@wdc.com>
Cc: Tejun Heo <tj@kernel.org>, Karel Zak <kzak@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de, Jim Meyering <jim@meyering.net>
List-Id: linux-ide@vger.kernel.org

>>>>> "DLT" == Daniel Taylor <Daniel.Taylor@wdc.com> writes:

DLT> Simple reality is that XP is "forever".  Drives >2TiB, which may be
DLT> USB-attached, used with XP will be MBR-partitioned and use
DLT> 4096-byte sectors.  We need to be able to read/write those disks on
DLT> Linux systems.

Shouldn't be a problem as long as the DOS partition table vs. 4 KiB
sectors thing is fixed.


DLT> One last comment: I just tried to partition and format a >2TiB
DLT> drive on fully updated Ubuntu 9.10 with GParted.  I selected not to
DLT> cylinder align, use GPT and ext3, and to put 1 MiB preceeding and
DLT> following.  libparted failed with "unable to satisfy all
DLT> constraints of the partition".  Using "parted", I created the
DLT> partition, and then GParted was able to apply the ext3 file system.

I don't think ubuntu has adopted any of the relevant updates yet.

I believe the Fedora 13 Alpha is due to be released this week.  That
would be the best test platform because several of the people who have
been actively engaged in the 4 KiB sector enablement process are Fedora
developers.

-- 
Martin K. Petersen	Oracle Linux Engineering
