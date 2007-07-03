From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 11/12] libata: schedule probing after SError access failure
 during autopsy
Date: Tue, 03 Jul 2007 10:35:58 -0400
Message-ID: <468A5ECE.3010009@garzik.org>
References: <11832836183512-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60561 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753849AbXGCOgB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 10:36:01 -0400
In-Reply-To: <11832836183512-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> If SError isn't accessible, EH can't tell whether hotplug has happened
> or not.  Report SError read failure with AC_ERR_OTHER and schedule
> probing with hardreset.  This will be mainly useful for PMPs.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-eh.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)

What if the LLDD told us hotplug happened?

Even though sata_promise has SError, it should be noted that hotplug 
under sata_promise is not signalled through normal means, but by a 
special vendor-specific register


