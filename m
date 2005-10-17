From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix broken Kconfig setup
Date: Mon, 17 Oct 2005 07:20:17 -0400
Message-ID: <435388F1.3050101@pobox.com>
References: <20051017044606.GA1266@havoc.gtf.org> <pan.2005.10.17.11.10.03.734742@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:59531 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751062AbVJQLUX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Oct 2005 07:20:23 -0400
In-Reply-To: <pan.2005.10.17.11.10.03.734742@smurf.noris.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Matthias Urlichs wrote:

Please use the standard 'group reply' feature of your mailer, to ensure 
that me and other people in the thread are CC'd.


> Hi, Jeff Garzik wrote:
> 
> 
>> config SCSI_SATA
>>-	tristate "Serial ATA (SATA) support"
>>+	bool "Serial ATA (SATA) support"
>>	depends on SCSI
> 
> 
> In other words, if SCSI is false then SCSI_SATA is false too.
> 
> So why are you doing
> 
> 
>>+if SCSI_SATA
>>+
>> config SCSI_SATA_AHCI
>> 	tristate "AHCI SATA support"
>>-	depends on SCSI_SATA && PCI
>>+	depends on SCSI && PCI
> 
> 
> and not just
>   +     depends on PCI
> 
> ?

Because if SCSI==m, then a low-level driver cannot be ==y.

	Jeff


