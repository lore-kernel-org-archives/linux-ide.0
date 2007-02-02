From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ata_piix: fix pio/mwdma programming (for testing, don't
 apply)
Date: Fri, 02 Feb 2007 18:34:20 +0300
Message-ID: <45C359FC.2000601@ru.mvista.com>
References: <20070202151856.GD1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:65040 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1945943AbXBBPe1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 10:34:27 -0500
In-Reply-To: <20070202151856.GD1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: ahaas@airmail.net, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello.

Tejun Heo wrote:

> Okay, here's another try at fixing the detection bug.  I went through
> intel ich docs and compared with the ide piix driver.  This patch
> fixes the following problems.

> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index c6bf1a3..51f55a0 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -728,8 +728,14 @@ static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev)
>  	if (adev->class == ATA_DEV_ATA)
>  		control |= 4;	/* PPE enable */
>  
> +	/* PIO configuration clears DTE unconditionally.  It will be
> +	 * programmed in set_dmamode which is guaranteed to be called
> +	 * after set_piomode if any DMA mode is available.
> +	 */

    Actually, I think ata_timing_merge() should just be performed when setting 
MWDMA mode... This should be the right thing to do in most cases (however, 
this hardware has some complications in the form of only 2-bit wide 
active/recovery counts and 2 fast timing bank select bits)...

>  	pci_read_config_word(dev, master_port, &master_data);
>  	if (is_slave) {
> +		/* clear TIME1|IE1|PPE1|DTE1 */
> +		master_data &= 0xff0f;

    Yeah, I've fixed this oversight in piix.c...

>  		/* Enable SITRE (seperate slave timing register) */
>  		master_data |= 0x4000;
>  		/* enable PPE1, IE1 and TIME1 as needed */
> @@ -737,12 +743,14 @@ static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev)
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
> @@ -859,7 +867,7 @@ static void do_pata_set_dmamode (struct ata_port *ap, struct ata_device *adev, i
>  			master_data &= 0xFF4F;  /* Mask out IORDY|TIME1|DMAONLY */
>  			master_data |= control << 4;
>  			pci_read_config_byte(dev, 0x44, &slave_data);
> -			slave_data &= (0x0F + 0xE1 * ap->port_no);
> +			slave_data &= (ap->port_no ? 0x0f : 0xf0);
>  			/* Load the matching timing */
>  			slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->port_no ? 4 : 0);
>  			pci_write_config_byte(dev, 0x44, slave_data);
> @@ -871,8 +879,11 @@ static void do_pata_set_dmamode (struct ata_port *ap, struct ata_device *adev, i
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

    I've also noticed that this is done at the end of piix_set_piomode() and I 
see no reason why.  Isn't it just a leftover from the piix.c brokenness?  This 
driver coupled PIO and UDMA timing updates for no conceivable reason?

MBR, Sergei
