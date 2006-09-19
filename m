From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/20] libata: separate out ata_host_alloc() and ata_host_attach()
Date: Tue, 19 Sep 2006 14:48:21 +0900
Message-ID: <450F84A5.6000702@gmail.com>
References: <1155977971798-git-send-email-htejun@gmail.com> <450F7B44.4010300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.196]:46789 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750792AbWISFs3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Sep 2006 01:48:29 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1764099nzf
        for <linux-ide@vger.kernel.org>; Mon, 18 Sep 2006 22:48:28 -0700 (PDT)
In-Reply-To: <450F7B44.4010300@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> ACK in general, but minor nits are found in comments below.
> 
> Also, to make reviewing and git bisect easier, it would be nice to split 
> ata_host_attach() separation into another patch.

Okay, will try.

>>  drivers/ata/libata-core.c |  451 
>> ++++++++++++++++++++++++++++++---------------
>>  include/linux/libata.h    |    7 +
>>  2 files changed, 312 insertions(+), 146 deletions(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index d7bf4a1..eeb9dc6 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -5243,11 +5243,15 @@ void ata_dev_init(struct ata_device *dev
>>   *    ata_port_init - Initialize an ata_port structure
>>   *    @ap: Structure to initialize
>>   *    @host: Collection of hosts to which @ap belongs
>> - *    @ent: Probe information provided by low-level driver
>> - *    @port_no: Port number associated with this ata_port
>> + *    @ent: Probe information provided by low-level driver (optional)
>> + *    @port_no: Port number associated with this ata_port (optional)
> 
> I would perhaps note that port_no is require iff ent != NULL

Will do.

>> +int ata_host_add_ports(struct ata_host *host,
>> +               struct scsi_host_template *sht, int n_ports)
>> +{
>> +    int i;
>> +
>> +    if (host->n_ports || n_ports > ATA_MAX_PORTS)
>> +        return -EINVAL;
> 
> For what code path would host->n_ports be non-zero?

It's just an error check as this part of code is not very flexible (yet).

>> @@ -5755,8 +5909,10 @@ void ata_host_free(struct ata_host *host
>>      /* free */
>>      for (i = 0; i < host->n_ports; i++) {
>>          struct ata_port *ap = host->ports[i];
>> -        if (ap)
>> +        if (ap->pflags & ATA_PFLAG_SHOST_OWNER)
>>              scsi_host_put(ap->scsi_host);
>> +        else
>> +            kfree(ap);
> 
> Do we ever have a reason to care about ap->scsi_host in the SAS case?
> 
> It seems like we could kill ATA_PFLAG_SHOST_OWNER, and just test 
> scsi_host for NULL.

I thought SAS might want to use the field to back link ATA port to its 
SCSI host.  If that's not necessary, I'll drop the flag.

Thanks.

-- 
tejun
