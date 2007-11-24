From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] sata_nv: fix ADMA ATAPI issues with memory over 4GB (v3)
Date: Fri, 23 Nov 2007 18:31:59 -0600
Message-ID: <474770FF.6040503@shaw.ca>
References: <47463534.9010100@shaw.ca> <4746F02D.2060204@rtr.ca>
 <BD261180E6D35F4D9D32F3E44FD3D901053E8542@EMPBEDEX.empirix.com>
 <474711FE.8040805@rtr.ca> <47476CB9.2040409@shaw.ca>
 <47476E31.2070801@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:26558 "EHLO
	pd3mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbXKXAcr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Nov 2007 19:32:47 -0500
In-reply-to: <47476E31.2070801@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, "Morrison, Tom" <tmorrison@empirix.com>, linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Jeff Garzik wrote:
> Robert Hancock wrote:
>> Based on a quick look at sata_mv it appears it sets a 64-bit DMA mask 
>> unconditionally, but for non-ATA_PROT_DMA commands (which includes all 
>> ATAPI), it just falls back to ata_qc_issue_prot which issues via the 
>> legacy SFF interface and can only handle 32-bit addressing. So yes, it 
>> appears to have a similar bug as sata_nv had.
> 
> 
> sata_mv doesn't do ATAPI at all...

Right.. missed that ATA_FLAG_NO_ATAPI. So these issues Tom is reporting 
are just with a normal SATA hard drive?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


