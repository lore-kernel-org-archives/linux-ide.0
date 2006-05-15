From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 06/11] libata-eh: implement BMDMA EH
Date: Mon, 15 May 2006 14:38:00 +0100
Message-ID: <1147700280.26686.9.camel@localhost.localdomain>
References: <1147353687173-git-send-email-htejun@gmail.com>
	 <44665BEE.5020903@pobox.com>  <44666EA8.6050201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60564 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964874AbWEON0z
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 09:26:55 -0400
In-Reply-To: <44666EA8.6050201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

On Sul, 2006-05-14 at 08:41 +0900, Tejun Heo wrote: 
> else is lost.  Also, please note that most traditional IDE controllers 
> tend to have their own IRQ.

Not really. You normally have one IRQ per controller for any plug in
card and that is quite often shared.


