From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] SATA NCQ support
Date: Fri, 27 May 2005 03:37:31 -0400
Message-ID: <4296CE3B.3040504@pobox.com>
References: <20050527070353.GL1435@suse.de> <4296CAA8.9060307@pobox.com> <20050527073016.GO1435@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:47069 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261941AbVE0Hhk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 May 2005 03:37:40 -0400
In-Reply-To: <20050527073016.GO1435@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jens Axboe wrote:
> That is the typical case, ata_qc_new() succeeds but we cannot issue the
> command yet. So where do you want this logic placed? You cannot drop the
> host_lock in-between, as that could potentially change the situation.

ata_scsi_translate() in libata-scsi.c, in between the call to 
ata_scsi_qc_new() and ata_qc_issue().

something like:

	if (ata_scsi_qc_new() fails ||
	    (depth > 0 && ata_check_non_ncq_cmd()))
		complete SCSI command with 'queue full'

NOTE!

I just noticed a bug -- When ata_scsi_qc_new() fails, the code should 
complete the command with queue-full, but does not.

         qc = ata_scsi_qc_new(ap, dev, cmd, done);
         if (!qc)
                 return;

