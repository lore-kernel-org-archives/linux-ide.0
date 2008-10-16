From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] sgiioc4: kill useless address checks
Date: Thu, 16 Oct 2008 14:08:05 +0400
Message-ID: <48F71285.8080308@ru.mvista.com>
References: <200810152329.20095.sshtylyov@ru.mvista.com> <48F70C37.3060800@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:54502 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752941AbYJPKIK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Oct 2008 06:08:10 -0400
In-Reply-To: <48F70C37.3060800@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, jeremy@sgi.com

Hello, I wrote:

>> would always evaluate as true:
>>   
> The driver performs a number of checks on the virtual/physical 
> addresses which
>
>    Oops, s/true/false/, of course -- except in sgiioc4_read_status()

   I got totally muddled. :-/
  The checks indeed evaluate as true except in ide_dma_sgiioc4().

>>   guarantees that 'ctrl_port' and 'irq_port' parameters are never 0;
>>
>> - in sgiioc4_read_status(), we always read the IDE status register, 
>> so there's
>>   no need to check the register's address (must be a leftover from 
>> the times
>>   when this function implemented the INB() method);
>>
>> - in ide_dma_sgiioc4(), 'dma_base' can never be 0 as IOC4_DMA_OFFSET 
>> is not 0.
>>
>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> - for sgiioc4_init_hwif_ports(), its caller, 
> sgiioc4_ide_setup_pci_device(),

MBR, Sergei


