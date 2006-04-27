From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 12/13] libata-hp: store attached SCSI device
Date: Thu, 27 Apr 2006 05:20:48 -0400
Message-ID: <44508CF0.10105@pobox.com>
References: <1144764382410-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41891 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964985AbWD0JUw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Apr 2006 05:20:52 -0400
In-Reply-To: <1144764382410-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Add device persistent field dev->sdev and store the attached SCSI
> device.  With hotplug, libata needs to know the attached SCSI device
> to offline and detach it, but scsi_device_lookup() cannot be used
> because libata will reuse SCSI ID numbers - dead but not gone devices
> (due to zombie opens, etc...) interfere with the lookup.
> 
> dev->sdev doesn't hold reference to the SCSI device.  dev->sdev is
> cleared when the SCSI device goes away.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK, though we'll have to revisit once libata supports direct use of 
block layer for ATA disks.  But given other email it sounds like you are 
thinking about this already.

	Jeff



