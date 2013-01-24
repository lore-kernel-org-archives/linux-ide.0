From: Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH v2] libata: export host controller number thru /sys
Date: Wed, 23 Jan 2013 23:55:14 -0800
Message-ID: <CAMHSBOWsby9TKgAeuO2Vp3=h-a==fBTHU9HGC9ZtiG1Rj_ULTA@mail.gmail.com>
References: <1358287662-24016-1-git-send-email-dmilburn@redhat.com>
	<CAPXgP12JEjksJz7eyvOmzAXh+nFPrEXEU_bsoff-u9bwiyipZg@mail.gmail.com>
	<50F71AE5.6050906@redhat.com>
	<CAPXgP11pk7xT+SzH9p1+Yj5C16ar0qFdZikg=67w37aS_V9W8Q@mail.gmail.com>
	<20130117182239.GA31009@dhcp-10-15-1-70.hsv.redhat.com>
	<CAPXgP10jOrO4ULwOusf80GiqqCydYykfcWaLjky6_fKFNR1PeA@mail.gmail.com>
	<20130121154909.GA5750@dhcp-10-15-1-70.hsv.redhat.com>
	<CAMHSBOXWkZTyH18goC6iS-S7VAmCuHJ9Wwhzy6kB1m5RKwFEAA@mail.gmail.com>
	<50FF0858.50504@redhat.com>
	<CAPXgP10YPOgdzJGCieY6G6CA5MTAYxBZrKPUX_ov+Ku4YE8mww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37712 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab3AXHzQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jan 2013 02:55:16 -0500
Received: by mail-wi0-f181.google.com with SMTP id hq4so174289wib.14
        for <linux-ide@vger.kernel.org>; Wed, 23 Jan 2013 23:55:14 -0800 (PST)
In-Reply-To: <CAPXgP10YPOgdzJGCieY6G6CA5MTAYxBZrKPUX_ov+Ku4YE8mww@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kay Sievers <kay@vrfy.org>
Cc: David Milburn <dmilburn@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, coughlan <coughlan@redhat.com>, "fengguang.wu" <fengguang.wu@intel.com>

I see. But this behavior """numbers which are entirely independent of
driver probing order.""" is not consistent with the rest of scsi
subsystem: for instance scsi_host are named using a global number as
well; sas object naming is completely dependent on the probing order.
The idea behind using the global number is to be able to link ata
objects to their pci object parent as they are named in dmesg, so that
we see error messages in dmesg we could locate the whole topology.

The name of the object needs to contain <global port>.
If we want to add <local port> , to be consistent with sas sysfs, I
suggest <object_name><global port><separator><local port> syntax.
<separator> is ':' for scsi transport, but I used '.' already, so we
can continue with it.

Gwendal.


On Tue, Jan 22, 2013 at 8:29 PM, Kay Sievers <kay@vrfy.org> wrote:
>
> On Tue, Jan 22, 2013 at 10:44 PM, David Milburn <dmilburn@redhat.com> wrote:
> > Gwendal Grignou wrote:
> >>
> >> <resent as text 2>
> >> Although your solution works, it breaks the current numbering. The X
> >> in <pci-path>/ataX/link<..> has changed meaning, and it is not obvious
> >> to an untrained eyes.
> >> If we are willing to change, could we reconsider the patches in
> >> "Insert ATA transport objects in SCSI syfs topology"? These patches
> >> also makes udev rules easier to write, given we have scsi host id
> >> available in the path.
> >
> > Hi Gwendal,
> >
> > I applied
> >
> > http://marc.info/?l=linux-ide&m=134911579601940&w=2
> > http://marc.info/?l=linux-ide&m=134911580102060&w=2
> > http://marc.info/?l=linux-ide&m=134931181222435&w=2
> >
> > # find . -name 'sd*' -print
> > ./0000:00:1e.0/0000:05:01.0/host6/port7/link7.0/dev7.0.0/target6:0:0/6:0:0:0/block/sdd
> > ./0000:00:1e.0/0000:05:01.0/host6/port7/link7.0/dev7.0.0/target6:0:0/6:0:0:0/block/sdd/sdd1
> > ./0000:00:1e.0/0000:05:01.0/host6/port7/link7.0/dev7.0.0/target6:0:0/6:0:0:0/block/sdd/sdd2
> > ./0000:00:1e.0/0000:05:01.0/host6/port7/link7.3/dev7.3.0/target6:3:0/6:3:0:0/block/sde
> > ./0000:00:1e.0/0000:05:01.0/host6/port7/link7.3/dev7.3.0/target6:3:0/6:3:0:0/block/sde/sde1
> > ./0000:00:1e.0/0000:05:01.0/host6/port7/link7.3/dev7.3.0/target6:3:0/6:3:0:0/block/sde/sde2
> > ./0000:00:1f.2/host1/port2/link2/dev2.0/target1:0:0/1:0:0:0/block/sda
> > ./0000:00:1f.2/host1/port2/link2/dev2.0/target1:0:0/1:0:0:0/block/sda/sda1
> > ./0000:00:1f.2/host1/port2/link2/dev2.0/target1:0:0/1:0:0:0/block/sda/sda2
> >
> > ./0000:00:1f.2/host3/port4/link4/dev4.0/target3:0:0/3:0:0:0/block/sdb/sdb1
> > ./0000:00:1f.2/host3/port4/link4/dev4.0/target3:0:0/3:0:0:0/block/sdb/sdb2
> > ./0000:00:1f.2/host4/port5/link5/dev5.0/target4:0:0/4:0:0:0/block/sdc
> > ./0000:00:1f.2/host4/port5/link5/dev5.0/target4:0:0/4:0:0:0/block/sdc/sdc1
> >
> > I think Kay still wants us to avoid using the global ap->print_id, he
> > expects local
> > port numbers per controller, for instance, port7 is really port1.
>
> Right, I need numbers which are entirely independent of driver probing
> order. The should all start locally and span multiple independent
> controllers/drivers/devices.
>
> I kind of like it when the topology appears directly in the device hierarchy.
>
> We could append the local number just as as .<local port> to the
> existing number, or we dould add a sysfs attribute(file) to the
> device, containing just the local port number.
>
> Both should work to retrieve the information and compose a string out
> of it, to create a by-path/ symlink, which will not change when the
> multiple drivers are loaded in different orders, or if devices are
> unplugged and re-plugged during runtime of the machine.
>
> Thanks,
> Kay
