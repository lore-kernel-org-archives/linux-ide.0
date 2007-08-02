From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_qstor, pdc_adma, sata_sx4: convert to new EH
Date: Thu, 02 Aug 2007 08:27:57 -0400
Message-ID: <46B1CDCD.3010907@rtr.ca>
References: <20070724011404.GA14064@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4565 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655AbXHBM17 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Aug 2007 08:27:59 -0400
In-Reply-To: <20070724011404.GA14064@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Jeff Garzik wrote:
> This is just a refresh of the existing libata-dev.git#new-eh patches
> that convert all remaining old-EH drivers to new EH, against 2.6.23-rc1.
> 
> All three conversions are completely untested.  pdc_adma and sata_qstor
> need reviewing by someone with docs, in addition to testing.
> 
> Even "it still works" or "this patch breaks stuff" feedback from users
> is useful.

Tejun has some pdc_adma hardware..  ;)

I have a single sata_qstor board here somewhere,
and with luck will finally reinstall it next week
to test this stuff.

It's not normally a fun board to use, because the stupid onboard
BIOS extension adds about an extra 30 seconds to the BIOS boot sequence.

Cheers
