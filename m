From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2] ata: pata_at91.c bugfix for high master clock
Date: Fri, 24 Dec 2010 13:30:58 -0500
Message-ID: <4D14E6E2.3080501@pobox.com>
References: <1292099846-24528-1-git-send-email-plyatov@gmail.com>	 <4D04D2E2.20100@ru.mvista.com> <1292180579.8737.12.camel@homepc> <4D05FD4C.9040200@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:46111 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854Ab0LXSbF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Dec 2010 13:31:05 -0500
In-Reply-To: <4D05FD4C.9040200@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: plyatov@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, geomatsi@gmail.com, nicolas.ferre@atmel.com, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, christian.glindkamp@taskit.de, ryan@bluewatersys.com, pgsellmann@portner-elektronik.at

On 12/13/2010 06:02 AM, Sergei Shtylyov wrote:
> On 12-12-2010 22:02, Igor Plyatov wrote:
>>>> static const struct ata_timing initial_timing =
>>>> - {XFER_PIO_0, 70, 290, 240, 600, 165, 150, 600, 0};
>>>> + {XFER_PIO_0, 70, 290, 240, 600, 165, 150, 0, 600, 0};
>
>>> BTW, you haven't described this in the changelog...
>
>> Here is just a typo fixed for the ata_timing structure. This typo does
>> not have influence on the driver operation, but I do not like to leave
>> such a negligible problem as it is.
>
> You at least should have noted that in the changelog. And as the change
> is unrelated to the other changes you're doing, it's a good practice to
> put it into a separate patch.

Agreed...


