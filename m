From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 04/17] libata: implement several LLD init helpers
Date: Wed, 09 Aug 2006 14:08:21 +0900
Message-ID: <44D96DC5.8030707@gmail.com>
References: <11549198402637-git-send-email-htejun@gmail.com> <44D96C27.20602@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:17483 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030478AbWHIFI0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Aug 2006 01:08:26 -0400
Received: by py-out-1112.google.com with SMTP id z74so183124pyg
        for <linux-ide@vger.kernel.org>; Tue, 08 Aug 2006 22:08:25 -0700 (PDT)
In-Reply-To: <44D96C27.20602@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Implement the following init helpers.
>>
>> * ata_host_set_alloc_pinfo():
>>     alloc host_set and init with the given port_info.
>> * ata_host_set_alloc_pinfo_ar():
>>     alloc host_set and init with the given port_info array.
>> * ata_host_set_add_ports_pinfo():
>>     add ports to host_set and init with the given port_info.
>> * ata_host_set_add_ports_pinfo_ar():
>>     add ports to host_set and init with the given port_info array.
>> * ata_host_set_request_irq():
>>     prep host_set for IRQ enabling and request IRQ.
>>
>> These helpers will be used in new LLD init model.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> OK except the names are too long

hoping to do s/host_set/host/g....

-- 
tejun
