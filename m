From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Off-by-one in both LIBATA and IDE drivers
Date: Fri, 13 Mar 2009 20:15:29 -0600
Message-ID: <49BB1341.2020203@gmail.com>
References: <20090313074120.48682.qmail@web4108.mail.ogk.yahoo.co.jp> <49BA7172.80908@gmail.com> <A88EBC06918A4B0789B55D31ECDAF1BB@DIAMOND8600>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:61092 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbZCNCPf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Mar 2009 22:15:35 -0400
In-Reply-To: <A88EBC06918A4B0789B55D31ECDAF1BB@DIAMOND8600>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Norman Diamond <n0diamond@yahoo.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>

Norman Diamond wrote:
>> I assume that ATA_PIIX is set in the configuration.. The lspci -vn and
>> dmesg output from when it fails to detect would be useful.
> 
> Yes, and built in (not even as a module).
> 
> Sorry I'm away from the machine, but even near the machine it's a pain to
> copy text exactly because it's running under Slax (live CD) with no network
> shares.  Even when quoting a dump from the TASKFILE breakage in a later
> kernel I had to read and type by hand.
> 
> I think the PIIX4 devices of VMware server are well known.  Besides vendor
> 8086 and device 7111, VMware's subsystem is coded into LIBATA's PIIX 
> driver.
> 
> For the same PIIX4 devices on a real machine the subsystem is different but
> they're still vendor 8086 and device 7111.
> 
> If I omit hda=noprobe hdb=noprobe hdc=noprobe hdd=noprobe then dmesg shows
> the old IDE driver probing properly, assigning hda to the hard drive and 
> hdc
> to Slax's CD-ROM.  After that LIBATA 3.0 loads but has nothing to do.
> 
> If I include the four noprobes (or as another experiment, ide0=noprobe
> ide1=noprobe hda=none hdb=none hdc=none hdd=none), dmesg shows something
> recognizing that PIIX4 isn't completely native (as always), then the old 
> IDE
> drivers obediently ignoring those devices and reasonably proceeding to 
> probe
> and find nothing on ide2, ide3, ide4, and ide5.  After that LIBATA 3.0 
> loads
> and still does nothing, even though we know what it should be doing.

ata_piix should definitely attach to 8086/7111 regardless of the 
subsystem IDs. I can't really explain why it's not. You should at least 
be seeing a message about the ata_piix version, if not then somehow the 
driver probe function isn't even being called..

> 
> In comparison, I did the same experiments again on Dell and Lenovo machines
> whose BIOSes set ICH7M chipsets to present ATA interfaces, with no 
> option to
> present AHCI interfaces.  If I omit the noprobes then the old IDE drivers
> take over, the hard drive and DVD drive run UDMA to the ICH7M chips, and 
> the
> old IDE drivers run PIO to the ICH7M's ATA interfaces on hda and hdc (with
> no option to enable use_dma).  If I include the noprobes then the old IDE
> drivers obediently refrain, and this them LIBATA 3.0 takes over as it
> should.
> 
> As a workaround I recompiled Slax's kernel 2.6.24.3 and Slax's other stuff,
> with the old IDE drivers changed to modules instead of built in, and LIBATA
> built in the same as before.  Now LIBATA 3.0 takes over as it should, both
> for PIIX4 and ICH7M.  But I still worry that someone's going to have
> chipsets from UMC or ALi or AMD or VIA or SIS or something, where the old
> IDE drivers are necessary, and who knows if this is going to work.  I don't
> have all the machines I need for testing.

The old IDE drivers shouldn't be necessary on any of those, at least not 
in current kernels. I don't know what the state of all of those libata 
drivers in 2.6.24 was.

> 
> On a different tangent, LIBATA's off-by-one error was present in 2.6.20.  I
> booted that Slax with no modification on a machine with ICH7M, a Toshiba
> 250GB hard drive got /dev/sda with DMA, and the DVD drive got /dev/hdc 
> and I
> forgot to check if it got DMA.  Three dd commands should have all failed:
> dd if=/dev/sda of=/dev/null bs=512 skip=268435455 count=1
> dd if=/dev/sda of=/dev/null bs=512 skip=268435448 count=8
> dd if=/dev/sda of=/dev/null bs=512 skip=268435440 count=16
> Somehow the third one worked.  Two error messages and one silence, 100%
> repro.  OK, I'm not the only one pulling hair out over this stuff.  I
> noticed LIBATA's blacklists for broken firmware in various devices.
> 
> --------------------------------------
> Power up the Internet with Yahoo! Toolbar.
> http://pr.mail.yahoo.co.jp/toolbar/

