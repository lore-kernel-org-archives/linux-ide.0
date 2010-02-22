From: Asdo <asdo@shiftmail.org>
Subject: Re: How to reread disk size?
Date: Mon, 22 Feb 2010 01:58:01 +0100
Message-ID: <4B81D699.704@shiftmail.org>
References: <4B7F234F.9000107@shiftmail.org> <4B802BDF.9020509@gmail.com>
 <4B805487.2010900@shiftmail.org> <1266736938.4414.9.camel@mulgrave.site>
 <4B814B26.5020501@shiftmail.org>
 <51f3faa71002210910s484c8e4i975ebf2314287d66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from blade3.isti.cnr.it ([194.119.192.19]:61751 "EHLO
	BLADE3.ISTI.CNR.IT" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796Ab0BVA7J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Feb 2010 19:59:09 -0500
Received: from conversionlocal.isti.cnr.it by mx.isti.cnr.it
 (PMDF V6.5-b2 #31825) id <01NJY2Q2BXR4BF1U9Q@mx.isti.cnr.it> for
 linux-ide@vger.kernel.org; Mon, 22 Feb 2010 01:58:05 +0100
In-reply-to: <51f3faa71002210910s484c8e4i975ebf2314287d66@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: James Bottomley <James.Bottomley@suse.de>, linux-ide@vger.kernel.org

Robert Hancock wrote:
> ata_piix doesn't have a way to get automatically notified that the
> disk has been hotplugged since the chipset doesn't support it in this
> mode. (The ideal solution would be to switch the controller into AHCI
> mode, but I don't know if that's possible on that chipset and BIOS.)
>
> I think there are some ways to get the code to recheck the disk
> however.. you can try echoing something into the "rescan" sysfs file
> under /sys that matches your device (do a "find /sys/ -name
> scsi_level" to see what directories they're in, the rescan file is in
> the same directory).
>   

Thanks for the hint
It doesn't work unfortunately.
Echoing something into rescan makes it output (in dmesg) basically the 
same message that comes out with blockdev --rereadpt /dev/sdr. The size 
is still detected wrong. Catting "model" also turns out that the old 
brand of disk still being detected. smartctl -a does show the new disk :-)
I tried to write "1" in evt_media_change but it's permission denied :-)

Thank you
