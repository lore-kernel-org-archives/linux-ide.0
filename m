From: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 03/12] libata: separate out ata_host_alloc() and ata_host_attach()
Date: Wed, 14 Mar 2007 10:25:36 -0500
Message-ID: <45F813F0.9070003@linux.vnet.ibm.com>
References: <11734389353424-git-send-email-htejun@gmail.com> <45F5D35C.6000408@linux.vnet.ibm.com> <45F63F4A.9090607@gmail.com> <45F72706.7070606@linux.vnet.ibm.com> <45F77EB3.5000108@gmail.com>
Reply-To: brking@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:49715 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932112AbXCNP0z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Mar 2007 11:26:55 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2EFQs6H021363
	for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 11:26:54 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2EFPcoR085986
	for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 11:25:38 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2EFPb6O008942
	for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 11:25:38 -0400
In-Reply-To: <45F77EB3.5000108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Brian King wrote:
>> For SAS, the scsi_host pointer in the ata port is NULL today, since libata
>> is really not managing the scsi host, the LLDD is. I think the initialization
>> model we want for SAS is a little different than the one you are heading
>> towards on SATA. For SAS, I think we just want to be able to alloc/init
>> and delete/destroy a SATA device a they show up on the transport,
>> without tying it to initialization of the ata host. And this set of
>> patches doesn't necessarily prevent that...
> 
> Yeap, I tried to keep SAS bridge functions working.  If SAS doesn't need 
> the host abstraction and wanna do stuff per-port basis, ata_port_alloc() 
> can be directly exported and separating out per-port register routine 
> shouldn't be too difficult, but I do think it would still be beneficial 
> to have ata_host structure in SAS case too for code simplicity if not 
> for anything else.

I think having the ata_host structure for SAS is fine. It's just a matter
of how much of what ends up in it actually gets used for SAS.

>> Regarding holding all command execution on the host while performing eh,
>> that doesn't seem to be a huge issue from my perspective, not sure if
>> this would have a larger negative impact on others... Generally speaking,
>> we shouldn't be entering eh very often, and it should only be happening
>> if something went wrong. The biggest issue here might be ATAPI devices,
>> since they tend to report more errors during normal running. The request
>> sense for these devices for SAS is done without entering eh today. Would
>> you want to move this into eh as well?
> 
> No, not for SAS.  The reasons why I put sense requesting to EH were...
> 
> 1. to make fast path code straight forward (no qc reusing dance)
> 
> 2. in native ATA, we have per-port EH thread so sharing is not a problem.
> 
> As #2 is not true in SAS case, I think keeping sense requesting out of 
> EH is the right thing to do here.  I still think that it's much 
> simpler/reliable to handle any exception case in a separate thread.  I 
> think this in the long term should be solved by making EH per-request 
> queue (we of course will need mechanism to synchronize several EHs so 
> that we can take host-wide EH actions).

Agreed.

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
