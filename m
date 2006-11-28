From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: make sure sdev doesn't go away while rescanning
Date: Tue, 28 Nov 2006 04:05:28 -0500
Message-ID: <456BFBD8.90700@pobox.com>
References: <20061122022131.GU2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:8579 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935732AbWK1JFa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 04:05:30 -0500
In-Reply-To: <20061122022131.GU2184@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> ata_scsi_dev_rescan() doesn't synchronize against SCSI device detach
> and the target sdev might go away in the middle.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK


