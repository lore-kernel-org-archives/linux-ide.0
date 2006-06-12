From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix oops caused rescanning NULL sdev
Date: Mon, 12 Jun 2006 10:23:58 -0400
Message-ID: <448D78FE.4020806@pobox.com>
References: <20060612135114.GC5751@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33172 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752011AbWFLOYD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jun 2006 10:24:03 -0400
In-Reply-To: <20060612135114.GC5751@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Zhao, Forrest" <forrest.zhao@intel.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Depending on timing, ata_scsi_dev_rescan() might encounter a device
> which is enabled but not yet attached to sdev.  On such cases, the
> original code caused oops.  This patch makes ata_scsi_dev_rescan()
> rescan only device which are attached to sdevs.
> 
> While at it, properly indent leading comment and add description about
> how it's synchronized with sdev attach/detach.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


