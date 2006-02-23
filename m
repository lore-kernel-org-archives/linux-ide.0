From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_sil.c, 3512 and SIL_QUIRK_MOD15WRITE
Date: Wed, 22 Feb 2006 22:35:58 -0500
Message-ID: <43FD2D9E.9020709@pobox.com>
References: <loom.20060222T182150-518@post.gmane.org> <43FD18F5.20002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:6543 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750726AbWBWDgF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Feb 2006 22:36:05 -0500
In-Reply-To: <43FD18F5.20002@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: =?UTF-8?B?Sm9uIEvDpXJlIEhlbGxhbg==?= <hellan@acm.org>, linux-ide@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

Tejun Heo wrote:
> According to the errata information from Silicon Image, SiI3512 does not 
> have m15w bug, neither does ST3200822AS. So, this must be something else 
> and you're not an isolated case. One of my friends reported the same 
> problem but I currently can't test it as he sold his motherboard 
> *really* fast. :-( So, it would be very nice if you can test fixes we'll 
> be able to come up with.
> 
> Carlos (Hi!), 3512 + some 7200.7 hangs. Can you think of any related 
> errata?


I think I'm going to start patching sata_sil.c with a todo list, just to 
keep track of things.

In particular, in ADDITION to errata recently sent by SiI, sata_sil 
could do better with reset, it needs to handle watchdog timer interrupt, 
and it desperately wants the irq-pio branch merged.

	Jeff



