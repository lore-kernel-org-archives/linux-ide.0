From: Jeff Garzik <jeff@garzik.org>
Subject: Re: On SoC SATA controller driver implementation!!!
Date: Fri, 17 Sep 2010 14:23:30 -0400
Message-ID: <4C93B222.4040601@garzik.org>
References: <AANLkTin-bG72N9TSzRFOFYusa+9xZfYOA75zAP0chSFH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:39369 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756187Ab0IQSXf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Sep 2010 14:23:35 -0400
Received: by qyk33 with SMTP id 33so2708653qyk.19
        for <linux-ide@vger.kernel.org>; Fri, 17 Sep 2010 11:23:34 -0700 (PDT)
In-Reply-To: <AANLkTin-bG72N9TSzRFOFYusa+9xZfYOA75zAP0chSFH@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Murali N <nalajala.murali@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>

On 09/17/2010 05:54 AM, Murali N wrote:
> Hi All,
>
> I am implementing  a SATA driver for my SATA controller which is part of SoC.
> I had seen a generic AHCI controller driver in .35 (ahci_platform.c)
> which is used by SATA controllers part of the SoC and interacting to
> local bus.
>
> My doubts is:
> 1. Can i make use of above framework to implement my own controller
> driver? I know that i have to take care of the "init", "exit" and
> power management routines specific to my controller. Will this work?
> OR do i need to take care of any other additional considerations while
> implementing?

ahci_platform is not a framework, it is an AHCI driver, which uses the 
libata and libahci frameworks.

"will it work?" depends entirely on your controller's programming interface.


> I would like to see a reference drivers code which uses the platform
> AHCI controller driver(ahci_platform.c). Can anyone point me to the
> sources.
> My aim is to leverage already existing code as much as possible to
> make my controller works better.

ahci_platform.c and ahci.c use libahci.c framework.

Both use libata framework.

	Jeff


