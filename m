From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCHSET] [PATCHSET] new Power Management for libata, take 2
Date: Mon, 26 Jun 2006 14:49:21 +0800
Message-ID: <1151304561.7132.173.camel@forrest26.sh.intel.com>
References: <11511486183271-git-send-email-htejun@gmail.com>
	 <1151304179.7132.169.camel@forrest26.sh.intel.com>
	 <449F8597.7090605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12159 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751286AbWFZHCS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 03:02:18 -0400
In-Reply-To: <449F8597.7090605@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On Mon, 2006-06-26 at 15:58 +0900, Tejun Heo wrote:

> > Does it make sense to add port-wide PM callbacks in this patch set?
> 
> Yes, it does.  I removed those because none of the currently converted 
> drivers used it.  Does AHCI need them?  If so, I'll add them.  Are you 
> gonna do ACPI stuff w/ those callbacks?
> 

Yeap, both AHCI suspend/resume patch and ACPI-SATA patch need these
port-wide callbacks.
It's appreciated if you could add them in your PM patch :)

Thanks,
Forrest
