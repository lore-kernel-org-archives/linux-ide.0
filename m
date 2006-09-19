From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/20] libata: implement several LLD init helpers
Date: Tue, 19 Sep 2006 14:57:27 +0900
Message-ID: <450F86C7.3050305@gmail.com>
References: <11559779712708-git-send-email-htejun@gmail.com> <450F7D11.7030007@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.194]:10212 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932189AbWISF5f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Sep 2006 01:57:35 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1764799nzf
        for <linux-ide@vger.kernel.org>; Mon, 18 Sep 2006 22:57:34 -0700 (PDT)
In-Reply-To: <450F7D11.7030007@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>> +int ata_host_add_ports_pinfo_ar(struct ata_host *host,
>> +                const struct ata_port_info **pinfo_ar,
>> +                int n_ports)
>> +{
>> +    int rc;
>> +
>> +    rc = ata_host_add_ports(host, pinfo_ar[0]->sht, n_ports);
>> +    if (rc == 0)
>> +        __ata_host_init_pinfo(host, pinfo_ar, n_ports, 1);
>> +    return rc;
>> +}
> 
> Just implement a single version for each case (array and non-array). The 
> LLDD can pass in an indication of whether or not to copy the first 
> element into succeeding elements.

Okay.

>> +static void __ata_host_free_irqs(struct ata_host *host, void **markerp)
>> +{
>> +    struct ata_irq *airq, *tmp;
>> +
>> +    list_for_each_entry_safe(airq, tmp, &host->irq_list, node) {
>> +        if (!markerp || airq->marker == *markerp) {
>> +            list_del(&airq->node);
>> +            free_irq(airq->irq, airq->dev_id);
>> +            kfree(airq);
>> +        }
>> +    }
>> +}
> 
> Ugh, I just don't like this at all.  I would much rather have a hook or 
> entry point where the LLDD is given the capability to call request_irq() 
> itself, in some exotic situations.  Then, helpers provided by libata can 
> handle the common cases.  That's much more modular than the above.

What I was trying to do was to make libata keep track of allocated 
resources including IRQ handlers.  While implementing this patch, I've 
located several bugs failing to free / or freeing twice resources in the 
init-failure path or detach path.

With iomap, multiple IRQ handlers and different IRQ modes, the resource 
management is getting more complex.  Bugs acquiring the resources are 
easy to catch but the other way around is not.  So, I wanted to push all 
the 'free's into libata helpers such that LLDs can call single or a few 
libata free helpers and be done with it - or, more importantly, the free 
code can be boilerplate part shared across all/most LLDs.

That's where the above IRQ handler list comes from.  The marker thing is 
to make different libata core modules (pci, legacy, etc...) deallocate 
its own and completely hidden from LLDs.

I'd like to know your opinion on this.

Thanks.

-- 
tejun
