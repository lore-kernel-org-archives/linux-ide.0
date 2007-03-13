From: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 03/12] libata: separate out ata_host_alloc() and ata_host_attach()
Date: Tue, 13 Mar 2007 17:34:46 -0500
Message-ID: <45F72706.7070606@linux.vnet.ibm.com>
References: <11734389353424-git-send-email-htejun@gmail.com> <45F5D35C.6000408@linux.vnet.ibm.com> <45F63F4A.9090607@gmail.com>
Reply-To: brking@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:47564 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933774AbXCMWev (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Mar 2007 18:34:51 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2DMYnKo010802
	for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 18:34:49 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2DMYnRf298218
	for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 18:34:49 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2DMYnQB028518
	for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 18:34:49 -0400
In-Reply-To: <45F63F4A.9090607@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Association to SCSI host is done via pointer now even for native ATA
> case, so this should be easier for SAS.  What I'm worried about is how
> EH gets invoked.  libata depends on EH to do a lot of things including
> probing, requesting sense data, etc.  How should this work?

For SAS, the scsi_host pointer in the ata port is NULL today, since libata
is really not managing the scsi host, the LLDD is. I think the initialization
model we want for SAS is a little different than the one you are heading
towards on SATA. For SAS, I think we just want to be able to alloc/init
and delete/destroy a SATA device a they show up on the transport,
without tying it to initialization of the ata host. And this set of
patches doesn't necessarily prevent that...

> SAS attached libata port shares EH with the SAS SCSI host, right?  How can

Right.

> we connect SAS EH with libata EH and would it be okay for libata EH hold
> the SCSI EH (thus holding all command execution on the host) to handle
> ATA exceptions?

Currently, ipr calls ata_do_eh from its eh_device_reset_handler function.
This seems to work well enough with the testing that I've done, but it
would certainly be nice to get to a more layered EH approach, where we
could possibly have pluggable error handlers for different device types.

Regarding holding all command execution on the host while performing eh,
that doesn't seem to be a huge issue from my perspective, not sure if
this would have a larger negative impact on others... Generally speaking,
we shouldn't be entering eh very often, and it should only be happening
if something went wrong. The biggest issue here might be ATAPI devices,
since they tend to report more errors during normal running. The request
sense for these devices for SAS is done without entering eh today. Would
you want to move this into eh as well?

Brian


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
