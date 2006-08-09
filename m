From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 04/17] libata: implement several LLD init helpers
Date: Wed, 09 Aug 2006 01:01:27 -0400
Message-ID: <44D96C27.20602@pobox.com>
References: <11549198402637-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:32926 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030472AbWHIFBg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 01:01:36 -0400
In-Reply-To: <11549198402637-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement the following init helpers.
> 
> * ata_host_set_alloc_pinfo():
> 	alloc host_set and init with the given port_info.
> * ata_host_set_alloc_pinfo_ar():
> 	alloc host_set and init with the given port_info array.
> * ata_host_set_add_ports_pinfo():
> 	add ports to host_set and init with the given port_info.
> * ata_host_set_add_ports_pinfo_ar():
> 	add ports to host_set and init with the given port_info array.
> * ata_host_set_request_irq():
> 	prep host_set for IRQ enabling and request IRQ.
> 
> These helpers will be used in new LLD init model.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

OK except the names are too long


