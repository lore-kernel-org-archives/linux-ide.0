From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/4] libata: separate out rw ATA taskfile building into
 ata_build_tf()
Date: Tue, 28 Nov 2006 04:17:15 -0500
Message-ID: <456BFE9B.7050709@pobox.com>
References: <11635120302199-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36483 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935744AbWK1JRR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 04:17:17 -0500
In-Reply-To: <11635120302199-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Separate out rw ATA taskfile building from ata_scsi_rw_xlat() into
> ata_build_tf().  This will be used to improve media error handling.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK, provided you name it ata_build_rw_tf() or ata_build_addr_tf() or 
somesuch


