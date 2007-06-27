From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Failed to IDENTIFY SATA harddrive on sata_sil24
Date: Wed, 27 Jun 2007 14:16:47 -0400
Message-ID: <4682A98F.7020803@garzik.org>
References: <6a3d41200706270814o7675909dtbdafe4a4fa68943c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42431 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752655AbXF0SQt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Jun 2007 14:16:49 -0400
In-Reply-To: <6a3d41200706270814o7675909dtbdafe4a4fa68943c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Tsai <bthomas.tsai@gmail.com>
Cc: linux-ide@vger.kernel.org

Thomas Tsai wrote:
> Does anyone familiar with SiliconImage 3132 SATA controller?
> I'm running siliconimage 3132 as e-Sata controller on my ARM-based board.
> My kernel version is 2.6.18.6. I built libata and sata_sil24 as kernel 
> module.
> After I insert libata and sata_sil24 module, and plug external
> harddrive via e-Sata.
> sata_sil24.c can detect phy changed, and found a ATA device.
> And then it will issue IDENTIFY(0xec) command but time out to get
> command completion.
> And Sil3132 seems dead or enter into an unknown state.Since it will
> not issue any interrupts even I remove and replug the e-Sata cable.

Your platform's interrupt delivery is broken.

	Jeff



