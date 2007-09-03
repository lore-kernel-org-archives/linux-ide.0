From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: libata equivalent for hdX=remap63
Date: Mon, 03 Sep 2007 21:18:42 +0600
Message-ID: <46DC25D2.6090705@ums.usu.ru>
References: <46DA73B5.5010107@ums.usu.ru> <20070902104645.0c6b291c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay4.usu.ru ([194.226.235.39]:47905 "EHLO relay4.usu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbXICPTP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Sep 2007 11:19:15 -0400
Received: from relay4.usu.ru (localhost [127.0.0.1])
	by relay4.usu.ru (PostSystem) with ESMTP id 71CD017F02
	for <linux-ide@vger.kernel.org>; Mon,  3 Sep 2007 21:21:47 +0600 (YEKST)
Received: from usu2.usu.ru (usu2.usu.ru [194.226.237.16])
	by relay4.usu.ru (PostSystem) with ESMTP id 2EABC17F02
	for <linux-ide@vger.kernel.org>; Mon,  3 Sep 2007 21:21:46 +0600 (YEKST)
Received: from usu2.usu.ru (localhost.usu2.usu.ru [127.0.0.1])
	by usu2.usu.ru (Postfix) with ESMTP id 282C4A7EBA
	for <linux-ide@vger.kernel.org>; Mon,  3 Sep 2007 21:19:08 +0600 (YEKST)
Received: from ums.usu.ru (ums.usu.ru [194.226.236.116])
	by usu2.usu.ru (Postfix) with ESMTP id ACDD1A7EAC
	for <linux-ide@vger.kernel.org>; Mon,  3 Sep 2007 21:19:07 +0600 (YEKST)
In-Reply-To: <20070902104645.0c6b291c@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, Mauelshagen@RedHat.com

Alan Cox wrote:
> The remap63 hack is ancient. Since the kernel acquired device mapper its
> also unneccessary as you can use device mapper to set up a 63 sector
> offset volume.
>
> I'm amazed anyone is still using it but the right way to handle it on a
> vaguely modern system isn't more kernel hacks but to teach dmraid to
> handle it. If you've got an example of what the layout looks like
> (especially if there is a way to autodetect it) then talk to Heinz (cc'd)
> about getting it added to dmraid.
>   

I got no useful reply to my request for the user to send the first 
megabyte of the hard disk. However, using a cracked version of Hitachi 
OEM variant of OnTrack Disk Manager, I produced a 64GB qemu disk image 
with this disk manager, Windows 98 and a Linux partition (just in case). 
It works fine with hda=remap63 and thus serves the purpose of being an 
example of the layout.

The first 64 KB of this hard disk can be found at 
http://ums.usu.ru/~patrakov/first-64-kb.dsk (please tell me when I can 
remove this file).

The full disk image (obviously, without Windows 98 - but you can install 
it yourself) can be reconstructed as:

dd if=/dev/null of=first-64-kb.dsk bs=1M seek=65536

Note that you can't just reinterpret the OnTrackDM6 partition as a disk 
image because it doesn't start at sector 63. To use this image in qemu:

qemu -hda first-64-kb.dsk -hdachs 1024,16,63,none -cdrom 
your-favourite-livecd.iso

In the original image, I could do a "mount -t vfat -o loop,offset=64512 
/dev/hda /mnt" and see the Windows partition.

-- 
Alexander E. Patrakov
