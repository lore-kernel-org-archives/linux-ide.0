From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 11/16] libata-eh-fw: implement new EH scheduling via timeout
Date: Wed, 12 Apr 2006 18:36:54 -0400
Message-ID: <443D8106.4000607@pobox.com>
References: <1144762974340-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:26550 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932370AbWDLWhJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Apr 2006 18:37:09 -0400
In-Reply-To: <1144762974340-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement new EH scheduling from timeout.  ata_scsi_timedout() also
> takes care of the race condition in which scsi_eh_schedule_qc() sets
> ATA_QCFLAG_EH_SCHEDULED but fails to acutally schedule EH for the qc
> because it loses to timeout.
> 
> A timeout is HSM violation condition.  New EH assumes that on a
> timeout the state of the controller and devices are unknown and
> dangerous.  So, all active commands are aborted and the port is
> frozen.  Note that commands which get aborted this way don't have its
> qc->err_mask set and its retries count will be compensated.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

This is not always true:  With PCI IDE BMDMA devices, it is presumed 
that a DMA error will be handled by timeout.  For this case, the 
controller is in a known state.

	Jeff



