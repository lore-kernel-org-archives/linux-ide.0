From: Lin Ming <minggr@gmail.com>
Subject: Re: Change in sysfs topology for libata
Date: Thu, 13 Sep 2012 23:38:52 +0800
Message-ID: <CAF1ivSbvMHZr0HLFaSDd7wkH3TtGZfcp7t8uO_es-yspOUfiuw@mail.gmail.com>
References: <CAMHSBOV360yPM6+aMSNKK_iNfMKCnu8dgz4kQLysA6fpo8R7aQ@mail.gmail.com>
	<CAMHSBOWz1z3faEXzL19d93QiiOjnb2Fhw2QEpCZtG3g2H1DdmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55703 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758251Ab2IMPix (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Sep 2012 11:38:53 -0400
Received: by lbbgj3 with SMTP id gj3so2054819lbb.19
        for <linux-ide@vger.kernel.org>; Thu, 13 Sep 2012 08:38:52 -0700 (PDT)
In-Reply-To: <CAMHSBOWz1z3faEXzL19d93QiiOjnb2Fhw2QEpCZtG3g2H1DdmQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, aaron.lu@intel.com

On Thu, Sep 13, 2012 at 4:07 AM, Gwendal Grignou <gwendal@google.com> wrote:
> [-Lin, +Lin]

CC Aaron@Intel

>
> On Wed, Sep 12, 2012 at 1:02 PM, Gwendal Grignou <gwendal@google.com> wrote:
>> Lin,
>>
>>  Commit 9a6d6a2ddabbd32c07f6a38b659e5f3db319fa5a introduces a change
>> in sysfs directory for ata controller:
>>
>> Before:
>>            /sys/devices/pci0000:00/0000:00:1f.2    (ahci controller)
>>            |-- ata1                                (ata port)
>>            |-- host0                               (scsi host)
>>               |-- target0:0:0                      (scsi target)
>>                   |-- 0:0:0:0                      (disk)
>>
>> After:
>>            /sys/devices/pci0000:00/0000:00:1f.2    (ahci controller)
>>            |-- ata1                                (ata port)
>>                |-- host0                           (scsi host)
>>                    |-- target0:0:0                 (scsi target)
>>                        |-- 0:0:0:0                 (disk)
>>
>> The problem is an ata controller, managed by libata, is still
>> considered by the kernel as a SCSI controller: diverging even more
>> from other SCSI controller sysfs layout is not a good idea.
>> When I wrote libata-transport.c, my plan was to be consistent with SAS
>> objects: for instance, for a SAS controller with a simple SAS topology
>> we have:
>>
>>
>> /sys/bus/pci/devices/0000\:0c\:00.0/
>> |-- host7/
>>     |-- phy-7:0
>>     |-- phy-7:1
>> ..
>>     |-- phy-7:7
>>     |-- port-7:0
>>         |-- end_device-7\:0
>>             |-- target7:0:0/
>>                 |-- 7:0:0:0
>>     |-- port-7:1
>> ..
>>
>> Similarly, I wanted to represent an ata_port [equivalent to SAS phy]
>> and ata_link [equivalent to SAS port] under scsi_host hostX object,
>> but as far as i remember, when I wrote the code that was not possible,
>> I could not find a clean way to share object references between libata
>> and scsi layer. That's why ata_port object was sitting alongside to
>> the scsi_host object. I have to see if it is possible now.
>>
>> In the meantime, what would be the impact to revert that commit?
>> Do you think melting libata sysfs object into scsi sysfs objects would
>> work with your changes related to pm?

The SATA disk runtime pm and ZPODD(Zero Power ODD) relies on the new
sysfs directory I introduced in commit 9a6d6a2.

Could you show me what's the sysfs directory structure after libata
sysfs object melted into scsi sysfs objects?

Thanks,
Lin Ming

>>
>> Thanks,
>>
>> Gwendal.
