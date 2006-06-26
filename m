From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] [PATCHSET] new Power Management for libata, take 2
Date: Mon, 26 Jun 2006 03:20:17 -0400
Message-ID: <449F8AB1.70804@pobox.com>
References: <11511486183271-git-send-email-htejun@gmail.com>	 <1151304179.7132.169.camel@forrest26.sh.intel.com>	 <449F8597.7090605@gmail.com> <1151304561.7132.173.camel@forrest26.sh.intel.com> <449F88A9.30109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:61089 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964857AbWFZHU3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jun 2006 03:20:29 -0400
In-Reply-To: <449F88A9.30109@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> I don't know much about 
> ACPI but don't we need to do it regardless of LLDs?

Yes.  Though generally ACPI only ever has knowledge of the drives 
directly attached to the motherboard.

	Jeff


