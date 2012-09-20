From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: Change in sysfs topology for libata
Date: Thu, 20 Sep 2012 10:01:46 +0800
Message-ID: <20120920020145.GA23210@mint-spring.sh.intel.com>
References: <CAMHSBOV360yPM6+aMSNKK_iNfMKCnu8dgz4kQLysA6fpo8R7aQ@mail.gmail.com>
 <CAMHSBOWz1z3faEXzL19d93QiiOjnb2Fhw2QEpCZtG3g2H1DdmQ@mail.gmail.com>
 <CAF1ivSbvMHZr0HLFaSDd7wkH3TtGZfcp7t8uO_es-yspOUfiuw@mail.gmail.com>
 <CAMHSBOX416qXKpC_z_X+pfHs_Uo3Lw-JbjcwOFGYyKB1vdnW-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1416 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751598Ab2ITCCB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Sep 2012 22:02:01 -0400
Content-Disposition: inline
In-Reply-To: <CAMHSBOX416qXKpC_z_X+pfHs_Uo3Lw-JbjcwOFGYyKB1vdnW-w@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>, Lin Ming <minggr@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Wed, Sep 19, 2012 at 05:48:50PM -0700, Gwendal Grignou wrote:
> On Thu, Sep 13, 2012 at 8:38 AM, Lin Ming <minggr@gmail.com> wrote:
> > On Thu, Sep 13, 2012 at 4:07 AM, Gwendal Grignou <gwendal@google.com> wrote:
> >> [-Lin, +Lin]
> >
> > CC Aaron@Intel

Thanks Lin.

> > Could you show me what's the sysfs directory structure after libata
> > sysfs object melted into scsi sysfs objects?
> 
> I am testing my patches, but the path to a block device will be as follow:
> /sys/device/pci0000:00/0000:00:06.0/0000:09:00.0/host0/port1/link1/dev1.0/target0:0:0/0:0:0:0/block/sda
> 
> If you have a port multiplier, a disk behind it - port 4 of the pmp
> for instance:
> /sys/device/pci0000:00/0000:00:06.0/0000:09:00.0/host5/port6/link6.4/dev6.4.0/target5:4:0/5:4:0:0/block/sde
> while the port multiplier itself would be at
> /sys/device/pci0000:00/0000:00:06.0/0000:09:00.0/host5/port6/link6/dev6.0
> 
> For reference, in a simple SAS topology, block device paths are like:
> /sys/device/pci0000:00/0000:00:08.0/0000:0b:00.0/host6/port-6:5/end_device-6:5/target6:0:5/6:0:5:0/block/sdg
> 
> Does it make sense to you?

Looks good to me. I will test the code once you sent out, thanks.

And I think the following commit will no longer be needed once this
change is done:
commit ae0751ffc77e7f21629970fdab5528c573e637f8
[SCSI] add flag to skip the runtime PM calls on the host

-Aaron
