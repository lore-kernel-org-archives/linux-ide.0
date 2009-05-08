From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Fri, 08 May 2009 17:30:00 +0400
Message-ID: <4A0433D8.1000400@ru.mvista.com>
References: <49CCD7C4.8000207@inov.pt> <200905081404.29868.bzolnier@gmail.com> <4A0422B7.9010903@inov.pt> <200905081440.30147.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:32803 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751695AbZEHN3d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 May 2009 09:29:33 -0400
In-Reply-To: <200905081440.30147.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>, Alan Cox <alan@lxorguk.ukuu.org.uk>, H Hartley Sweeten <hartleys@visionengravers.com>, Ryan Mallon <ryan@bluewatersys.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>>>>>So you're saying I should support all PIO modes? If so, I would have to 
>>>>>>make conditional code, checking perhaps a module param to sort which PIO 
>>>>>>mode to use.

>>>>>If you advertise PIO0-PIO4 as supported the core IDE code will do all the
>>>>>work on figuring which modes are supported by the attached devices. You
>>>>>just need to be able to set them.

>>>>>Alan

>>>>Ok, so I've been studying that (I was quite lost for a time, I confess, 
>>>>I'm not that much familiar with the IDE subsystem, so please bear with 
>>>>me ;-) ).

>>>>So I need to set up a hook for 'set_pio_mode()', so that when the IDE 
>>>>subsystem detects a device and figures the most suitable PIO mode for 
>>>>the device, it will call the 'set_pio_mode' routine provided by the 
>>>>driver in order to configure the host controller for that PIO mode.

>>>>This also means that my host controller driver should always default to 
>>>>PIO Mode 0, as the initial host controller setup that is carried out by 
>>>>the 'init_hwif' routine, allowing devices to be detected. Afterwards, 
>>>>the IDE subsystem detects the most suitable PIO mode and calls 
>>>>'set_pio_mode' to change that configuration.

>>>>Am I correct on this?

>>>Yes! :)

>>>There is still a room for improvement though -- it would be better to fix
>>>IDE core to set PIO0 before probing devices for all host controllers.

>>>Moreover it seems that doing it this way would allow us to remove ->init_hwif
>>>method from this driver and do all necessary setup in ep93xx_ide_probe()
>>>(this controller is a single port one so theoretically there shouldn't be
>>>a need for having per-port ->init_hwif implementation).

>>So, I should remove the 'init_hwif' hook, and all the host controller 
>>setup would be made in the driver's probe method, correct?

> Yes, that would be preferred (of course given that you fix IDE core to do
> initial PIO0 setup first).

    Er, it's not that easy... Think about older CompactFlash cards (and 
ancient drives of course) that don't support setting explicit PIO modes 
(only the default one) since they don't support IORDY... and also 
ide_config_drive_speed() expects drive->id to be already filled in... So I 
guess you mean just calling set_pio_mode() prior to probing -- without 
setting the drive's own mode?

> Thanks,
> Bart

WBR, Sergei
