From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Sat, 24 Feb 2007 18:32:59 +0100
Message-ID: <200702241833.00199.bzolnier@gmail.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com> <200702241556.19089.bzolnier@gmail.com> <8d158e1f0702240713u606ce010n712c20b8f4b23d27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:42068 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932427AbXBXR0s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Feb 2007 12:26:48 -0500
Received: by ug-out-1314.google.com with SMTP id 44so566268uga
        for <linux-ide@vger.kernel.org>; Sat, 24 Feb 2007 09:26:46 -0800 (PST)
In-Reply-To: <8d158e1f0702240713u606ce010n712c20b8f4b23d27@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patrick Ale <patrick.ale@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, albertl@mail.com, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <mlord@pobox.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>


Hi,

On Saturday 24 February 2007, Patrick Ale wrote:
> Haha,
> 
> Well, I am not sure if they "work" as in, do the right thing.
> I don't know if you had a chance to look at my dmesg-es but acording
> to the legacy IDE drivers my both disks were 2048 Peta byte each, I
> wish I had this kind of storage :P

This is the newest feature! ;-)

Now a bit more seriously - I didn't have a chance to look at the problem
before since it was posted under this thread ("Re: Fwd: [LIBATA] drives not
detected") and I wasn't on cc: list (please always cc: me on IDE driver
related problems).

Now looking at the problem:

> hde: max request size: 512KiB
> hde: Host Protected Area detected.
>         current capacity is 234441648 sectors (120034 MB)
>         native  capacity is 274103470214064 sectors (140340976749 MB)

We know that drive uses LBA48 from the max request size and that
WIN_READ_NATIVE_MAX_EXT command is used to read maximum native capacity.

Digging deeper into the code and looking at the reported capacity values:

0xf94baff94bb0 == 274103470214064
0x00000df94bb0 == 234441648 (== the native capacity for this drive)

it turns out that for some reason HOB (LBA48) hcyl/lcyl/sector register
values are incorrectly reported as 0xf94baf (instead of 0x00000d)
and are actually equivalent to the reported values of non-LBA48 registers
(0xf94baf became 0xf94bb0 because idedisk_read_native_max_address_ext()
adds 1 to the computed address).

Googling returns me some correct dmesgs for this particular drive
(WDC WD1200JB-00EVA0) with Promise controllers so I presume that the drive
reports correct info and that this is not some problem caused by drive/host
combination.  Therefore I think that the most likely causes are:

* you have tried IDE driver _after_ first removing libata driver module,
  could you please retry _without_ libata loaded et all (yes it can
  influence the behavior of the driver/hardware since libata resets
  drives and reprograms the controller/drives)

* "gcc version 3.4.6 (Gentoo 3.4.6-r2, ssp-3.4.6-1.0, pie-8.7.10)"
  gcc looks to be heavily modified from the mainstream version and it might
  be possible that this compiler is buggy and some code gets miscompiled,
  is it possible to try some newer/unmodified version?

* pdc202xx_new rewrite which happend in 2.6.20 has some side-effects
  (highly unlikely since the code was in -mm for months and is the same
  as used in libata version of the driver), could you try 2.6.19?

> hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: task_no_data_intr: error=0x04 { DriveStatusError }
> ide: failed opcode was: 0x37

IDE driver fails to set new (bogus) capacity and continues operation

> hde: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)

device is configured correctly

> hde: cache flushes supported
>  hde: hde1

partition table is scanned and since the current capacity == the native
capacity there should be absolutely no influence on normal operation
(reading/writing data), if it is not true I would like to hear about
the problems encountered.

The same situation is with hdf drive - ST3120022A since it has exactly
the same native capacity as WD1200JB and is also using the full capacity
by default (HPA is disabled).

Thanks,
Bart

> Btw, I just bought myself 2 500GB sata disks, care for any tests to be
> executed? Are there things in particulair you guys would like to have
> tested?
> 
> Patrick
> 
> On 2/24/07, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> >
> > On Saturday 24 February 2007, Patrick Ale wrote:
> > > On 2/24/07, Tejun Heo <htejun@gmail.com> wrote:
> > > > Patrick Ale wrote:
> > >
> > >
> > > >
> > > > The upper one is 40c while the other one is 80c.
> > >
> > > No, they are all 80 , two of them came with the mainboard, the so
> > > called "green" connectors as gigabyte calls them, the other one was an
> > > 80c with blue connector.
> > >
> > > I dunno, I guess I should review my "spare" parts and see what's
> > > really useable from this pile of hardware I have here.
> > >
> > > But hey, one thing is for sure, and I think it's a positive thing.
> > > If libata sees problems or seems to have problems, you can be 99% sure
> > > there IS a problem, where the legacy drivers just act all happy and
> > > keep you thinking everything is peachy and all.
> >
> > I'm really sorry that legacy drivers just work.  I will try harder. ;-)
> >
> > The real problem is that while legacy drivers contain a ton of workarounds
> > and fixes for problems like that they often lacks the documentation about
> > it.
> >
> > > So again, thumbs up for libata.
> > >
> > > Patrick
> >
> 


