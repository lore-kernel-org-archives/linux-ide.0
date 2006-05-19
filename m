From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 07/14] libata-hp-prep: store attached SCSI device
Date: Fri, 19 May 2006 11:04:43 -0400
Message-ID: <446DDE8B.4000104@pobox.com>
References: <11480445842821-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33190 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932333AbWESPEy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 11:04:54 -0400
In-Reply-To: <11480445842821-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Add device persistent field dev->sdev and store the attached SCSI
> device.  With hotplug, libata needs to know the attached SCSI device
> to offline and detach it, but scsi_device_lookup() cannot be used
> because libata will reuse SCSI ID numbers - dead but not gone devices
> (due to zombie opens, etc...) interfere with the lookup.
> 
> dev->sdev doesn't hold reference to the SCSI device.  It's cleared
> when the SCSI device goes away.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK, though begin to think about when SCSI simulation is made optional...

	Jeff



