From: Marcos Souza <marcos.mage@gmail.com>
Subject: Re: [PATCH 3/3] drivers: ata: libata-scsi.c: Add function parameter documentation
Date: Tue, 8 Nov 2011 12:31:55 -0300
Message-ID: <CAGkUK2sbgPuetQnb+GCLK5JjL8CTe+b19tDMv7ECMuP2sjsUDw@mail.gmail.com>
References: <1320112216-23810-1-git-send-email-marcos.mage@gmail.com>
	<4EB036AD.8030707@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:49432 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab1KHPb5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2011 10:31:57 -0500
In-Reply-To: <4EB036AD.8030707@xenotime.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: jgarzik@pobox.com, linux-doc@vger.kernel.org, linux-ide@vger.kernel.org

ping?

2011/11/1, Randy Dunlap <rdunlap@xenotime.net>:
> On 10/31/2011 06:50 PM, Marcos Paulo de Souza wrote:
>> Add the documentation of parameters of ata_change_queue_depth to sil=
ence
>> the warning of make xmldocs
>>
>> Signed-off-by: Marcos paulo de Souza <marcos.mage@gmail.com>
>
> Acked-by: Randy Dunlap <rdunlap@xenotime.net>
>
> Thanks.
>
>> ---
>>  drivers/ata/libata-scsi.c |    4 ++++
>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 19ba770..5eceb23 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -1216,6 +1216,10 @@ void ata_scsi_slave_destroy(struct scsi_devic=
e
>> *sdev)
>>
>>  /**
>>   *	__ata_change_queue_depth - helper for ata_scsi_change_queue_dept=
h
>> + *	@ap: ATA port to which the device change the queue depth
>> + *	@sdev: SCSI device to configure queue depth for
>> + *	@queue_depth: new queue depth
>> + *	@reason: calling context
>>   *
>>   *	libsas and libata have different approaches for associating a sd=
ev to
>>   *	its ata_port.
>
>
> --
> ~Randy
> *** Remember to use Documentation/SubmitChecklist when testing your c=
ode ***
>


--=20
Marcos Paulo de Souza

*Porque uma vida sem desafios =E9 uma vida sem raz=E3o.*
