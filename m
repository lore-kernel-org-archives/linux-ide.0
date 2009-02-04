From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3] AT91: initialize IDE driver on AT91SAM9263 cpu
Date: Wed, 04 Feb 2009 18:46:59 +0300
Message-ID: <4989B873.3050304@ru.mvista.com>
References: <200902031147.41822.stf_xl@wp.pl> <4989877D.6020401@ru.mvista.com> <200902041515.38157.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:21006 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752105AbZBDPqc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Feb 2009 10:46:32 -0500
In-Reply-To: <200902041515.38157.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

Stanislaw Gruszka wrote:

>>>Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

>>[...]

>>>diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
>>>index b753cb8..503651a 100644
>>>--- a/arch/arm/mach-at91/at91sam9263_devices.c
>>>+++ b/arch/arm/mach-at91/at91sam9263_devices.c
>>>@@ -347,6 +347,103 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
>>> void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
>>> #endif
>>> 
>>>+/* --------------------------------------------------------------------
>>>+ *  IDE
>>>+ * -------------------------------------------------------------------- */
>>>+
>>>+#if defined(CONFIG_BLK_DEV_IDE_AT91) || defined(CONFIG_BLK_DEV_IDE_AT91_MODULE)
>>>+
>>>+/* Proper CS address space will be added */
>>>+#define AT91_IDE_TASK_FILE	0x00c00000
>>>+#define AT91_IDE_CTRL_REG	0x00e00000

>>   Why are you assuming that these offsets are not board specifec I 
>>wonder? Theyu clearly depend on how the -CSx were wired on the board -- 
>>it's the same board specific data as your IRQ.

> Are CPU specific.

    Ah, sorry, I've missed that in the datasheet -- only looked into the SMC
section and that's described in the EBI section...

> Actually all AT91(except RM9200) use the same offsets,
> so could be moved from here to driver code,  like in at91_cf driver.
> In this file only we will have proper Chip Select address space resource.

    Then it indeed makes much sense having a single platfrom device for both 
IDE driver and the possible PCMCIA driver with a single memory resource 
covering the whole CS4/5 range as the drivers will know what subranges they 
want to use.

> Cheers
> Stanislaw Gruszka

WBR, Sergei

