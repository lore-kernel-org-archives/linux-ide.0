From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Fri, 7 Jul 2006 10:01:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0607071000380.2978@p34.internal.lan>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <200607070908.44751.liml@rtr.ca>
 <Pine.LNX.4.64.0607070923130.4099@p34.internal.lan> <200607070943.17957.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750777AbWGGOBQ@vger.kernel.org>
In-Reply-To: <200607070943.17957.liml@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Sander <sander@humilis.net>, Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org



On Fri, 7 Jul 2006, Mark Lord wrote:

> Justin Piszcz wrote:
>>
>> had to change
>>
>> KERN_WARN -> KERN_WARNING
>>
>> then more errors
>
> Eh?  After fixing the KERN_WARN -> KERN_WARNING part,
> the patch compiles / links cleanly here on 2.6.17.
> (fixed copy below).   Still untested, though.
>
>> do you know who wrote the original patch?
>
> I did.
>
> Cheers
>
> --- linux/drivers/scsi/libata-scsi.c.orig	2006-06-19 10:37:03.000000000 -0400
> +++ linux/drivers/scsi/libata-scsi.c	2006-07-07 09:06:57.000000000 -0400
> @@ -542,6 +542,7 @@
> 	struct ata_taskfile *tf = &qc->tf;
> 	unsigned char *sb = cmd->sense_buffer;
> 	unsigned char *desc = sb + 8;
> +	unsigned char ata_op = tf->command;
>
> 	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
>
> @@ -558,6 +559,7 @@
> 	 * onto sense key, asc & ascq.
> 	 */
> 	if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> +		printk(KERN_WARNING "ata_gen_ata_desc_sense: failed ata_op=0x%02x\n", ata_op);
> 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
> 				   &sb[1], &sb[2], &sb[3]);
> 		sb[1] &= 0x0f;
>

Mark,

I've set a disk faulty in my SW RAID5 and rebuilding it now, note, in the 
past two rebuilds I have done (in exact same manner & disk) I've gotten 
3-4 of these or so, so if I do not get them this time, that will be 
extremely odd.

Justin.
