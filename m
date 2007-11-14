From: "Bjoern Olausson" <lkmlist@gmail.com>
Subject: Re: [Bugme-new] [Bug 9373] New: PDC20267 exception Emask on I/O
Date: Wed, 14 Nov 2007 23:18:44 +0100
Message-ID: <5501535d0711141418t5290fa28j29b15a17e42dd076@mail.gmail.com>
References: <bug-9373-10286@http.bugzilla.kernel.org/>
	 <20071113170412.ffd94bba.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:13322 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624AbXKNWSr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 17:18:47 -0500
Received: by nz-out-0506.google.com with SMTP id s18so320808nze
        for <linux-ide@vger.kernel.org>; Wed, 14 Nov 2007 14:18:46 -0800 (PST)
In-Reply-To: <20071113170412.ffd94bba.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, bugme-daemon@bugzilla.kernel.org

On 11/14/07, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Tue, 13 Nov 2007 16:11:25 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:
>
> > http://bugzilla.kernel.org/show_bug.cgi?id=9373
> >
> >            Summary: PDC20267 exception Emask on I/O
> >            Product: IO/Storage
> >            Version: 2.5
> >      KernelVersion: 2.6.24-rc2
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: Serial ATA
> >         AssignedTo: jgarzik@pobox.com
> >         ReportedBy: lkmlist@gmail.com
> >                 CC: htejun@gmail.com
> >
> >
> > Most recent kernel where this bug did not occur:
>
> Are you sure?  Was the relevant driver not present in 2.6.23?
>
> > when not using the libata drivers
> >
> > Distribution:
> > gentoo
> >
> > Hardware Environment:
> > 00:00.0 Host bridge: Intel Corporation 82850 850 (Tehama) Chipset Host Bridge
> > (MCH) (rev 02)
> > 00:01.0 PCI bridge: Intel Corporation 82850 850 (Tehama) Chipset AGP Bridge
> > (rev 02)
> > 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 02)
> > 00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (LPC) (rev 02)
> > 00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 Controller (rev 02)
> > 00:1f.2 USB Controller: Intel Corporation 82801BA/BAM USB Controller #1 (rev
> > 02)
> > 00:1f.3 SMBus: Intel Corporation 82801BA/BAM SMBus Controller (rev 02)
> > 00:1f.4 USB Controller: Intel Corporation 82801BA/BAM USB Controller #1 (rev
> > 02)
> > 01:00.0 VGA compatible controller: nVidia Corporation NV5 [RIVA TNT2/TNT2 Pro]
> > (rev 11)
> > 02:06.0 Mass storage controller: Promise Technology, Inc. PDC20267
> > (FastTrak100/Ultra100) (rev 02)
> > 02:09.0 RAID bus controller: Silicon Image, Inc. SiI 3114 [SATALink/SATARaid]
> > Serial ATA Controller (rev 02)
> > 02:0a.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
> >
> > Software Environment:
> > Portage 2.1.3.19 (default-linux/x86/2007.0/desktop, gcc-3.4.6, glibc-2.6.1-r0,
> > 2.6.24-rc2 i686)
> > =================================================================
> > System uname: 2.6.24-rc2 i686 Intel(R) Pentium(R) 4 CPU 1500MHz
> > Timestamp of tree: Tue, 13 Nov 2007 15:16:01 +0000
> > distcc 2.18.3 i686-pc-linux-gnu (protocols 1 and 2) (default port 3632)
> > [disabled]
> > ccache version 2.4 [enabled]
> > app-shells/bash:     3.2_p17
> > dev-lang/python:     2.3.5-r3, 2.4.4-r6
> > dev-python/pycrypto: 2.0.1-r6
> > dev-util/ccache:     2.4-r7
> > sys-apps/baselayout: 1.12.9-r2
> > sys-apps/sandbox:    1.2.18.1-r2
> > sys-devel/autoconf:  2.13, 2.61-r1
> > sys-devel/automake:  1.4_p6, 1.5, 1.6.3, 1.7.9-r1, 1.8.5-r3, 1.9.6-r2, 1.10
> > sys-devel/binutils:  2.18-r1
> > sys-devel/gcc-config: 1.3.16
> > sys-devel/libtool:   1.5.24
> > virtual/os-headers:  2.6.22-r2
> > ACCEPT_KEYWORDS="x86"
> > CBUILD="i686-pc-linux-gnu"
> > CFLAGS="-march=pentium4 -O2 -pipe -msse2 -mfpmath=sse -fomit-frame-pointer"
> > CHOST="i686-pc-linux-gnu"
> >
> > Problem Description:
> > The following occures when the drive has some I/O (realized it when transfering
> > data via FTP [only 2-5 MB/s and stalles])
> >
> > [  536.333484] ata8.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
> > [  536.333489] ata8.00: BMDMA stat 0x4
> > [  536.333498] ata8.00: cmd ca/00:18:c7:10:00/00:00:00:00:00/e0 tag 0 cdb 0x0
> > data 12288 out
> > [  536.333501]          res 51/84:00:de:10:00/00:00:00:00:00/e0 Emask 0x10 (ATA
> > bus error)
> > [  536.333506] ata8.00: status: { DRDY ERR }
> > [  536.333510] ata8.00: error: { ICRC ABRT }
> > [  536.333531] ata8: soft resetting link
> >
> > Steps to reproduce:
> > 1) Boot
> > 2) Copy some files (via NFS/FTP/scp/cp....) from the drives to/from the
> > PDC20267
> >
> > complete dmsg can be found here:
> > http://phpfi.com/276055
> > (dmsg buffer seems to be full is there a way to increase it?)
> >
> > here's the part taken from messages:
> > http://phpfi.com/276059
> >
>

I never tried 2.6.23. 2.6.22 with PDC202XX_OLD worked fine. Than I tried to get
rid of the old ATA stuff and tried 2.6.22 with libata only and I got this
error, than I switched to 2.6.24-rc2 to see if the bug is in the dev. version.

All cables are 80 wire.

I removed the new driver from the kernel an added the old one:
http://phpfi.com/276143
The drives are found but I cant access them. (no /dev/hd? thought they are
listed in the dmesg log)

By the way, I had to add irqpoll as kernel parameter when using the libata
driver. Without, system boots, but on first access the system freezes. (No
Kernelpanic on my Monitor...) http://phpfi.com/276145 (dmesg bevor the system
froze)

regards
Bjoern
