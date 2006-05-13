From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 19/22] libata: add dev->ap
Date: Sat, 13 May 2006 17:47:18 -0400
Message-ID: <446653E6.50504@pobox.com>
References: <11473487914070-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60550 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932347AbWEMVr0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 17:47:26 -0400
In-Reply-To: <11473487914070-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Add dev->ap which points back to the port the device belongs to.  This
> makes it unnecessary to pass @ap for silly reasons (e.g. printks).
> Also, this change is necessary to accomodate later PM support which
> will introduce ATA link inbetween port and device.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK patches 17 - 19.

I'm happy to see dev->ap added, I've been thinking that should happen 
for a while now.

	Jeff



