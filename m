From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH -mm] sata_nv: fix ATAPI in ADMA mode
Date: Mon, 27 Nov 2006 18:31:44 -0500
Message-ID: <456B7560.2020301@garzik.org>
References: <4569F703.8010209@shaw.ca> <20061127151541.16a93d49.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54441 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1758606AbWK0Xbz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Nov 2006 18:31:55 -0500
In-Reply-To: <20061127151541.16a93d49.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Nicolas.Mailhot@LaPoste.net

Andrew Morton wrote:
> On Sun, 26 Nov 2006 14:20:19 -0600
> Robert Hancock <hancockr@shaw.ca> wrote:
> 
>>  static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
>>  {
>>  	struct ata_host *host = dev_instance;
>>  	int i, handled = 0;
>> +	u32 notifier_clears[2];
>>  
>>  	spin_lock(&host->lock);
>>  
>>  	for (i = 0; i < host->n_ports; i++) {
>>  		struct ata_port *ap = host->ports[i];
>> +		notifier_clears[i] = 0;
> 
> Promise us that n_ports will never exceed 2?

ADMA spec is only defined for two channels, at least.

	Jeff



