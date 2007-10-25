From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] libata: relocate and fix post-command processing
Date: Thu, 25 Oct 2007 05:38:15 -0400
Message-ID: <47206407.4030908@garzik.org>
References: <20071025092244.GJ11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49352 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753674AbXJYJiR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 05:38:17 -0400
In-Reply-To: <20071025092244.GJ11853@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, andrew.m.paprocki@gmail.com, ballen@gravity.phys.uwm.edu

Tejun Heo wrote:
> Some commands need post-processing after successful completion.  This
> was done in ata_scsi_qc_complete() till now but this has the following
> problems.
> 
> * Post-command processing gets executed when qc is completed from EH.
>   Some qc's are retried from EH with zero err_mask and thus triggers
>   unnecessary/incorrect post-command processing.
> 
> * Command post processing doesn't belong to SAT layer.
> 
> * Link-wide revalidation was scheduled where device revalidation
>   suffices.
> 
> This patch moves post-command processing to success completion path of
> ata_qc_complete() which is travelled iff the command is going to be
> completed without passing through EH and updates post-command
> processing such that device-specific action is used.  While at it,
> restructure code a bit for readability.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied

now if only I had a way for the SAT to issue CHECK POWER MODE (used in 
TEST UNIT READY translation), and inspect qc->err_mask before EH gets 
its hands on it...  :)


