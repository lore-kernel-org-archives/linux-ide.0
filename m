From: David Milburn <dmilburn@redhat.com>
Subject: Re: AHCI backplane errors in 2.6.27
Date: Wed, 19 Nov 2008 13:17:49 -0600
Message-ID: <4924665D.4090300@redhat.com>
References: <efeafa350811180733h6115dbc9t5a33abf55e774388@mail.gmail.com> <87abbw9hm1.fsf@cutlass.ping.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060702060901090008070501"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:45422 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753901AbYKSTSI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Nov 2008 14:18:08 -0500
In-Reply-To: <87abbw9hm1.fsf@cutlass.ping.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Frank D. Cringle" <fdc-lide@cutlass.ping.de>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060702060901090008070501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Frank D. Cringle wrote:
> Lazy <lazy404@gmail.com> writes:
>> When booting 2.6.27-rc1 kernel on out intel SR1530HSH ( Quad core Xeon X3320)
>> Sata controller is ICH9r running in AHCI mode with newest bios.
>>
>> After loading ahci driver backplane leds go amber which indicates a
>> non fatal error according to my intel resseller.
> 
> I see the same effect on a "FUJITSU SIEMENS PRIMERGY TX150 S6" which
> also has a ICH9r, running with the fake megaraid disabled in the bios.
> This has 4 hotswap drive bays. When I boot from drive 0, the remaining
> drives all blink their orange fault led.

ahci_sw_activity_blink should only be changing the state of
the activity led only when emp->activity has changed.

 From the sata ahci spec for Byte 2-3 of the led message

The LED bit locations are:
        Bits 2:0 - Activity LED (may be driven by hardware)
        Bits 5:3 - Vendor Specific LED (e.g. locate)
        Bits 8:6 - Vendor Specific LED (e.g. fault)
        Bits 15:9 - Reserved

Does this patch (against 2.6.27) make a difference?

Thanks,
David

> 
> It is possible to suppress the blinking with the boot parameter
> ahci.ahci_em_messages=0.
> 


--------------060702060901090008070501
Content-Type: text/x-patch;
 name="linux-2.6-ahci-blink.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6-ahci-blink.patch"

diff -Nurp linux-2.6.27.orig/drivers/ata/ahci.c linux-2.6.27/drivers/ata/ahci.c
--- linux-2.6.27.orig/drivers/ata/ahci.c	2008-10-09 18:13:53.000000000 -0400
+++ linux-2.6.27/drivers/ata/ahci.c	2008-11-19 12:56:04.000000000 -0500
@@ -1220,7 +1220,7 @@ static void ahci_sw_activity_blink(unsig
 	unsigned long led_message = emp->led_state;
 	u32 activity_led_state;
 
-	led_message &= 0xffff0000;
+	led_message &= 0x00070000;
 	led_message |= ap->port_no | (link->pmp << 8);
 
 	/* check to see if we've had activity.  If so,

--------------060702060901090008070501--
