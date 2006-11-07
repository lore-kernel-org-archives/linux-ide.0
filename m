From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/2 #upstream] ahci: honor PORTS_IMPL on ICH8s
Date: Tue, 07 Nov 2006 18:54:11 +0900
Message-ID: <455057C3.2040905@gmail.com>
References: <20061102031723.GV13677@htj.dyndns.org> <20061102032059.GW13677@htj.dyndns.org> <20061106010505.GJ15897@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:29351 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1754165AbWKGJyT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Nov 2006 04:54:19 -0500
Received: by nz-out-0102.google.com with SMTP id z3so1078126nzf
        for <linux-ide@vger.kernel.org>; Tue, 07 Nov 2006 01:54:19 -0800 (PST)
In-Reply-To: <20061106010505.GJ15897@curie-int.orbis-terrarum.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Robin H. Johnson wrote:
> On Thu, Nov 02, 2006 at 12:20:59PM +0900, Tejun Heo wrote:
>> @@ -1439,7 +1453,7 @@ static int ahci_host_init(struct ata_pro
>>  	struct ahci_host_priv *hpriv = probe_ent->private_data;
>>  	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
>>  	void __iomem *mmio = probe_ent->mmio_base;
>> -	unsigned int i, using_dac;
>> +	unsigned int i, cap_n_ports, using_dac;
>>  	int rc;
>>  
>>  	rc = ahci_reset_controller(mmio, pdev);
>> @@ -1448,10 +1462,34 @@ static int ahci_host_init(struct ata_pro
>>  
>>  	hpriv->cap = readl(mmio + HOST_CAP);
>>  	hpriv->port_map = readl(mmio + HOST_PORTS_IMPL);
>> -	probe_ent->n_ports = ahci_nr_ports(hpriv->cap);
>> +	cap_n_ports = ahci_nr_ports(hpriv->cap);
>>  
>>  	VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n",
>> -		hpriv->cap, hpriv->port_map, probe_ent->n_ports);
>> +		hpriv->cap, hpriv->port_map, n_ports);
> n_ports is undefined here. Should be cap_n_ports instead.
> 
> Other than that, the two patches work perfectly.

Thanks.  Forgot to drop that part again.  I'll post updated patch in a 
few hours.

-- 
tejun
