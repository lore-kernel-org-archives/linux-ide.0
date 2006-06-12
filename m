From: Trilobit <trilo@gmx.net>
Subject: kernel module sata_via
Date: Mon, 12 Jun 2006 18:17:21 +0200
Message-ID: <20060612181721.64fd46b2@jvc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:53665 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752121AbWFLQQc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jun 2006 12:16:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi,

I'd like to hotplug sata hardisks on a running Linux system.
This works with unloading and then reloading the sata_via module.
But therefore the kernel needs the option module unloading, which I decide to be unsafe for a server.

So my question: is it possible to get the module to rescan the sata bus now and then?
It would be apropriate to trigger the update process externalywith cron or so.
(I thought of something like sending the signal HUP to a process, so it rereads his config,
but only HUP would be send to thes ata_via kernel module, something like that)

The next thing is: when sata_via is started and there is no harddisk connected to the sata host, this host isn't known to the system.
Only unloading/loading the module with a hardisk connected to this host resolves this.
So is there an module parameter which forces the detection of hosts even if no harddisk is connected to it?
Maybe the some scsi-probe utilities might work to solve my first problem.

Or maybe there is some entirely other solution to make hotplug of sata harddisks work with my VIA-SATA controller?

I need hotplug for an Linux-Raid-server  system.


kernel used to test this is (for now) the 2.6.12.2 from kernel.org
distribution is the actual Debian stable.
sata controller is the: VIA VT6420 sata raid controller
on an Asus A7V880 motherboard

thx for advice 
Mario
