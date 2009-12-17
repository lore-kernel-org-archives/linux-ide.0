From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Possible regression of LBA48 support for piix
Date: Thu, 17 Dec 2009 07:22:22 -0500
Message-ID: <4B2A227E.2010106@garzik.org>
References: <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB2AF@HMCEXMBX01CLUS.hmcikoula.com> <19241.63911.160765.909812@pilspetsen.it.uu.se> <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB2C1@HMCEXMBX01CLUS.hmcikoula.com> <4B2A1008.9070202@garzik.org> <4B2A1E9E.30009@garzik.org> <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB31D@HMCEXMBX01CLUS.hmcikoula.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:57345 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764606AbZLQMWZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 07:22:25 -0500
In-Reply-To: <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB31D@HMCEXMBX01CLUS.hmcikoula.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Romain Kubany <rkubany@ikoula.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 12/17/2009 07:07 AM, Romain Kubany wrote:
> Here it is under the 2.6.28 :
>
> # hdparm -I /dev/sda
>
> /dev/sda:
>
> ATA device, with non-removable media
>          Model Number:       Virtual HD
>          Serial Number:
>          Firmware Revision:  1.1.0
> Standards:
>          Likely used: 2
> Configuration:
>          Logical         max     current
>          cylinders       16383   65535
>          heads           16      16
>          sectors/track   63      255
>          --
>          bytes/track: 65024      bytes/sector: 512
>          CHS current addressable sectors:  267382800
>          LBA    user addressable sectors:  267382800
>          device size with M = 1024*1024:      130558 MBytes
>          device size with M = 1000*1000:      136899 MBytes (136 GB)

Yeah, that info is straight from the virtual disk, without any sort of 
massaging.  The disk is reporting 136GB max, so I would poke around 
Windows to see if a setting changed somewhere...  maybe there is an "old 
IDE compatible" setting that got turned on, for the virtual hd?

	Jeff



