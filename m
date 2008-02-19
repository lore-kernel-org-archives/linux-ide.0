From: Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: "ide=reverse" do we still need this?
Date: Tue, 19 Feb 2008 15:08:41 +0000
Message-ID: <20080219150841.GA2965@deepthought>
References: <20080213001506.GA13933@kroah.com> <20080213024329.GA6912@deepthought> <20080213044304.GA10101@kroah.com> <20080213153249.GA21749@deepthought>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757048AbYBSPJH@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080213153249.GA21749@deepthought>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: bzolnier@gmail.com, muli@il.ibm.com, jdmason@kudzu.us, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, discuss@x86-64.org
List-Id: linux-ide@vger.kernel.org

On Wed, Feb 13, 2008 at 03:32:49PM +0000, Ken Moffat wrote:
> On Tue, Feb 12, 2008 at 08:43:04PM -0800, Greg KH wrote:
> >=20
> > Can't you just boot with /dev/disk/by-id/ and an initramfs to not h=
ave
> > to worry about such a thing in the future?
> >=20

 Initramfs isn't something I've ever tried, so I'm not about to rush
into it on the server.  Maybe I'll try it on a desktop one day.
Anyway, I've now got it running without ide=3Dreverse, details follow
for anybody else who gets a similar problem in the future.

>  Can comebody remind me what the initramfs is for in that situation,
> please ?  From the little I've noticed, I thought the /dev/disk/by-id
> part went into fstab ?  At the moment, I just build the things I
> think I need in to the kernel on that box, without modules.
>=20
 And for the next person asking this, it seems to be so that you
can specify the root=3D parameter.

>  Anyway, I'll try to find time to read my notes to see if I can
> identify what happened/when, and to take the box down again so I
> can try to confirm exactly what the problem is, if it still exists.
> I certainly won't be taking it down until I've written my weekly
> backups to tape at the weekend, so maybe not before next week.
>=20

 Turns out I was wrong about having a SATA disk for the system - I
used to, but then I needed to separate the backups into separate r/o
and r/w filesystems when nfs no longer let me export part of a ro fs
as rw.  In the change, my staging area for writing to tape or DVD
moved to the system disk, and the only big-enough disk I could get
locally was parallel ide.  So in that setup, ide on a card comes
first.
> > Have you tried the PATA drivers instead of IDE to see if this solve=
s the
> > "moves around" issue?  If they work, then you would not need the co=
mmand
> > line option at all.
>=20

 My first thought was to try using libata for the drives on the
add-on card (sii0680), although it's marked as experimental.  Maybe
I picked the wrong driver, but they didn't show up.  Reverted to
previous config.

 Changed to mount-by-label so that I don't have to change fstab for
the old and new kernels.

 Moved the main drive and the CD to libata (sii still old IDE) -
specify sda instead of hda in root=3D, change system scripts referencin=
g
drives by name (for SMART - system disk is again -d ata, the data raid
moved from hd{e,g} to hd{a,c}), now seems to be working but I expect
I'll notice a few things more in my scripts over the next days.

 I also discovered that lilo needed the real node specified in root=3D
to exist.  It complained, so I added a symlink to the hdaX node -
panic'd trying to load rootfs from 0307.  Reboot to old kernel, run mkn=
od on /dev,
repeat, booted.

Ken
--=20
das eine Mal als Trag=F6die, das andere Mal als Farce
