From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 03/12] libata: separate out ata_host_alloc() and ata_host_attach()
Date: Wed, 14 Mar 2007 13:48:51 +0900
Message-ID: <45F77EB3.5000108@gmail.com>
References: <11734389353424-git-send-email-htejun@gmail.com> <45F5D35C.6000408@linux.vnet.ibm.com> <45F63F4A.9090607@gmail.com> <45F72706.7070606@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:54653 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933823AbXCNEs5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 00:48:57 -0400
Received: by py-out-1112.google.com with SMTP id a29so11362pyi
        for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 21:48:56 -0700 (PDT)
In-Reply-To: <45F72706.7070606@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: brking@linux.vnet.ibm.com
Cc: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Hello, Brian.

Brian King wrote:
> Tejun Heo wrote:
>> Association to SCSI host is done via pointer now even for native ATA
>> case, so this should be easier for SAS.  What I'm worried about is how
>> EH gets invoked.  libata depends on EH to do a lot of things including
>> probing, requesting sense data, etc.  How should this work?
> 
> For SAS, the scsi_host pointer in the ata port is NULL today, since libata
> is really not managing the scsi host, the LLDD is. I think the initialization
> model we want for SAS is a little different than the one you are heading
> towards on SATA. For SAS, I think we just want to be able to alloc/init
> and delete/destroy a SATA device a they show up on the transport,
> without tying it to initialization of the ata host. And this set of
> patches doesn't necessarily prevent that...

Yeap, I tried to keep SAS bridge functions working.  If SAS doesn't need 
the host abstraction and wanna do stuff per-port basis, ata_port_alloc() 
can be directly exported and separating out per-port register routine 
shouldn't be too difficult, but I do think it would still be beneficial 
to have ata_host structure in SAS case too for code simplicity if not 
for anything else.

>> SAS attached libata port shares EH with the SAS SCSI host, right?  How can
> 
> Right.
> 
>> we connect SAS EH with libata EH and would it be okay for libata EH hold
>> the SCSI EH (thus holding all command execution on the host) to handle
>> ATA exceptions?
> 
> Currently, ipr calls ata_do_eh from its eh_device_reset_handler function.
> This seems to work well enough with the testing that I've done, but it
> would certainly be nice to get to a more layered EH approach, where we
> could possibly have pluggable error handlers for different device types.

That's an unexpected usage of ata_do_eh() but I can see how that works 
and using ata_do_eh() for that purpose actually makes sense.  Most SCSI 
related dancing is done before and after ata_do_eh() and ata_do_eh() 
only deals with ATA qc's (except for scsi_eh_finish_cmd() called to 
finish failed qc's but these are still for only scmds associated with qcs).

In the future, we might need to separate those direct 
scsi_eh_finish_cmd() calls out of ata_do_eh() so that ata_do_eh() really 
deals with libata qc proper but that change shouldn't be too difficult 
for SAS.

> Regarding holding all command execution on the host while performing eh,
> that doesn't seem to be a huge issue from my perspective, not sure if
> this would have a larger negative impact on others... Generally speaking,
> we shouldn't be entering eh very often, and it should only be happening
> if something went wrong. The biggest issue here might be ATAPI devices,
> since they tend to report more errors during normal running. The request
> sense for these devices for SAS is done without entering eh today. Would
> you want to move this into eh as well?

No, not for SAS.  The reasons why I put sense requesting to EH were...

1. to make fast path code straight forward (no qc reusing dance)

2. in native ATA, we have per-port EH thread so sharing is not a problem.

As #2 is not true in SAS case, I think keeping sense requesting out of 
EH is the right thing to do here.  I still think that it's much 
simpler/reliable to handle any exception case in a separate thread.  I 
think this in the long term should be solved by making EH per-request 
queue (we of course will need mechanism to synchronize several EHs so 
that we can take host-wide EH actions).

Thanks.

-- 
tejun
