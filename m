From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Possible regression of LBA48 support for piix
Date: Thu, 17 Dec 2009 06:03:36 -0500
Message-ID: <4B2A1008.9070202@garzik.org>
References: <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB2AF@HMCEXMBX01CLUS.hmcikoula.com> <19241.63911.160765.909812@pilspetsen.it.uu.se> <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB2C1@HMCEXMBX01CLUS.hmcikoula.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:54844 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764373AbZLQLDk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 06:03:40 -0500
In-Reply-To: <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB2C1@HMCEXMBX01CLUS.hmcikoula.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Romain Kubany <rkubany@ikoula.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 12/17/2009 05:04 AM, Romain Kubany wrote:
> Ok, thanks for the prompt reply and the notice for the cc: :)
> I'm using libata and ata_piix now.
> My disk is seen as "sda" and a lshw is reporting the controler as using "ata_piix" :
>
> # lshw -c STORAGE
>    *-ide
>         description: IDE interface
>         product: 82371AB/EB/MB PIIX4 IDE
>         vendor: Intel Corporation
>         physical id: 7.1
>         bus info: pci@0000:00:07.1
>         logical name: scsi0
>         logical name: scsi1
>         version: 01
>         width: 32 bits
>         clock: 33MHz
>         capabilities: ide bus_master emulated
>         configuration: driver=ata_piix latency=0
>
> But fdisk always recognize the disk as 136.8Gb :
>
> # fdisk -l
>
> Disk /dev/sda: 136.8 GB, 136899993600 bytes
> 16 heads, 63 sectors/track, 265260 cylinders
> Units = cylinders of 1008 * 512 = 516096 bytes
> Disk identifier: 0xd7267427
>
>     Device Boot      Start         End      Blocks   Id  System
> /dev/sda1   *           1         204      102815+  83  Linux
> /dev/sda2             205        2236     1024128   82  Linux swap / Solaris
> /dev/sda3            2237       20805     9358776   83  Linux
>
> Here is the new kernel config file : http://pastebin.com/f65fd472b

I would definitely be interested in seeing the 'dmesg' output for 
libata, and results from a more recent kernel.

	Jeff



