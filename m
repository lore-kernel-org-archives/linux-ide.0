From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 07/12] libata-hp-prep: store attached SCSI device
Date: Tue, 30 May 2006 13:55:39 +0900
Message-ID: <447BD04B.6000706@gmail.com>
References: <11488839582227-git-send-email-htejun@gmail.com> <447BC435.3010402@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:42219 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932143AbWE3Ezq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 May 2006 00:55:46 -0400
Received: by wr-out-0506.google.com with SMTP id i7so1024956wra
        for <linux-ide@vger.kernel.org>; Mon, 29 May 2006 21:55:45 -0700 (PDT)
In-Reply-To: <447BC435.3010402@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> dev->sdev doesn't hold reference to the SCSI device.  It's cleared
>> when the SCSI device goes away.
> 
> ACK patches 5-7, though I consider the above quoted statement somewhat 
> questionable...  _why_ not hold a reference?

libata shouldn't affect the lifetime of the scsi device.  When the sdev 
disappears, dev->sdev should go too.  It's easy to carry an extra 
reference but it wouldn't mean anything - the reference will be 
increased on attach and should be decreased with the device lifetime 
reference, so I thought it would be better to make it explicit that 
libata doesn't affect sdev's lifetime by not holding any extra reference 
to it.

-- 
tejun
