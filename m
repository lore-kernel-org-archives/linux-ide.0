From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: How to reread disk size?
Date: Mon, 22 Feb 2010 13:57:52 +0100
Message-ID: <1266843472.4414.23.camel@mulgrave.site>
References: <4B7F234F.9000107@shiftmail.org> <4B802BDF.9020509@gmail.com>
	 <4B805487.2010900@shiftmail.org> <1266736938.4414.9.camel@mulgrave.site>
	 <4B814B26.5020501@shiftmail.org>
	 <51f3faa71002210910s484c8e4i975ebf2314287d66@mail.gmail.com>
	 <4B81D699.704@shiftmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:33197 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753376Ab0BVM56 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Feb 2010 07:57:58 -0500
In-Reply-To: <4B81D699.704@shiftmail.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Asdo <asdo@shiftmail.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

On Mon, 2010-02-22 at 01:58 +0100, Asdo wrote:
> Robert Hancock wrote:
> > ata_piix doesn't have a way to get automatically notified that the
> > disk has been hotplugged since the chipset doesn't support it in this
> > mode. (The ideal solution would be to switch the controller into AHCI
> > mode, but I don't know if that's possible on that chipset and BIOS.)
> >
> > I think there are some ways to get the code to recheck the disk
> > however.. you can try echoing something into the "rescan" sysfs file
> > under /sys that matches your device (do a "find /sys/ -name
> > scsi_level" to see what directories they're in, the rescan file is in
> > the same directory).
> >   
> 
> Thanks for the hint
> It doesn't work unfortunately.
> Echoing something into rescan makes it output (in dmesg) basically the 
> same message that comes out with blockdev --rereadpt /dev/sdr. The size 
> is still detected wrong. Catting "model" also turns out that the old 
> brand of disk still being detected. smartctl -a does show the new disk :-)
> I tried to write "1" in evt_media_change but it's permission denied :-)

Right.  libata caches the value from the moment it scans the device.
You might be able to alter it by having the device destroyed and
recreated ... that would be echoing 1 to the delete under the scsi
device sysfs node and then echoing '- - -' to the host rescan parameter.
If that doesn't work, libata will need to be fixed somehow because that
would mean it isn't slaving it's device lifetimes to the SCSI model.

James


