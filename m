From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 19/21] ide-floppy: fix most of the remaining checkpatch.pl issues
Date: Sat, 12 Jan 2008 21:18:46 +0100
Message-ID: <200801122118.46375.bzolnier@gmail.com>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-19-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-20-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:20776 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758991AbYALUUG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 15:20:06 -0500
Received: by ug-out-1314.google.com with SMTP id z38so640513ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 12:20:05 -0800 (PST)
In-Reply-To: <1200052699-28420-20-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Friday 11 January 2008, Borislav Petkov wrote:
> i.e.,
> ERROR: switch and case should be at the same indent
> ERROR: need spaces around that '=' (ctx:VxV)
> ERROR: trailing statements should be on next line
> WARNING: no space between function name and open parenthesis '('
> WARNING: printk() should include KERN_ facility level
> ERROR: That open brace { should be on the previous line
> ERROR: use tabs not spaces
> ERROR: do not use assignment in if condition
> WARNING: braces {} are not necessary for single statement blocks
> ERROR: need space after that ',' (ctx:VxV)
> WARNING: line over 80 characters
> ERROR: do not use assignment in if condition
> ...

This should be the very last patch in the series
(and combined with patch #11).

> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> ---
>  drivers/ide/ide-floppy.c |  147 +++++++++++++++++++++++----------------------
>  1 files changed, 75 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
> index 0729df5..3d9b1e5 100644
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c
> @@ -47,13 +47,13 @@
>  #define IDEFLOPPY_DEBUG_INFO		0
>  #define IDEFLOPPY_DEBUG_BUGS		1
>  
> -#define IDEFLOPPY_DEBUG( fmt, args... )
> +#define IDEFLOPPY_DEBUG(fmt, args...)
>  
>  #if IDEFLOPPY_DEBUG_LOG
>  #define debug_log(fmt, args...) \
>  	printk(KERN_INFO "ide-floppy: " fmt, ## args)
>  #else
> -#define debug_log(fmt, args... ) do {} while(0)
> +#define debug_log(fmt, args...) do {} while (0)
>  #endif

Hmmm, these could have been dealt with in patch #4...

[...]

> @@ -1314,34 +1314,34 @@ static int idefloppy_identify_device (ide_drive_t *drive,struct hd_driveid *id)
>  #if IDEFLOPPY_DEBUG_INFO
>  	printk(KERN_INFO "Dumping ATAPI Identify Device floppy parameters\n");
>  	switch (gcw.protocol) {
> -		case 0: case 1: sprintf(buffer, "ATA");break;
> -		case 2:	sprintf(buffer, "ATAPI");break;
> -		case 3: sprintf(buffer, "Reserved (Unknown to ide-floppy)");break;
> +	case 0: case 1: sprintf(buffer, "ATA"); break;
> +	case 2:	sprintf(buffer, "ATAPI"); break;
> +	case 3: sprintf(buffer, "Reserved (Unknown to ide-floppy)"); break;
>  	}
>  	printk(KERN_INFO "Protocol Type: %s\n", buffer);
>  	switch (gcw.device_type) {
> -		case 0: sprintf(buffer, "Direct-access Device");break;
> -		case 1: sprintf(buffer, "Streaming Tape Device");break;
> -		case 2: case 3: case 4: sprintf (buffer, "Reserved");break;
> -		case 5: sprintf(buffer, "CD-ROM Device");break;
> -		case 6: sprintf(buffer, "Reserved");
> -		case 7: sprintf(buffer, "Optical memory Device");break;
> -		case 0x1f: sprintf(buffer, "Unknown or no Device type");break;
> -		default: sprintf(buffer, "Reserved");
> +	case 0: sprintf(buffer, "Direct-access Device"); break;
> +	case 1: sprintf(buffer, "Streaming Tape Device"); break;
> +	case 2: case 3: case 4: sprintf(buffer, "Reserved"); break;
> +	case 5: sprintf(buffer, "CD-ROM Device"); break;
> +	case 6: sprintf(buffer, "Reserved");
> +	case 7: sprintf(buffer, "Optical memory Device"); break;
> +	case 0x1f: sprintf(buffer, "Unknown or no Device type"); break;
> +	default: sprintf(buffer, "Reserved");
>  	}
>  	printk(KERN_INFO "Device Type: %x - %s\n", gcw.device_type, buffer);
>  	printk(KERN_INFO "Removable: %s\n", gcw.removable ? "Yes":"No");
>  	switch (gcw.drq_type) {
> -		case 0: sprintf(buffer, "Microprocessor DRQ");break;
> -		case 1: sprintf(buffer, "Interrupt DRQ");break;
> -		case 2: sprintf(buffer, "Accelerated DRQ");break;
> -		case 3: sprintf(buffer, "Reserved");break;
> +	case 0: sprintf(buffer, "Microprocessor DRQ"); break;
> +	case 1: sprintf(buffer, "Interrupt DRQ"); break;
> +	case 2: sprintf(buffer, "Accelerated DRQ"); break;
> +	case 3: sprintf(buffer, "Reserved"); break;
>  	}
>  	printk(KERN_INFO "Command Packet DRQ Type: %s\n", buffer);
>  	switch (gcw.packet_size) {
> -		case 0: sprintf(buffer, "12 bytes");break;
> -		case 1: sprintf(buffer, "16 bytes");break;
> -		default: sprintf(buffer, "Reserved");break;
> +	case 0: sprintf(buffer, "12 bytes"); break;
> +	case 1: sprintf(buffer, "16 bytes"); break;
> +	default: sprintf(buffer, "Reserved"); break;
>  	}
>  	printk(KERN_INFO "Command Packet Size: %s\n", buffer);
>  #endif /* IDEFLOPPY_DEBUG_INFO */

> @@ -1349,13 +1349,16 @@ static int idefloppy_identify_device (ide_drive_t *drive,struct hd_driveid *id)
>  	if (gcw.protocol != 2)
>  		printk(KERN_ERR "ide-floppy: Protocol is not ATAPI\n");
>  	else if (gcw.device_type != 0)
> -		printk(KERN_ERR "ide-floppy: Device type is not set to floppy\n");
> +		printk(KERN_ERR "ide-floppy: Device type is not set to"
> +				" floppy\n");
>  	else if (!gcw.removable)
>  		printk(KERN_ERR "ide-floppy: The removable flag is not set\n");
>  	else if (gcw.drq_type == 3) {
> -		printk(KERN_ERR "ide-floppy: Sorry, DRQ type %d not supported\n", gcw.drq_type);
> +		printk(KERN_ERR "ide-floppy: Sorry, DRQ type %d not"
> +				" supported\n", gcw.drq_type);
>  	} else if (gcw.packet_size != 0) {
> -		printk(KERN_ERR "ide-floppy: Packet size is not 12 bytes long\n");
> +		printk(KERN_ERR "ide-floppy: Packet size is not 12 bytes"
> +				" long\n");
>  	} else
>  		return 1;
>  	return 0;

If we convert the above code to dump gcw fields on error, i.e.

	if (gcw.protocol != 2)
		printk(KERN_ERR "ide-floppy: Protocol 0x%02 is not ATAPI\n",
				gcw.protocol);

we could just remove IDEFLOPPY_DEBUG_INFO (which is disabled by default).

Care to make a separate (pre-)patch?
