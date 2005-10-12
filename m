From: Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers
Date: Wed, 12 Oct 2005 16:38:25 +0100
Message-ID: <434D2DF1.9070709@gentoo.org>
References: <43146CC3.4010005@gentoo.org>	 <58cb370e05083008121f2eb783@mail.gmail.com>	 <43179CC9.8090608@gentoo.org> <58cb370e050927062049be32f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:31427 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964804AbVJLPi1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Oct 2005 11:38:27 -0400
In-Reply-To: <58cb370e050927062049be32f8@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, posting@blx4.net, vsu@altlinux.ru

Bartlomiej Zolnierkiewicz wrote:
> I would prefer /proc/via
> to vanish because it complicates driver needlessly (could you do
> this in separate patch?).

I'm working on a user-space app to provide the same info. It's nearly there 
but lacking some timing info.

Do you have any suggestions for how I can compute the value of via_clock in 
userspace? (i.e. some equivalent of system_bus_clock())

Thanks,
Daniel
