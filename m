From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 05/11] libata-eh: implement new EH
Date: Sat, 13 May 2006 18:19:19 -0400
Message-ID: <44665B67.5000602@pobox.com>
References: <114735368767-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48007 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932365AbWEMWT1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 18:19:27 -0400
In-Reply-To: <114735368767-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement new EH.  The exported interface is ata_do_eh() which is to
> be called from ->error_handler and performs the following steps to
> recover the failed port.
> 
> ata_eh_autopsy() : analyze SError/TF, determine the cause of failure
> 		   and required recovery actions and record it in
> 		   ap->eh_context
> ata_eh_report()	 : report the failure to user
> ata_eh_recover() : perform recovery actions described in ap->eh_context
> ata_eh_finish()	 : finish failed qcs
> 
> LLDDs can customize error handling by modifying eh_context before
> calling ata_do_eh() or, if necessary, doing so inbetween each major
> steps by calling each step explicitly.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK patches 3-5


