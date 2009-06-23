From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Tue, 23 Jun 2009 18:13:08 +0200
Message-ID: <200906231813.09570.bzolnier@gmail.com>
References: <200906221938.27574.bzolnier@gmail.com> <20090623.031506.214747802.davem@davemloft.net> <200906231658.56489.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <200906231658.56489.elendil@planet.nl>
Content-Disposition: inline
Sender: sparclinux-owner@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tuesday 23 June 2009 16:58:54 Frans Pop wrote:
> On Tuesday 23 June 2009, you wrote:
> > We might need to bisect this one.  But Frans, just for the record
> > could you simply test reverting just that hunk?  Thanks!
> 
> I'm way ahead of you :-)
> 
> Instead of a bisect [1] I decided to first see if some printks in both .26 
> and .31 would show anything useful.
> 
> With 2.6.31 and code included below I get:
> hda: ST34342A, ATA DISK drive
> FJP: id_dma_bug 0x7: &4: 0x0-0x4 no error
> hda: MWDMA2 mode selected
> hdc: Maxtor 6E040L0, ATA DISK drive
> hdd: CD-ROM 56X/AKH, ATAPI CD/DVD-ROM drive
> hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> FJP: ID_FIELD_VALID: 0x7 (true)
> FJP: id_dma_bug 0x7: &4: 0x0-0x4 no error
> hdc: MWDMA2 mode selected
> hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> FJP: ID_FIELD_VALID: 0x2 (true)
> FJP: id_dma_bug 0x2: &2: 0x1-0x1 bad modes		<-------------
> hdd: bad DMA info in identify block
> 
> Note that this included a complete revert of 8d64fcd9 (with minor conflict 
> resolved).
> 
> Here's the same output with 2.6.26.3 with equivalent debug statements:
> hda: ST34342A, ATA DISK drive
> FJP: id_dma_bug 0x7: &4: 0x0-0x0 no error
> hda: MWDMA2 mode selected
> hdc: Maxtor 6E040L0, ATA DISK drive
> hdd: CD-ROM 56X/AKH, ATAPI CD/DVD-ROM drive
> FJP: id_dma_bug 0x7: &4: 0x0-0x0 no error
> hdc: MWDMA2 mode selected
> FJP: id_dma_bug 0x2: &2: 0x0-0x0 no error		<-------------
> hdd: MWDMA2 mode selected
> 
> So it seems to me that in 2.6.26 something was broken in the way these ID 
> fields were handled, at least in this check. This is now fixed (possibly 

Great debugging work, thanks!

> by the changes around 5b90e990..48fb2688) and *that* causes the 
> regression. Note that the hard disks are also affected.

I see it now -- in commit c419993 ("ide-iops: only clear DMA words
on setting DMA mode") we fixed a bug in ide_config_drive_speed()..

[ It was a real bug resulting in incorrect data being passed to
  the user-space through HDIO_GET_IDENTITY ioctl ('hdparm -i'). ]
