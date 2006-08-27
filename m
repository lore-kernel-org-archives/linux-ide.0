From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/20] libata: implement several LLD init helpers
Date: Sun, 27 Aug 2006 18:52:43 +0900
Message-ID: <44F16B6B.7050207@gmail.com>
References: <11559779712708-git-send-email-htejun@gmail.com> <44EB8111.4090901@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:33543 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932070AbWH0Jwv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Aug 2006 05:52:51 -0400
Received: by py-out-1112.google.com with SMTP id n25so2041219pyg
        for <linux-ide@vger.kernel.org>; Sun, 27 Aug 2006 02:52:51 -0700 (PDT)
In-Reply-To: <44EB8111.4090901@us.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: brking@us.ibm.com
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Hello, Brian.

Brian King wrote:
> Tejun Heo wrote:
> 
>> +static void __ata_host_init_pinfo(struct ata_host *host,
>> +				  const struct ata_port_info **pinfo,
>> +				  int n_ports, int pi_is_ar)
>> +{
>> +	int i;
>> +
>> +	if (host->private_data == NULL)
>> +		host->private_data = pinfo[0]->private_data;
>> +	host->ops = pinfo[0]->port_ops;
>> +
>> +	for (i = 0; i < host->n_ports; i++) {
>> +		struct ata_port *ap = host->ports[i];
>> +		const struct ata_port_info *pi;
>> +
>> +		if (pi_is_ar)
>> +			pi = pinfo[i];
>> +		else
>> +			pi = pinfo[0];
>> +
> 
> 
>> +		ap->pio_mask = pi->pio_mask;
>> +		ap->mwdma_mask = pi->mwdma_mask;
>> +		ap->udma_mask = pi->udma_mask;
>> +		ap->flags |= pi->flags;
>> +		ap->ops = pi->port_ops;
> 
> Could this bit be moved into ata_port_init and possibly change the
> parameter list of ata_port_init to something like:
> 
> void ata_port_init(struct ata_port *ap, struct ata_host *host,
> 		   const struct ata_port_info *pinfo, unsigned int port_no)
> 
> Then we could get rid of the struct ata_probe_ent stuff completely.

Hmmm... ata_port_init() is still exported only to support ata_sas_* 
helpers.  Once the SAS helpers are converted to use new model, this 
function will be made static or merged into ata_host_alloc().  In the 
new init model, initialization is done by...

1. allocate the host and associated ports with ata_host_alloc().  If 
port number cannot be determined at this point.  ports can be added 
later.  The returned ata_host has only the basic fields, which assume 
the same initial values regardless of the user, initialized.

2. initialize ata_host and associated ports appropriately.  During this 
ata_host_add_ports() can be used to add ports if host has no ports yet.

3. attach the initialized ata_host using ata_host_attach().

The ata_host_alloc_pinfo[_ar]() functions are just helpers which perform 
#1 and part of #2 as ata_port_info is handy for many LLDs.

For SAS helpers, I don't think using pinfo helpers is necessary.  Just 
initializing the above fields manually in SAS helper or SAS LLD should 
do.  The pinfo helpers are specifically for this purpose and doesn't 
allow delayed port addition.

Also, note that probe_ent is still there only for SAS helpers.  If you 
take a look at normal SATA init path, no probe_ent is used.  Only 
ata_port_init() deals with it and usual SATA path calls it with null 
probe_ent.

Thanks.

-- 
tejun
