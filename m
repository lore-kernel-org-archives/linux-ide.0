From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] ide: add at91_ide driver
Date: Wed, 04 Feb 2009 19:04:27 +0300
Message-ID: <4989BC8B.4010105@ru.mvista.com>
References: <200902031147.22827.stf_xl@wp.pl> <498987E6.7040909@ru.mvista.com> <200902041547.44149.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:21429 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754584AbZBDQEB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Feb 2009 11:04:01 -0500
In-Reply-To: <200902041547.44149.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

Stanislaw Gruszka wrote:

>>>diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
>>>index fb51f0e..6674b9b 100644
>>>--- a/arch/arm/mach-at91/include/mach/board.h
>>>+++ b/arch/arm/mach-at91/include/mach/board.h
>>>@@ -59,6 +59,18 @@ struct at91_cf_data {
>>> };
>>> extern void __init at91_add_device_cf(struct at91_cf_data *data);
>>> 
>>>+ /* Compact Flash True IDE mode */
>>>+struct at91_ide_data {
>>>+	u8	irq_pin;		/* the same meaning as for CF */

>>  I again have to express my dislike about not passing IRQ the usual 
>>way. Also, see my comments to the platform code.

> Yes, I know, I don't like to argue. Only reasoning to use platform irq resource
> seams to be: "because other drivers do". However we have exception - at91_cf
> also use board->irq_pin, so maybe this driver could also do ?

    Then why have the memory resource when we can calculate it from the chip 
select? (I'm not asking you to do that, since the platfrom device resources 
are user-visible thru /proc/iomem -- even if the driver is not enabled.)

>>>diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
>>>new file mode 100644
>>>index 0000000..3a1f7e0
>>>--- /dev/null
>>>+++ b/drivers/ide/at91_ide.c
>>>@@ -0,0 +1,496 @@
>>>+/*
>>>+ * IDE host driver for AT91SAM9 Static Memory Controller

>>   Why not call the driver 'at91sam9_ide'?

>>>+/*
>>>+ * AT91 Static Memory Controller

>>  AT91SAM9.

> Ok, currently only SAM9 can be used with driver. However I think adding
> support to AT91RM9200 to this driver will be not much effort.

    Can you answer the simple question: why we should try to support two 
incompatible chips with a single driver? Because the driver name will be 
shorter? :-)

> I don't think
> someone will want to write new driver for RM9200 insted using this one.

    You're right, nobody will want that... because AT91RM9200 as is has *no 
support for True IDE mode*. ;-)

> IMHO, current name is short and sweet and not miss the true so much -
> most of the AT91s which can work with True IDE logic are supported. 
> I would like to stay with current name.

    Oh, do what you want... just don't claim it will work on RM9200. :-/

>>>+ * different bus data width is used: 8Bit for Task File, 16Bit for Data I/O
>>>+ *
>>>+ * After initialization we do 8/16 bit flipping (changes in SMC MODE register)
>>>+ * only inside IDE callback routines which are serialized by IDE layer,
>>>+ * so no additional locking needed.
>>>+ */
>>>+
>>>+static void init_smc_mode(const u8 chipselect)
>>>+{
>>>+	at91_sys_write(AT91_SMC_MODE(chipselect), AT91_SMC_READMODE |
>>>+						  AT91_SMC_WRITEMODE |
>>>+						  AT91_SMC_BAT_SELECT |
>>>+						  AT91_SMC_TDF_(0));
>>>  

>>   I'm not sure why are you fixing the dataflow timing again, this time 
>>to 0...

> Not necessary code, will be removed.

    All this funciton seems pretty useless.

>>>+{
>>>+	unsigned long mode;
>>>+
>>>+	/* setup timings in SMC */
>>>+	at91_sys_write(AT91_SMC_SETUP(chipselect), AT91_SMC_NWESETUP_(setup) |
>>>+						   AT91_SMC_NCS_WRSETUP_(0) |
>>>+						   AT91_SMC_NRDSETUP_(setup) |
>>>+						   AT91_SMC_NCS_RDSETUP_(0));
>>>+	at91_sys_write(AT91_SMC_PULSE(chipselect), AT91_SMC_NWEPULSE_(pulse) |
>>>+						   AT91_SMC_NCS_WRPULSE_(cycle) |
>>>+						   AT91_SMC_NRDPULSE_(pulse) |
>>>+						   AT91_SMC_NCS_RDPULSE_(cycle));
>>>+	at91_sys_write(AT91_SMC_CYCLE(chipselect), AT91_SMC_NWECYCLE_(cycle) |
>>>+						   AT91_SMC_NRDCYCLE_(cycle));
>>>+
>>>+	mode = at91_sys_read(AT91_SMC_MODE(chipselect));

>>   Frankly speaking, I don't see why you're reading this register back 
>>if you already know what needs to be set there -- as you've done it in 
>>init_smc_mode().

> This function is not only used at initialization. It is also used when PIO mode
> is changed.

    So what? You can just write the fixed mode bits into the register every 
time without readback.

>>>+static void apply_timings(const u8 chipselect, const u8 pio,
>>>+			  const struct ide_timing *timing, const u16 *ata_id)
>>>+{

[...]

>>>+	if (ata_id) {
>>>+		if (ata_id_is_cfa(ata_id)) {
>>>+			if (pio == 3 || pio == 4)
>>>+				use_iordy = 1;
>>>  
>>>+		} else if (pio >= 3 || ata_id_has_iordy(ata_id))
>>>+			use_iordy = 1;

>>   No, you should check for IORDY regardless of CFA and using IORDY 
>>shouldn't be limeited to modes 3 and 4:

> Hmm, I take as example ata_pio_need_iordy(), it is also wrong or maybe
> I don't follow the logic properly.

    Let me look... yes, you don't follow it properly. Besides, it could have 
omitted checking for PIO mode > 2.

MBR, Sergei
