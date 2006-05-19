From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 06/13] libata-hp: implement bootplug
Date: Fri, 19 May 2006 12:09:08 -0400
Message-ID: <446DEDA4.9090608@pobox.com>
References: <11480537073172-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:13994 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932427AbWESQJY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 12:09:24 -0400
In-Reply-To: <11480537073172-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement bootplug - boot probing via hotplug path.  While loading,
> ata_host_add() simply schedules probing and invokes EH.  After EH
> completes, ata_host_add() scans and assicates them with SCSI devices.
> EH path is slightly modified to handle this (e.g. no autopsy during
> bootplug).  The SCSI part is left in ata_host_add() because it's
> shared with legacy path and to keep probing order as before (ATA scan
> all ports in host_set then attach all).
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK 4-6


