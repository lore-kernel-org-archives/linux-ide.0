From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Fix pio/mwdma programming on ata_piix.c
Date: Thu, 24 May 2007 16:55:00 -0400
Message-ID: <4655FBA4.9050702@garzik.org>
References: <20070202151856.GD1625@htj.dyndns.org> <20070430182939.GD4156@artsapartment.org> <4636ADBE.8080508@gmail.com> <20070524195943.GC7734@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47708 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816AbXEXUzG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 16:55:06 -0400
In-Reply-To: <20070524195943.GC7734@artsapartment.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Art Haas <ahaas@airmail.net>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Art Haas wrote:
> On Tue, May 01, 2007 at 05:02:22AM +0200, Tejun Heo wrote:
>> Hello, Art Haas.
>>
>> Art Haas wrote:
>>> Hi.
>>>
>>> Back in the beginning of February I was sent a patch to test during the
>>> time the CD-ROM identification bug was affecting my computer. The
>>> first posting of the patch appeared on Feb. 3 with Tejun Heo writing:
>> Ah.. I completely forgot about this one.  This wasn't directly related
>> to the detection bug, so I got oblivious as usual.  :-)
>>
>> I think Alan has reviewed it back then.  If there's no objection, I'll
>> reformat the patch and submit it properly.  Quoting whole message for Jeff.
>>
>>>> Hello, Art Haas, Alan.
>>>>
>>>> Okay, here's another try at fixing the detection bug.  I went through
>>>> intel ich docs and compared with the ide piix driver.  This patch
>>>> fixes the following problems.
>>>>
>>>> * Control bits in the timing register wasn't cleared properly while
>>>>   programming PIO mode.
>>>>
>>>> * MWDMA mode programming cleared the wrong part of control bits.  I
>>>>   think this can fix your problem.
>>>>
>>>> * MWDMA mode programming cleared udma_mask even when the controller
>>>>   doesn't support UDMA.  This doesn't matter for your case.
>>>>
>>>> Please test and report the result.  Thanks.
>>> The patch and complete thread can be reviewed here:
>>>
>>> http://marc.info/?l=linux-ide&m=117042956705812&w=2
>>>
>>> Now that 2.6.22 is open for big modifications, and the queued libata
>>> changes have been pulled by Linus, I'm wondering if the ata_piix.c patch
>>> posted above should be sent. I've built all my kernels since the posting
>>> with the patch and had no problems. As you write above, the patch does
>>> fix some bugs, and as the thread progressed a cleanup or two in the code
>>> was explained as a bug fix - the setting of the 'slave_data' variable
>>> between lines 826 and 834 in particular.
>>>
>>> Here's the patch against today's Linus tree if you feel it should make
>>> it into 2.6.22.
>>> [ ... snip ... ]
> 
> Ping?
> 
> Here's the patch diffed to this afternoon's tree.
> 
> Art Haas
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index 0458811..51de738 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -684,8 +684,14 @@ static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev)
>  	if (adev->class == ATA_DEV_ATA)
>  		control |= 4;	/* PPE enable */
>  
> +	/* PIO configuration clears DTE unconditionally.  It will be
> +	 * programmed in set_dmamode which is guaranteed to be called
> +	 * after set_piomode if any DMA mode is available.
> +	 */
>  	pci_read_config_word(dev, master_port, &master_data);
>  	if (is_slave) {
> +		/* clear TIME1|IE1|PPE1|DTE1 */
> +		master_data &= 0xff0f;
>  		/* Enable SITRE (seperate slave timing register) */
>  		master_data |= 0x4000;
>  		/* enable PPE1, IE1 and TIME1 as needed */
> @@ -693,12 +699,14 @@ static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev)
>  		pci_read_config_byte(dev, slave_port, &slave_data);
>  		slave_data &= (ap->port_no ? 0x0f : 0xf0);
>  		/* Load the timing nibble for this slave */
> -		slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->port_no ? 4 : 0);
> +		slave_data |= ((timings[pio][0] << 2) | timings[pio][1])
> +						<< (ap->port_no ? 4 : 0);
>  	} else {
> -		/* Master keeps the bits in a different format */
> -		master_data &= 0xccf8;
> +		/* clear ISP|RCT|TIME0|IE0|PPE0|DTE0 */
> +		master_data &= 0xccf0;
>  		/* Enable PPE, IE and TIME as appropriate */
>  		master_data |= control;
> +		/* load ISP and RCT */
>  		master_data |=
>  			(timings[pio][0] << 12) |
>  			(timings[pio][1] << 8);
> @@ -815,7 +823,7 @@ static void do_pata_set_dmamode (struct ata_port *ap, struct ata_device *adev, i
>  			master_data &= 0xFF4F;  /* Mask out IORDY|TIME1|DMAONLY */
>  			master_data |= control << 4;
>  			pci_read_config_byte(dev, 0x44, &slave_data);
> -			slave_data &= (0x0F + 0xE1 * ap->port_no);
> +			slave_data &= (ap->port_no ? 0x0f : 0xf0);
>  			/* Load the matching timing */
>  			slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->port_no ? 4 : 0);
>  			pci_write_config_byte(dev, 0x44, slave_data);
> @@ -827,8 +835,11 @@ static void do_pata_set_dmamode (struct ata_port *ap, struct ata_device *adev, i
>  				(timings[pio][0] << 12) |
>  				(timings[pio][1] << 8);
>  		}
> -		udma_enable &= ~(1 << devid);
> -		pci_write_config_word(dev, master_port, master_data);
> +
> +		if (ap->udma_mask) {
> +			udma_enable &= ~(1 << devid);
> +			pci_write_config_word(dev, master_port, master_data);
> +		}
>  	}
>  	/* Don't scribble on 0x48 if the controller does not support UDMA */
>  	if (ap->udma_mask)
> 

Please resend with proper sign-offs.  All patches in the kernel need 
that... http://linux.yyz.us/patch-format.html

Thanks,

	Jeff


