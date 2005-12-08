From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_sil: combined irq + LBT DMA patch for testing
Date: Thu, 08 Dec 2005 15:38:14 -0500
Message-ID: <439899B6.2000302@pobox.com>
References: <20051204011953.GA16381@havoc.gtf.org> <7744a2840512061147i5c101455g9ed99624aca344dd@mail.gmail.com> <43987A28.8070509@mandriva.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:683 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932361AbVLHUiT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Dec 2005 15:38:19 -0500
In-Reply-To: <43987A28.8070509@mandriva.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Backlund <tmb@mandriva.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Thomas Backlund wrote:
> Richard Bollinger wrote:
>>> ata1: BUG: SG size underflow
>>> ata1: status=0x50 { DriveReady SeekComplete }
> 
> 
> and onde by one the raid devices got deactivated until the full freeze...


I think I know what's going on with the 'SG size underflow' thingy, give 
me a few days to come up with a fix.

	Jeff


