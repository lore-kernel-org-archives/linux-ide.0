From: Sander <sander@humilis.net>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Date: Wed, 3 May 2006 20:39:43 +0200
Message-ID: <20060503183943.GA31435@favonius>
References: <20060321121354.GB24977@favonius> <Pine.LNX.4.64.0603211316580.3622@g5.osdl.org> <20060322090006.GA8462@favonius> <200603220950.11922.lkml@rtr.ca> <20060322170959.GA3222@favonius> <4428BCBF.2050000@pobox.com> <20060503121643.GA21882@favonius> <4458A52D.30100@rtr.ca> <20060503133239.GA11811@favonius> <4458DE81.6040603@rtr.ca>
Reply-To: sander@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ookhoi.xs4all.nl ([213.84.114.66]:4829 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1750716AbWECSjp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 May 2006 14:39:45 -0400
Content-Disposition: inline
In-Reply-To: <4458DE81.6040603@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: sander@humilis.net, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Mark Lord wrote (ao):
> Sander wrote:
> >The message "PCI ERROR; PCI IRQ cause=0x40000100" gives no result in
> >Google. Could this be a broken or miss-seated controller?
> 
> Yes. Those bits mean: "no target response within 4 PCI clock cycles".
> 
> In English, I believe the translation is "dead/disconnected controller".

Thank you for explaining the error and the translation. 

I'll try to re-seat it then, and replace it when that fails.

	With kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
