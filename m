From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_sil performance
Date: Thu, 02 Dec 2004 06:29:59 -0500
Message-ID: <41AEFCB7.9030108@pobox.com>
References: <1101680376.5337.5.camel@kahuna-ws.robhughes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2508 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261583AbULBLaO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Dec 2004 06:30:14 -0500
In-Reply-To: <1101680376.5337.5.camel@kahuna-ws.robhughes.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob Hughes <rob@robhughes.com>
Cc: linux-ide@vger.kernel.org

Rob Hughes wrote:
> Jeff,
> 
> I can understand why you did what you did looking through the code, but
> my drive, a Seagate ST3120026AS, does not need this fix. Further,
> performance has gone from 50-60 Mbit transfers to 14-15 Mbit transfers
> between the 2.6.8 and 2.6.9 kernels. And as a side not, hdparm is
> reporting "HDIO_GET_MULTCOUNT failed: Inappropriate ioctl for device"
> when doing either -I or -i as of this kernel version.

multcount is for PIO transfers, don't worry about it.  If you are doing 
PIO you are already slower than 15Mbit.


> If you're already working on a patch for this, I'd be happy to test it.
> Also, it should be noted that I'm running FC3, so I'm not sure how much
> that will play into this.

Unfortunately at this time we must judge the situation as "you just 
haven't hit the problem yet".  Yeah, the performance hit sucks, but the 
kernel _must_ be conservative and err on the side of caution.

	Jeff


