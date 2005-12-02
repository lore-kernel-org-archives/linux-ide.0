From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SIL_QUIRK_MOD15WRITE workaround problem on 2.6.14
Date: Thu, 01 Dec 2005 21:01:00 -0500
Message-ID: <438FAADC.6060907@pobox.com>
References: <438BD351.60902@ucla.edu> <438D2792.9050105@gmail.com> <438D2DCC.4010805@pobox.com> <438D3AA8.9030504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:26845 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964778AbVLBCBH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Dec 2005 21:01:07 -0500
In-Reply-To: <438D3AA8.9030504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Ethan Chen <thanatoz@ucla.edu>, linux-kernel@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Linux-ide <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Ethan confirmed that it's 1095:3114.  Arghhh....  Maybe we should keep 
> m15w quirk for 3114's for the time being?  Better be slow than hang. 
> Whatever bug the m15w quirk was hiding.

A generic 'slow_down_io' module option is reasonable.

It is not appropriate to apply mod15write quirk to hardware that isn't 
affected by the chip bug.

A better solution is to write a 311x-specific interrupt handler.

	Jeff


