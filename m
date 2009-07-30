From: Jeff Garzik <jeff@garzik.org>
Subject: Re: hdparm-9.17 released, with experimental trim/wiper scripts for
   SSDs
Date: Thu, 30 Jul 2009 04:24:06 -0400
Message-ID: <4A7158A6.1090407@garzik.org>
References: <4A70DCB8.9000909@rtr.ca> <4A70DDC5.3000607@rtr.ca> <4A7149C6.4030508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50153 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139AbZG3IYK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Jul 2009 04:24:10 -0400
In-Reply-To: <4A7149C6.4030508@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Robert Hancock wrote:
> Yeah, according to the datasheet "The SiI3124 will decode the 8-bit ATA
> command at PRB offset 0x0a and automatically execute the default 
> protocol for the command. In certain cases it might be desirable to 
> specify a non-default protocol to be used, such as with vendor specific 
> device commands." The DSM command seems to be DMA data-out and the chip 
> likely doesn't know that command. I have to wonder why they decided to 
> use that design instead of just making the driver indicate the protocol 
> explicitly. In any case, it looks like the driver needs code to override 
> the protocol setting for this command. (Maybe we should just set the 
> protocol override for what we know the command is supposed to be in all 
> cases?)
> 
> Sil311x will have the same problem. The solution there seems to be to 
> execute a vendor-specific command to tell the controller what protocol 
> that command code uses. Some other controllers may have similar issues 
> if they are parsing the ATA command codes.. it's possible that some of 
> them might not support DSM/TRIM commands properly.


Yes, this is a common problem for many SATA controllers, for any new 
opcode -- and for SATA<->PATA bridges too, which also snoop the opcode 
to determine certain behaviors.

	Jeff


