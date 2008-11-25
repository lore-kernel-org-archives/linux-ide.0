From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 2/2] libata: New driver for OCTEON SOC Compact Flash interface
 (v2).
Date: Tue, 25 Nov 2008 09:25:29 -0800
Message-ID: <492C3509.8010408@caviumnetworks.com>
References: <492B56B0.9030409@caviumnetworks.com> <1227577181-30206-2-git-send-email-ddaney@caviumnetworks.com> <492C2EE2.3090702@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7637 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108AbYKYRZk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Nov 2008 12:25:40 -0500
In-Reply-To: <492C2EE2.3090702@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org

Jeff Garzik wrote:
> David Daney wrote:
>> +
>> +/* Timing multiple used for configuring the boot bus DMA engine */
>> +#define CF_DMA_TIMING_MULT    4
>> +
>> +static struct scsi_host_template octeon_cf_sht = {
>> +    ATA_PIO_SHT(DRV_NAME),
>> +};
>> +
>> +static int mwdmamodes = 0x1f;    /* Support Multiword DMA 0-4 */
>> +module_param(mwdmamodes, int, 0444);
>> +MODULE_PARM_DESC(mwdmamodes,
>> +         "Bitmask controlling which MWDMA modes are supported.  "
>> +         "Default is 0x1f for MWDMA 0-4.");
> 
> Two comments:
> 
> * perhaps I missed this, but why is this module param necessary?  In 
> general we avoid things like this.
> 

The CF interface is on the SOC's Boot Bus.  Under some circumstances a 
  board wide hardware reset can occur while DMA is in progress, this 
results in the CF driving the Boot Bus while the processor is trying to 
read the boot code from the boot ROM which results in an unbootable 
system.  The only recourse is to cycle power to the board.  By allowing 
DMA to be disabled, we eliminate this problem.


> * I would avoid pretending to be an SFF DMA engine, and just code it in 
> the style of a custom DMA engine with SFF registers/mode, such as 
> sata_mv or sata_promise.
> 

It is certainly possible to do that, however I think it will result in a 
much larger driver.  If you strongly object, we would have to bite the 
bullet and do as you suggest.

David Daney
