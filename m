From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Possible regression of LBA48 support for piix
Date: Thu, 17 Dec 2009 14:33:39 +0100
Message-ID: <200912171433.39135.bzolnier@gmail.com>
References: <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB2AF@HMCEXMBX01CLUS.hmcikoula.com> <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB31D@HMCEXMBX01CLUS.hmcikoula.com> <4B2A227E.2010106@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:53171 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764747AbZLQNfN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 08:35:13 -0500
In-Reply-To: <4B2A227E.2010106@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Romain Kubany <rkubany@ikoula.com>, Mikael Pettersson <mikpe@it.uu.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Thursday 17 December 2009 01:22:22 pm Jeff Garzik wrote:
> On 12/17/2009 07:07 AM, Romain Kubany wrote:
> > Here it is under the 2.6.28 :
> >
> > # hdparm -I /dev/sda
> >
> > /dev/sda:
> >
> > ATA device, with non-removable media
> >          Model Number:       Virtual HD
> >          Serial Number:
> >          Firmware Revision:  1.1.0
> > Standards:
> >          Likely used: 2
> > Configuration:
> >          Logical         max     current
> >          cylinders       16383   65535
> >          heads           16      16
> >          sectors/track   63      255
> >          --
> >          bytes/track: 65024      bytes/sector: 512
> >          CHS current addressable sectors:  267382800
> >          LBA    user addressable sectors:  267382800
> >          device size with M = 1024*1024:      130558 MBytes
> >          device size with M = 1000*1000:      136899 MBytes (136 GB)
> 
> Yeah, that info is straight from the virtual disk, without any sort of 
> massaging.  The disk is reporting 136GB max, so I would poke around 
> Windows to see if a setting changed somewhere...  maybe there is an "old 
> IDE compatible" setting that got turned on, for the virtual hd?

It is also possible that this virtual disk has never worked with ata_piix
driver and worked with piix driver in the older kernels because of pure luck.

In 2.6.28 I've fixed LBA48 checks in IDE to match libata (see commit 942dcd8
for details) so it would be worth to try:

	- simulating the older buggy IDE behavior with 2.6.32 kernel

or

	- staring long enough at 'hdparm --Istdout /dev/sda' output

first.

--
Bartlomiej Zolnierkiewicz
