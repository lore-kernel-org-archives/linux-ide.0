From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 03/12] libata-hp-prep: make some ata_device fields persistent
Date: Tue, 30 May 2006 00:00:34 -0400
Message-ID: <447BC362.6030607@pobox.com>
References: <11488839582400-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:7139 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751415AbWE3EAz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:00:55 -0400
In-Reply-To: <11488839582400-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Lifetimes of some fields span over device plugging/unplugging.  This
> patch moves such persistent fields to the top of ata_device and
> separate them with ATA_DEVICE_CLEAR_OFFSET.  Fields above the offset
> are initialized once during host initializatino while all other fields
> are cleared before hotplugging.  Currently ->ap, devno and part of
> flags are persistent.
> 
> Note that flags is partially cleared while holding host_set lock.
> This is to synchronize with later warm plug implementation which will
> record hotplug request in dev->flags.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK 1-3


