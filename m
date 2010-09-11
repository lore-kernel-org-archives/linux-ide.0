From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: How to determine the information about SATA controller
Date: Sat, 11 Sep 2010 15:34:23 +0200
Message-ID: <19595.34143.859553.402816@pilspetsen.it.uu.se>
References: <AANLkTimMxQXxC354V=qVOrdUYFSrpJ-RZeKJfQEx0KPN@mail.gmail.com>
	<19595.23873.90306.656565@pilspetsen.it.uu.se>
	<AANLkTinQVQsjxJLpZQiP5V56o7quGPY6G0ZOnvwPAKbx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:37176 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752166Ab0IKNe0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Sep 2010 09:34:26 -0400
In-Reply-To: <AANLkTinQVQsjxJLpZQiP5V56o7quGPY6G0ZOnvwPAKbx@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaswinder Singh Rajput <jaswinderlinux@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Jaswinder Singh Rajput writes:
 > > =A0> No root device found.
 > > =A0> Boot has failed, sleeping forever
 > > =A0>
 > > =A0> I am trying to determine the information about the SATA contr=
oller so
 > > =A0> that I can choose the appropriate controller for SATA in kern=
el
 > > =A0> config. I am not able to figure out the SATA information from=
 above
 > > =A0> dmesg and lsmod. How can I do so.
 > >
 > > In your working dmesg the disks are controlled by ata_piix,
 > > but you've disabled CONFIG_ATA_PIIX in the config you're trying.
 > > So it's not surprising that you can't boot.
 > >
 > > 1) re-enable CONFIG_ATA_PIIX and disable CONFIG_IDE
 >=20
 > I have enabled CONFIG_ATA_PIIX
 > and disabled CONFIG_IDE
 >=20
 > but still getting same error :
 >=20
 > No root device found.
 > Boot has failed, sleeping forever
 >=20
 > Am I missing some more options.
 >=20
 > > or
 > > 2) go into the bios and change the option that says whether to run
 > > =A0 the ATA controller in legacy/compatible mode or enhanced/ahci =
mode,
 > > =A0 you want ahci mode
 > >
 >=20
 > In my case, BIOS options are enhanced / legacy / disabled. I tried a=
ll
 > but of no use. So I am using enhanced to boot Fedora 13 kernel.

We need to see the complete kernel messages from a failed boot to
determine the root cause of that missing root device failure.

I suggest hooking up a null-modem serial cable to a second machine
and run minicom on that one to capture boot messages, but there may
be other ways to capture boot messages: netconsole? firewire?
