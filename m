From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
Date: Wed, 24 Sep 2008 15:32:19 +0400
Message-ID: <48DA2543.4050304@ru.mvista.com>
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp>	<48D57245.8060606@ru.mvista.com> <20080922.013256.128618380.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.mvista.com ([63.81.120.155]:61034 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751648AbYIXLc1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Sep 2008 07:32:27 -0400
In-Reply-To: <20080922.013256.128618380.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: bzolnier@gmail.com, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org

Hello.

Atsushi Nemoto wrote:

>>> +	if (pair)
>>> +		safe = min(safe, ide_get_best_pio_mode(pair, 255, 4));
>>> +	/*
>>> +	 * Update Command Transfer Mode for master/slave and Data
>>> +	 * Transfer Mode for this drive.
>>> +	 */
>>> +	mask = is_slave ? 0x07f00700 : 0x070007f0;
>>> +	val = (safe << 24) | (safe << 8) | (pio << (is_slave ? 20 : 4));
>>>   
>>>       
>>    You are not obliged to set the same command rimings for both drives...
>>     
>
> I thought I should use "safe" command timings for command transfer
> mode since taskfile registers should be considered as "shared" for
>   

   Safe mode is defined as the mode not faster than the slowest drive's 
fastest mode.

> both drives.  At least device selection sequence should be done in
> safe speed, isn't it?
>   

    But why do you think that the PIO mode being programmed is actually 
safer for another drive than previous one which might have been slower?

>>> +		/* wait 12GBUSCLK (typ. 60ns @ GBUS200MHz) */
>>> +		ndelay(400);
>>>   
>>>       
>>    But why wait 400 ns?
>>     
>
> Well, I should recalculate safe value for possible slowest gbus clock.
>   

   Hm, that corresponds to 30 MHz and 6.7x that one for 200 MHz. But why 
100 ns turns into 1 us then? Well, not that it actually matters much, 
just for consistency...

>>> +	if (stat & (TX4939IDE_INT_ADDRERR | TX4939IDE_INT_REACHMUL |
>>> +		    TX4939IDE_INT_DEVTIMING | TX4939IDE_INT_BUSERR))
>>> +		pr_err("%s: Error interrupt %#x (%s%s%s%s )\n",
>>> +		       hwif->name, stat,
>>> +		       (stat & TX4939IDE_INT_ADDRERR) ?
>>> +		       " Address-Error" : "",
>>> +		       (stat & TX4939IDE_INT_REACHMUL) ?
>>> +		       " Reach-Multiple" : "",
>>>   
>>>       
>>    This is not an error condition and should only happen in so called 
>> VDMA mode iff you suspend the transfer, IIUC.
>>     

   I.e. when you're performing PIO transfer with drive but have 
programmed the controller for DMA transfer -- IIUC, TX4939 supports 
that. Otherwise these "break" bits don't make sense...

> So just masking Reach-Multiple interrupt is better?
>   

   Aren't you masking it already?

>>> +	case TX4939IDE_INT_HOST | TX4939IDE_INT_XFEREND:
>>> +		dma_stat = tx4939ide_readb(base, TX4939IDE_DMA_stat);
>>> +		if (!(dma_stat & 4))
>>> +			pr_debug("%s: weird interrupt status. "
>>>   
>>>       
>>    This one is worth pr_warning() or even pr_err()...
>>
>>     
>>> +				 "DMA_stat %#02x int_ctl %#04x\n",
>>> +				 hwif->name, dma_stat, ctl);
>>>   
>>>       
>>    However,  it's already done in the dma_end() method;.do we need 
>> really to print 2 messages?
>>     
>
> Yes, we don't need this usually.  So I used pr_debug() instead of
> pr_warning().  But I have no strong opinition here.  I'll drop it.
>   

   I suggest pr_err() or pr_warning() here and dropping it in the 
dma_end() method.

>>> +static void tx4939ide_init_iops(ide_hwif_t *hwif)
>>> +{
>>> +	/* use extra_base for base address of the all registers */
>>> +	hwif->extra_base = hwif->io_ports.data_addr & ~0xfff;
>>> +}
>>>       
>>    Ugh... didn't realize that using hwif->extra_base necessiates the 
>> init_iops() method. But why is it necessary? We're not using 
>> hwif->extra_base to access the taskfile.
>>     
>
> The extra_base is used by TX4939IDE_BASE() everywhere...
> And I cannot find other good place to initialize extra_base.
>   

   Ah, you're now using it in the tf_load() method...

> We can initialize extra_base in tx4939ide_probe by using
> ide_host_alloc()/ide_host_register() instead of ide_host_add().  Is
> this preferred?
>   

   Up to you...

>>> +static void tx4939ide_tf_load(ide_drive_t *drive, ide_task_t *task)
>>> +{
>>> +	mm_tf_load(drive, task);
>>> +	if (task->tf_flags & IDE_TFLAG_OUT_DEVICE) {
>>> +		ide_hwif_t *hwif = drive->hwif;
>>> +		void __iomem *base = TX4939IDE_BASE(hwif);
>>> +		/* Fix ATA100 CORE System Control Register */
>>> +		tx4939ide_writew(tx4939ide_readw(base, TX4939IDE_Sys_Ctl) &
>>> +				 0x07f0,
>>> +				 base, TX4939IDE_Sys_Ctl);
>>>       
>>    Why? Doesn't page 17-4 of the datasheet say that these bits get 
>> auto-cleared ona  write to the device/head register? Or is this to 
>> address <CAUSION> on page 17-9?
>>     
>
> Yes, that "CAUSION".  I will put it in the comment.

   Frankly speaking, I couldn't make out much of tht passage:

<CAUSION>
The write to the register by the Device/Head register may cause an 
unexpected function by write wrong
data to the register. So please rewrite to the System Control register 
after write to the Device/Head
register to secure write to System Control register in ATA100 Core.

   For the curious, the datasheet is here:

http://www.toshiba.com/taec/components/Datasheet/TX4939XBG-400.pdf

MBR, Sergei


