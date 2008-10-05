From: Nick Warne <nick@ukfsn.org>
Subject: Re: New CD/DVD reports 'Can Play Audio    NO'
Date: Sun, 5 Oct 2008 12:08:09 +0100
Message-ID: <20081005120809.38eb4826@sauron.linicks.net>
References: <20081004103355.407fc303@sauron.linicks.net>
	<48E82FDB.6020009@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755428AbYJELIY@vger.kernel.org>
In-Reply-To: <48E82FDB.6020009@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, D Bray <db1986@internetdog.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Sun, 05 Oct 2008 12:09:15 +0900
Tejun Heo <tj@kernel.org> wrote:

 
> > The drive is:
> > 
> > Vendor                      : Optiarc 
> > Model                       : DVD RW AD-7200A 
> > Revision                    : 1.06
> > 

> > I see this in /proc/sys/dev/cdrom/info:
> > 
> > drive name:             hdb     hda
> > drive speed:            48      48
> > drive # of slots:       1       1
> > Can close tray:         1       1
> > Can open tray:          1       1
> > Can lock tray:          1       1
> > Can change speed:       1       1
> > Can select disk:        0       0
> > Can read multisession:  1       1
> > Can read MCN:           1       1
> > Reports media changed:  1       1
> > Can play audio:         0       1
> > Can write CD-R:         1       1
> > Can write CD-RW:        1       1
> > Can read DVD:           1       1
> > Can write DVD-R:        1       1
> > Can write DVD-RAM:      1       1
> > Can read MRW:           1       1
> > Can write MRW:          1       1
> > Can write RAM:          1       1

> Can you try libata driver and see whether anything is different?
> 

/messages
Oct  5 11:54:13 sauron kernel: ata5: PATA max UDMA/133 cmd 0x1f0 ctl
0x3f6 bmdma 0xf400 irq 14
Oct  5 11:54:13 sauron kernel: ata6: PATA max
UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xf408 irq 15
Oct  5 11:54:13 sauron kernel: ata5.00: ATAPI: TSSTcorp CDDVDW
SH-S202J, SB00, max UDMA/66
Oct  5 11:54:13 sauron kernel: ata5.01: ATAPI: Optiarc DVD RW AD-7200A,
1.06, max UDMA/66
Oct  5 11:54:13 sauron kernel: ata5.00: configured for UDMA/66
Oct  5 11:54:13 sauron kernel: ata5.01: configured for
UDMA/66

/syslog
Oct  5 11:54:13 sauron kernel: sr0: scsi3-mmc drive: 48x/48x writer
dvd-ram cd/rw xa/form2 cdda tray
Oct  5 11:54:13 sauron kernel: sr1:
scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray

/proc/sys/dev/cdrom/info

drive name:             sr1     sr0
drive speed:            48      48
drive # of slots:       1       1
Can close tray:         1       1
Can open tray:          1       1
Can lock tray:          1       1
Can change speed:       1       1
Can select disk:        0       0
Can read multisession:  1       1
Can read MCN:           1       1
Reports media changed:  1       1
Can play audio:         1       1
Can write CD-R:         1       1
Can write CD-RW:        1       1
Can read DVD:           1       1
Can write DVD-R:        1       1
Can write DVD-RAM:      1       1
Can read MRW:           1       1
Can write MRW:          1       1
Can write RAM:          1       1


Works and plays fine!

Nick
-- 
Free Software Foundation Associate Member 5508
