From: Kay Sievers <kay@vrfy.org>
Subject: Re: [PATCH v2] libata: export host controller number thru /sys
Date: Thu, 24 Jan 2013 10:57:22 +0100
Message-ID: <CAPXgP1185830_HY6hwScvKGYxC0AU2ZXB7zWNz-9DMeYb=+AHA@mail.gmail.com>
References: <1358287662-24016-1-git-send-email-dmilburn@redhat.com>
 <CAPXgP12JEjksJz7eyvOmzAXh+nFPrEXEU_bsoff-u9bwiyipZg@mail.gmail.com>
 <50F71AE5.6050906@redhat.com> <CAPXgP11pk7xT+SzH9p1+Yj5C16ar0qFdZikg=67w37aS_V9W8Q@mail.gmail.com>
 <20130117182239.GA31009@dhcp-10-15-1-70.hsv.redhat.com> <CAPXgP10jOrO4ULwOusf80GiqqCydYykfcWaLjky6_fKFNR1PeA@mail.gmail.com>
 <20130121154909.GA5750@dhcp-10-15-1-70.hsv.redhat.com> <CAMHSBOXWkZTyH18goC6iS-S7VAmCuHJ9Wwhzy6kB1m5RKwFEAA@mail.gmail.com>
 <50FF0858.50504@redhat.com> <CAPXgP10YPOgdzJGCieY6G6CA5MTAYxBZrKPUX_ov+Ku4YE8mww@mail.gmail.com>
 <CAMHSBOWsby9TKgAeuO2Vp3=h-a==fBTHU9HGC9ZtiG1Rj_ULTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:59337 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab3AXJ5o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jan 2013 04:57:44 -0500
Received: by mail-wi0-f181.google.com with SMTP id hq4so262248wib.2
        for <linux-ide@vger.kernel.org>; Thu, 24 Jan 2013 01:57:43 -0800 (PST)
In-Reply-To: <CAMHSBOWsby9TKgAeuO2Vp3=h-a==fBTHU9HGC9ZtiG1Rj_ULTA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: David Milburn <dmilburn@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, coughlan <coughlan@redhat.com>, "fengguang.wu" <fengguang.wu@intel.com>

On Thu, Jan 24, 2013 at 8:55 AM, Gwendal Grignou <gwendal@google.com> wrote:
> I see. But this behavior """numbers which are entirely independent of
> driver probing order.""" is not consistent with the rest of scsi
> subsystem

Sure it is, in most interesting cases.

> for instance scsi_host are named using a global number as
> well; sas object naming is completely dependent on the probing order.

Right, but the host number is not interesting at all, it obviously
always depends on the order devices are probed. What's interesting is
lun, target and the like, and they are still just nice and local
numbers, not meaningless global counters.

> The idea behind using the global number is to be able to link ata
> objects to their pci object parent as they are named in dmesg, so that
> we see error messages in dmesg we could locate the whole topology.

Which is absolutely no reason to use global counters for things that
have a well-defined meaning like a device's port number. Nothing here
is limited to a single number,we have strings not numbers. :)
ATA can surely do what USB, PCI, everybody else, even SCSI itself
does, and append the real and meaningful numbers to the parent name,
and all will be meaningful and will be unique.

> The name of the object needs to contain <global port>.
> If we want to add <local port> , to be consistent with sas sysfs, I
> suggest <object_name><global port><separator><local port> syntax.
> <separator> is ':' for scsi transport, but I used '.' already, so we
> can continue with it.

Sure, we need to add something that makes the name unique in the
class, but we should also export the real names and not only the
artificial and meaningless counters. There is a good reason SCSI
repeats the "real" and meaningful numbers in the LUN 0:0:0:0 device
name, and ATA should just do something like that too. :)

Kay
