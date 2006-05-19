From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 11/14] libata-hp-prep: make ops->tf_read() optional
Date: Fri, 19 May 2006 11:11:48 -0400
Message-ID: <446DE034.6030103@pobox.com>
References: <11480445844029-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48806 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932329AbWESPME (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 11:12:04 -0400
In-Reply-To: <11480445844029-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Not all controllers have single TF image and ops->tf_read() is
> inappropriate for them.  Newly implemented hotplug probing will allow
> drivers for such controllers to get rid of ops->tf_read() completely.
> Make ops->tf_read() optional in core layer.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

NAK.

At the present time, the controller model expects to be able to obtain 
correct values from the shadow registers.  For FIS-based controllers, 
this may imply that the driver needs to maintain an accurate shadow 
register image, if the chip doesn't automatically supply one.

I think this is a quite reasonable expectation, given that ATA continues 
to have specifically defined shadow register outputs, and even in the 
face of NCQ, we have defined states where the shadow registers are 
available.

On this basis, attempts to make ->check_status() optional are also NAK'd.

	Jeff



