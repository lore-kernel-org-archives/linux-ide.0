From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream 1/2] libata: move command post processing to
 __ata_qc_complete()
Date: Fri, 12 Oct 2007 08:13:11 -0400
Message-ID: <470F64D7.9040604@garzik.org>
References: <20071012115631.GA11510@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50954 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753235AbXJLMNO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Oct 2007 08:13:14 -0400
In-Reply-To: <20071012115631.GA11510@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, ballen@gravity.phys.uwm.edu, andrew@ishiboo.com

Tejun Heo wrote:
> Some commands need post-processing after successful completion.  This
> was done in ata_scsi_qc_complete() till now but command post
> processing doesn't belong to SAT layer.  Move them to
> __ata_qc_complete() and, while at it, restructure a bit to ease adding
> post-processing for other commands.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

BTW, while doing the TEST UNIT READY emulation patch for ATA (recently 
withdrawn from libata-dev.git#upstream), I found a problem with the 
interface that was difficult to get around:  TEST UNIT READY simulation 
code really wants to look at the result TF of CHECK POWER MODE, even if 
ATA_ERR is asserted, before determining whether or not to call that 
command an error.

Maybe the EH scheduling could be moved until after ->complete_fn, to 
permit ->complete_fn users to manipulate qc->err_mask etc.?

	Jeff



