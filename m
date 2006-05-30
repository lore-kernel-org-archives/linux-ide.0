From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 01/13] libata-hp: implement ata_eh_detach_dev()
Date: Tue, 30 May 2006 00:17:24 -0400
Message-ID: <447BC754.9030506@pobox.com>
References: <1148884735680-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:8164 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751482AbWE3ERf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:17:35 -0400
In-Reply-To: <1148884735680-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement ata_eh_detach_dev().  This function is responsible for
> detaching an ATA device and offlining the associated SCSI device
> atomically so that the detached device is not accessed after ATA
> detach is complete.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK


