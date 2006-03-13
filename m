From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] libata crashes on incorrectly initialised ports
Date: Mon, 13 Mar 2006 11:00:35 +0100
Message-ID: <441542C3.50205@suse.de>
References: <44153810.10702@suse.de> <44153AAB.1000201@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:26813 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750952AbWCMKAh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Mar 2006 05:00:37 -0500
In-Reply-To: <44153AAB.1000201@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Hannes Reinecke wrote:
>> Hi all,
>>
>> Randy found an interesting usage of the label 'err_out' in
>> libata-core.c:ata_device_add().
>>
>> 'err_out' is meant to be called to teardown existing sysfs entries.
>> As such is it clearly wrong to call it if the sysfs registration fai=
ls.
>>
>> Please apply.
>>
>> Cheers,
>>
>> Hannes
>>
>>
>> --------------------------------------------------------------------=
----
>>
>> From: Hannes Reinecke <hare@suse.de>
>> Subject: libata crashes on incorrectly initialized ports
>>
>> Randy Dunlap noted:
>> With the update ahci I am getting these messages (typed by
>> me, no serial port for console), but ata2 drive is not present (!?):
>>
>> ata2: could not start DMA engine
>> BUG: unable to handle kernel NULL pointer dereference at virtual
>> address 00000000
>>
>> plus a Call Trace like so (names only transcribed here):
>> class_device_del
>> class_device_unregister
>> scsi_remove_host
>> ata_host_remove
>> ata_device_add
>> ahci_init_one
>> ... normal pci driver init/register functions ...
>>
>>
>> The label 'err_out' is used twice; the first usage of which is wrong
>> as there is not host registered in sysfs which we could deregister.
>> In fact, we haven't done anything (yet) so we might as well return
>> here.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>
>> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
>> index ab3257a..42e5c40 100644
>> --- a/drivers/scsi/libata-core.c
>> +++ b/drivers/scsi/libata-core.c
>> @@ -4578,7 +4578,7 @@ int ata_device_add(const struct ata_prob
>> =20
>>          ap =3D ata_host_add(ent, host_set, i);
>>          if (!ap)
>> -            goto err_out;
>> +            return 0;
>=20
> NAK: This patch adds memory leaks.
>=20
> The clear intent of the error handling was to clean up host_set and t=
he
> ports allocated so far.  'return 0' just leaks all that stuff, rather
> than performing the incorrect error handling ;-)
>=20
Hmm. Okay.
> AFAICT, all the error handling at the err_out label is correct, save =
for
> one detail:  do_unregister argument passed to ata_host_remove() shoul=
d
> be zero for the err_out callsite we are discussing.
>=20
Not quite: ata_host_remove can _not_ be called with the first argument
being NULL.

This leads to another interesting question:
Do we allow for non-consecutive ports?
Ie should it be possible for host_ent->port[1] to fail, but
host_ent->port[2] to be present and useable?

The current code doesn't allow for that either; but if it's disallowed
we can just tear down all ports after the first failed one.
Which isn't handled currently, too :-)
The current code will fail if not all ports found in host_ent->ports ar=
e
useable. Which seems to be the case here.

Awaiting insight.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstra=DFe 5				+49 911 74053 688
90409 N=FCrnberg				http://www.suse.de

