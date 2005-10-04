From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC 4/4] irq-pio: add read/write multiple support
Date: Tue, 04 Oct 2005 06:19:56 -0400
Message-ID: <4342574C.50900@pobox.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412FF6.5030006@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:10662 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932142AbVJDKUD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Oct 2005 06:20:03 -0400
In-Reply-To: <43412FF6.5030006@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

Albert Lee wrote:
> Patch 4/4: add read/write multiple support
> 
> Changes:
>    - add ATA_CMD_READ_MULTI, etc. to ata.h
>    - add multi_count to ata_device and initialize it with device 
> identify data
>    - merge ata_prot_to_cmd() with ata_dev_set_protocol()
>    - ata_pio_complete(): change the wait condition from (ATA_BUSY | 
> ATA_DRQ) to ATA_BUSY
>    - add ata_pio_sectors() to support r/w multiple commands
>    - ata_pio_block(): add ata_altstatus(ap) to prevent reading device 
> status before it is valid
> 
> 
> For your review, thanks.
> 
> Albert
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> 
> 
> ------------------------------------------------------------------------
> 
> --- id7/drivers/scsi/libata-core.c	2005-10-03 12:39:03.000000000 +0800
> +++ id8/drivers/scsi/libata-core.c	2005-10-03 18:33:26.000000000 +0800
> @@ -616,49 +616,6 @@ void ata_tf_from_fis(u8 *fis, struct ata
>  }
>  
>  /**
> - *	ata_prot_to_cmd - determine which read/write opcodes to use
> - *	@protocol: ATA_PROT_xxx taskfile protocol
> - *	@lba48: true is lba48 is present
> - *
> - *	Given necessary input, determine which read/write commands
> - *	to use to transfer data.
> - *
> - *	LOCKING:
> - *	None.
> - */
> -static int ata_prot_to_cmd(int protocol, int lba48)
> -{
> -	int rcmd = 0, wcmd = 0;
> -
> -	switch (protocol) {
> -	case ATA_PROT_PIO:
> -		if (lba48) {
> -			rcmd = ATA_CMD_PIO_READ_EXT;
> -			wcmd = ATA_CMD_PIO_WRITE_EXT;
> -		} else {
> -			rcmd = ATA_CMD_PIO_READ;
> -			wcmd = ATA_CMD_PIO_WRITE;
> -		}
> -		break;
> -
> -	case ATA_PROT_DMA:
> -		if (lba48) {
> -			rcmd = ATA_CMD_READ_EXT;
> -			wcmd = ATA_CMD_WRITE_EXT;
> -		} else {
> -			rcmd = ATA_CMD_READ;
> -			wcmd = ATA_CMD_WRITE;
> -		}
> -		break;
> -
> -	default:
> -		return -1;
> -	}
> -
> -	return rcmd | (wcmd << 8);
> -}
> -
> -/**
>   *	ata_dev_set_protocol - set taskfile protocol and r/w commands
>   *	@dev: device to examine and configure
>   *
> @@ -675,19 +632,42 @@ static void ata_dev_set_protocol(struct 
>  {
>  	int pio = (dev->flags & ATA_DFLAG_PIO);
>  	int lba48 = (dev->flags & ATA_DFLAG_LBA48);
> -	int proto, cmd;
> +	int rcmd, wcmd;
>  
> -	if (pio)
> -		proto = dev->xfer_protocol = ATA_PROT_PIO;
> -	else
> -		proto = dev->xfer_protocol = ATA_PROT_DMA;
> +	if (pio) {
> +		dev->xfer_protocol = ATA_PROT_PIO;
>  
> -	cmd = ata_prot_to_cmd(proto, lba48);
> -	if (cmd < 0)
> -		BUG();
> +		if (dev->multi_count) {
> +			if (lba48) {
> +				rcmd = ATA_CMD_READ_MULTI_EXT;
> +				wcmd = ATA_CMD_WRITE_MULTI_EXT;
> +			} else {
> +				rcmd = ATA_CMD_READ_MULTI;
> +				wcmd = ATA_CMD_WRITE_MULTI;
> +			}
> +		} else {
> +			if (lba48) {
> +				rcmd = ATA_CMD_PIO_READ_EXT;
> +				wcmd = ATA_CMD_PIO_WRITE_EXT;
> +			} else {
> +				rcmd = ATA_CMD_PIO_READ;
> +				wcmd = ATA_CMD_PIO_WRITE;
> +			}
> +		}
> +	} else {
> +		dev->xfer_protocol = ATA_PROT_DMA;
> +
> +		if (lba48) {
> +			rcmd = ATA_CMD_READ_EXT;
> +			wcmd = ATA_CMD_WRITE_EXT;
> +		} else {
> +			rcmd = ATA_CMD_READ;
> +			wcmd = ATA_CMD_WRITE;
> +		}
> +	}
>  
> -	dev->read_cmd = cmd & 0xff;
> -	dev->write_cmd = (cmd >> 8) & 0xff;
> +	dev->read_cmd = rcmd;
> +	dev->write_cmd = wcmd;
>  }
>  
>  static const char * xfer_mode_str[] = {

I rather liked having ata_prot_to_cmd() separate, but your version is 
OK.  No objection, just a twitch :)


> @@ -2483,13 +2469,13 @@ static int ata_pio_complete (struct ata_
>  	 * we enter, BSY will be cleared in a chk-status or two.  If not,
>  	 * the drive is probably seeking or something.  Snooze for a couple
>  	 * msecs, then chk-status again.  If still busy, fall back to
> -	 * HSM_ST_POLL state.
> +	 * HSM_ST_LAST_POLL state.
>  	 */
> -	drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 10);
> -	if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
> +	drv_stat = ata_busy_wait(ap, ATA_BUSY, 10);
> +	if (drv_stat & ATA_BUSY) {
>  		msleep(2);
> -		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 10);
> -		if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
> +		drv_stat = ata_busy_wait(ap, ATA_BUSY, 10);
> +		if (drv_stat & ATA_BUSY) {
>  			ap->hsm_task_state = HSM_ST_LAST_POLL;
>  			ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
>  			return 1;

Eventually we should make sure that DRQ is cleared, at the end of the 
transfer.  Does other code make this check?

Ideally, in _all_ cases where look at the status register, we should 
check the DRDY and DF bits as well.  That's why in drivers/ide/ you find

	check_bits = ATA_BSY | ATA_DRQ | ATA_DF | ATA_DRDY
	ok_bits = ATA_DRDY
	if ((Status & check_bits) == ok_bits)	# BUS IDLE
		OK
	else
		error

Patch is otherwise OK.

Not applied, since patches #2 and #3 were not applied.

