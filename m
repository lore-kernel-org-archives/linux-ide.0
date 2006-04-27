From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 07/13] libata-hp: implement ap->orig_sata_spd_limit
Date: Thu, 27 Apr 2006 05:19:52 -0400
Message-ID: <44508CB8.7030903@pobox.com>
References: <114476438172-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37539 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965001AbWD0JT6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Apr 2006 05:19:58 -0400
In-Reply-To: <114476438172-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Add ap->orig_sata_spd_limit and initialize it once during the boot
> initialization (or driver load initialization).  ap->sata_spd_limit is
> reset to ap->orig_sata_spd_limit on hotplug.  This prevents limits
> introduced by earlier devices from affecting new devices.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Rather than "orig_" call it "hw_" or similar.  This is similar to the 
block layer's max_sectors and max_hw_sectors situation.

	Jeff



