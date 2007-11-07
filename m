From: "Denys Fedoryshchenko" <denys@visp.net.lb>
Subject: Re: SC1200 failure in 2.6.23 and 2.6.24-rc1-git10
Date: Wed, 7 Nov 2007 23:22:29 +0200
Message-ID: <20071107211932.M35475@visp.net.lb>
References: <20071101213013.M54162@visp.net.lb> <20071106221521.4f64a066.akpm@linux-foundation.org> <20071107132630.M65286@visp.net.lb> <4731D85E.70201@daa.com.au> <20071107160426.M31617@visp.net.lb> <47320E37.8010106@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=koi8-r
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from usermail.globalproof.net ([194.146.153.18]:33197 "EHLO
	usermail.globalproof.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753916AbXKGVWp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Nov 2007 16:22:45 -0500
In-Reply-To: <47320E37.8010106@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: James Andrewartha <jamesa@daa.com.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, htejun@gmail.com

On Wed, 07 Nov 2007 14:12:55 -0500, Mark Lord wrote
> > WRAP ~ #./hdparm -I /dev/hda
> > 
> > /dev/hda:
> > 
> > ATAPI Write-once device, with non-removable media
> >         Model Number:       SanDisk SDP3B-16
> >         Serial Number:      24313671615
> >         Firmware Revision:  vdd 1.00
> > Standards:
> >         Likely used: 3
> > Configuration:
> >         DRQ response: 50us.
> >         Packet size: Unknown
> > Capabilities:
> >         LBA, IORDY(may be)(cannot be disabled)
> >         Buffer size: 1.0kB      bytes avail on r/w long: 4
> >         DMA: not supported
> >         PIO: pio0 pio1
> 
> "ATAPI Write-once device"  ???
> 
> That cannot be correct (??).  Is this with hdparm-7.7 (latest 
> sourceforge) ?? Can you show us the "hdparm --Istdout" output as 
> well, please.
> 
> thanks.
Yes latest hdparm-7.7. But maybe it is related to git kernel? Cause lines
[    8.658485] hda: applying conservative PIO "downgrade"
[    8.674009] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO0
[    8.674264] hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplet
e Error }
[    8.698231] hda: set_drive_speed_status: error=0x04 { DriveStatusError }
[    8.718590] hda: applying conservative PIO "downgrade"
[    8.734085] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO0
[    8.734337] hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplet
e Error }
[    8.758315] hda: set_drive_speed_status: error=0x04 { DriveStatusError }

appeared only in those kernels (2.6.24-git/rc)


Anyways:

WRAP ~ #./hdparm --Istdout /dev/hda

/dev/hda:
844a 01ea 0000 0002 0000 0240 0020 0000
7a80 0000 2020 2020 2020 2020 2032 3433
3133 3637 3136 3135 0002 0002 0004 7664
6420 312e 3030 5361 6e44 6973 6b20 5344
5033 422d 3136 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 0001
0000 0200 0000 0100 0000 0001 01ea 0002
0020 7a80 0000 0100 7a80 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 2020
2020 2020 2020 2020 2020 2032 3433 3133
3637 3136 3135 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000




--
Denys Fedoryshchenko
Technical Manager
Virtual ISP S.A.L.

