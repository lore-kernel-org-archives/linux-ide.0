From: Brian King <brking@us.ibm.com>
Subject: Re: [PATCH 5/20] libata: implement several LLD init helpers
Date: Wed, 30 Aug 2006 16:16:56 -0500
Message-ID: <44F60048.90900@us.ibm.com>
References: <11559779712708-git-send-email-htejun@gmail.com> <44EB8111.4090901@us.ibm.com> <44F16B6B.7050207@gmail.com>
Reply-To: brking@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:47325 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932068AbWH3VRC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Aug 2006 17:17:02 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7ULGxeB013066
	for <linux-ide@vger.kernel.org>; Wed, 30 Aug 2006 17:16:59 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7ULGxvR141634
	for <linux-ide@vger.kernel.org>; Wed, 30 Aug 2006 17:16:59 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7ULGwxE021568
	for <linux-ide@vger.kernel.org>; Wed, 30 Aug 2006 17:16:58 -0400
In-Reply-To: <44F16B6B.7050207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, Brian.
> 
> Brian King wrote:
>> Tejun Heo wrote:
>>
>>> +static void __ata_host_init_pinfo(struct ata_host *host,
>>> +				  const struct ata_port_info **pinfo,
>>> +				  int n_ports, int pi_is_ar)
>>> +{
>>> +	int i;
>>> +
>>> +	if (host->private_data == NULL)
>>> +		host->private_data = pinfo[0]->private_data;
>>> +	host->ops = pinfo[0]->port_ops;
>>> +
>>> +	for (i = 0; i < host->n_ports; i++) {
>>> +		struct ata_port *ap = host->ports[i];
>>> +		const struct ata_port_info *pi;
>>> +
>>> +		if (pi_is_ar)
>>> +			pi = pinfo[i];
>>> +		else
>>> +			pi = pinfo[0];
>>> +
>>
>>> +		ap->pio_mask = pi->pio_mask;
>>> +		ap->mwdma_mask = pi->mwdma_mask;
>>> +		ap->udma_mask = pi->udma_mask;
>>> +		ap->flags |= pi->flags;
>>> +		ap->ops = pi->port_ops;
>> Could this bit be moved into ata_port_init and possibly change the
>> parameter list of ata_port_init to something like:
>>
>> void ata_port_init(struct ata_port *ap, struct ata_host *host,
>> 		   const struct ata_port_info *pinfo, unsigned int port_no)
>>
>> Then we could get rid of the struct ata_probe_ent stuff completely.
> 
> Hmmm... ata_port_init() is still exported only to support ata_sas_* 
> helpers.  Once the SAS helpers are converted to use new model, this 
> function will be made static or merged into ata_host_alloc().  In the 
> new init model, initialization is done by...
> 
> 1. allocate the host and associated ports with ata_host_alloc().  If 
> port number cannot be determined at this point.  ports can be added 
> later.  The returned ata_host has only the basic fields, which assume 
> the same initial values regardless of the user, initialized.
> 
> 2. initialize ata_host and associated ports appropriately.  During this 
> ata_host_add_ports() can be used to add ports if host has no ports yet.
> 
> 3. attach the initialized ata_host using ata_host_attach().

Are you suggesting SAS would follow this host initialization model as well?
ata_host_attach currently does not work for SAS since it calls scsi_add_host
for each ata port, but that is easily fixed. I think the broader question is
whether or not SAS should be calling ata_host_attach to probe all "ports" on
the SAS adapter. Since for SAS, the concept of a SATA "port" is really a
virtual and very dynamic thing, I'm inclined to think SAS users calling
ata_host_attach to scan all "ports" might not be the best approach.

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
