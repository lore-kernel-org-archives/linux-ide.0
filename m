From: Gwendal Grignou <gwendal@google.com>
Subject: Re: Change in sysfs topology for libata
Date: Wed, 19 Sep 2012 17:48:50 -0700
Message-ID: <CAMHSBOX416qXKpC_z_X+pfHs_Uo3Lw-JbjcwOFGYyKB1vdnW-w@mail.gmail.com>
References: <CAMHSBOV360yPM6+aMSNKK_iNfMKCnu8dgz4kQLysA6fpo8R7aQ@mail.gmail.com>
	<CAMHSBOWz1z3faEXzL19d93QiiOjnb2Fhw2QEpCZtG3g2H1DdmQ@mail.gmail.com>
	<CAF1ivSbvMHZr0HLFaSDd7wkH3TtGZfcp7t8uO_es-yspOUfiuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:61600 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab2ITAsw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Sep 2012 20:48:52 -0400
Received: by qaas11 with SMTP id s11so3948459qaa.19
        for <linux-ide@vger.kernel.org>; Wed, 19 Sep 2012 17:48:51 -0700 (PDT)
In-Reply-To: <CAF1ivSbvMHZr0HLFaSDd7wkH3TtGZfcp7t8uO_es-yspOUfiuw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Ming <minggr@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, aaron.lu@intel.com

On Thu, Sep 13, 2012 at 8:38 AM, Lin Ming <minggr@gmail.com> wrote:
> On Thu, Sep 13, 2012 at 4:07 AM, Gwendal Grignou <gwendal@google.com> wrote:
>> [-Lin, +Lin]
>
> CC Aaron@Intel
>
>>
>> On Wed, Sep 12, 2012 at 1:02 PM, Gwendal Grignou <gwendal@google.com> wrote:
>>> Lin,
>>>
>>>  Commit 9a6d6a2ddabbd32c07f6a38b659e5f3db319fa5a introduces a change
>>> in sysfs directory for ata controller:
>>>
>>> Before:
>>>            /sys/devices/pci0000:00/0000:00:1f.2    (ahci controller)
>>>            |-- ata1                                (ata port)
>>>            |-- host0                               (scsi host)
>>>               |-- target0:0:0                      (scsi target)
>>>                   |-- 0:0:0:0                      (disk)
>>>
>>> After:
>>>            /sys/devices/pci0000:00/0000:00:1f.2    (ahci controller)
>>>            |-- ata1                                (ata port)
>>>                |-- host0                           (scsi host)
>>>                    |-- target0:0:0                 (scsi target)
>>>                        |-- 0:0:0:0                 (disk)
>>>
>>> The problem is an ata controller, managed by libata, is still
>>> considered by the kernel as a SCSI controller: diverging even more
>>> from other SCSI controller sysfs layout is not a good idea.
>>> When I wrote libata-transport.c, my plan was to be consistent with SAS
>>> objects: for instance, for a SAS controller with a simple SAS topology
>>> we have:
>>>
>>>
>>> /sys/bus/pci/devices/0000\:0c\:00.0/
>>> |-- host7/
>>>     |-- phy-7:0
>>>     |-- phy-7:1
>>> ..
>>>     |-- phy-7:7
>>>     |-- port-7:0
>>>         |-- end_device-7\:0
>>>             |-- target7:0:0/
>>>                 |-- 7:0:0:0
>>>     |-- port-7:1
>>> ..
>>>
>>> Similarly, I wanted to represent an ata_port [equivalent to SAS phy]
>>> and ata_link [equivalent to SAS port] under scsi_host hostX object,
>>> but as far as i remember, when I wrote the code that was not possible,
>>> I could not find a clean way to share object references between libata
>>> and scsi layer. That's why ata_port object was sitting alongside to
>>> the scsi_host object. I have to see if it is possible now.
>>>
>>> In the meantime, what would be the impact to revert that commit?
>>> Do you think melting libata sysfs object into scsi sysfs objects would
>>> work with your changes related to pm?
>
> The SATA disk runtime pm and ZPODD(Zero Power ODD) relies on the new
> sysfs directory I introduced in commit 9a6d6a2.
>
> Could you show me what's the sysfs directory structure after libata
> sysfs object melted into scsi sysfs objects?

I am testing my patches, but the path to a block device will be as follow:
/sys/device/pci0000:00/0000:00:06.0/0000:09:00.0/host0/port1/link1/dev1.0/target0:0:0/0:0:0:0/block/sda

If you have a port multiplier, a disk behind it - port 4 of the pmp
for instance:
/sys/device/pci0000:00/0000:00:06.0/0000:09:00.0/host5/port6/link6.4/dev6.4.0/target5:4:0/5:4:0:0/block/sde
while the port multiplier itself would be at
/sys/device/pci0000:00/0000:00:06.0/0000:09:00.0/host5/port6/link6/dev6.0

For reference, in a simple SAS topology, block device paths are like:
/sys/device/pci0000:00/0000:00:08.0/0000:0b:00.0/host6/port-6:5/end_device-6:5/target6:0:5/6:0:5:0/block/sdg

Does it make sense to you?

Gwendal.



>
> Thanks,
> Lin Ming
>
>>>
>>> Thanks,
>>>
>>> Gwendal.
