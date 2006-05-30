From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 07/12] libata-hp-prep: store attached SCSI device
Date: Tue, 30 May 2006 00:04:05 -0400
Message-ID: <447BC435.3010402@pobox.com>
References: <11488839582227-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:20707 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751426AbWE3EEQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:04:16 -0400
In-Reply-To: <11488839582227-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> dev->sdev doesn't hold reference to the SCSI device.  It's cleared
> when the SCSI device goes away.

ACK patches 5-7, though I consider the above quoted statement somewhat 
questionable...  _why_ not hold a reference?

	Jeff


