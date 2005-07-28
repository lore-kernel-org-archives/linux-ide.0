From: Siddharth Taneja <staneja@packetdesign.com>
Subject: Re: ICH6R support 2.4.20
Date: Wed, 27 Jul 2005 20:06:39 -0700
Message-ID: <42E84BBF.10806@packetdesign.com>
References: <42E6EBA1.8080902@packetdesign.com> <42E6F47C.4070001@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dns.packetdesign.com ([65.192.41.10]:28932 "EHLO
	mailman.packetdesign.com") by vger.kernel.org with ESMTP
	id S261272AbVG1DGZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Jul 2005 23:06:25 -0400
In-Reply-To: <42E6F47C.4070001@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:

> Siddharth Taneja wrote:
>
>> Hi,
>>
>> I am trying to port our software system (uses a 2.4.20 kernel) to a 
>> new platform which has a ICH6R controller. Due to some reasons we 
>> cannot update our kernel to a more recent one (probably 2.4.27) which 
>> has libata support in it. I can successfully patch the kernel (after 
>> some modifications) with the 2.4.26-libata patch and get the system 
>> up and running using the drivers/ide code. But I cannot seem to get 
>> the ata_piix (scsi layer) working (does not patch cleanly). Is there 
>> a patch available for 2.4.20 that can get the ICH6R support. Or is 
>> there a way to get the dma mode enabled with the drivers/ide code?
>
>
> Turn off combined mode, and PATA DMA will start working.
>
>     Jeff
>
>
>
Hi Jeff,

Thanks for the reply.

I tried turning off the combined mode but in vain. I still cannot get 
DMA enabled. Let me just tell you a little bit where I am. I am using 
the native ide support to get the system up (by adding the necessary pci 
ids + modification from the libata patch to the piix.c). I cannot use 
the ata_piix implementation as I have not found a clean patch for a 
2.4.20 kernel. Any ideas?

Any suggestions are welcome.

Sid
