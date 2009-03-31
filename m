From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Tue, 31 Mar 2009 14:36:25 +0400
Message-ID: <49D1F229.4000602@ru.mvista.com>
References: <49CCD7C4.8000207@inov.pt> <49CFDD8F.1030306@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE1909014E2E09@mi8nycmail19.Mi8.com>	<49D0CAE4.9090306@inov.pt> <49D12669.4030207@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:15806 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751246AbZCaKgg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Mar 2009 06:36:36 -0400
In-Reply-To: <49D12669.4030207@bluewatersys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>, H Hartley Sweeten <hartleys@visionengravers.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org

Hello.

Ryan Mallon wrote:

>> +static void
>> +ep93xx_ide_pio_set_irq(ide_hwif_t *hwif, int on)
>> +{
>> +    u8 ctl = ATA_DEVCTL_OBS;
>> +
>> +    if (on == 4) { /* hack for SRST */
>> +        ctl |= 4;
>> +        on &= ~4;
>> +    }
>> +
>> +    ctl |= on ? 0 : 2;
>>     
>
> This function all seems a bit magic/hackish. Can you replace the
> numbers here with #defines to make it clear what is being done.
> You may also want to expand on the comment here to explain why the
> 'hack' is needed.
>   

   It's standard implementation of this method, and looks the same in 
all the other IDE drivers that redefine it. It's going to be gone in 
2.6.30, so it's not worth wasting time...

>> +
>> +    ep93xx_ide_pio_writeb(hwif->config_data, ctl,
>> hwif->io_ports.ctl_addr);
>> +}
>> +
>> +static void
>> +ep93xx_ide_pio_tf_load(ide_drive_t *drive, ide_task_t *task)
>> +{
>> +    ide_hwif_t *hwif = drive->hwif;
>> +    struct ide_io_ports *io_ports = &hwif->io_ports;
>> +    struct ide_taskfile *tf = &task->tf;
>> +    u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
>>     
>
> Don't give local variables names with all capitals. What is hihi anyway?
>   

  He must've copied that from the other drivers, so that question is to 
the IDE maintainever rather. :-)


MBR, Sergei


