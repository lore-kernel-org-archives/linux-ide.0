From: Uplink <advantis@gmx.net>
Subject: Re: drive appears confused (ireason = 0x01)
Date: Wed, 05 Oct 2005 01:06:13 +0300
Message-ID: <4342FCD5.2000107@gmx.net>
References: <433F2249.30707@gmx.net> <20051003073342.GA3511@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imap.gmx.net ([213.165.64.20]:925 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965010AbVJDWGQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Oct 2005 18:06:16 -0400
In-Reply-To: <20051003073342.GA3511@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I found out what it was and it's not this. It's S-ATA vs. IRQ. I'm
starting to hate these encounters. It's all about Legacy/Compatibily vs.
Enhanced mode of operation. Something changes with the APIC when using
Enhanced mode and isn't handled by the kernel.

This link shows, somewhat, what I mean:
http://plutohome.com/support/phpbb2/viewtopic.php?p=1600#1600

Jens Axboe wrote:

>On Sun, Oct 02 2005, Uplink wrote:
>  
>
>>Hi,
>>
>>This may concern you in part. Parts that you feel that don't concern 
>>IDE, please forward to the ones responsible.
>>
>>Since kernel 2.6.13 I get a "cdrom_pc_intr: The drive appears confused 
>>(ireason = 0x01)" message when trying to access the DVD drive and I 
>>can't read any disks.
>>
>>I just booted 2.6.14-rc3 and I still get it. I also get some weird 
>>things in syslog:
>>
>>Oct  1 23:45:24 dcerouter kernel: hda: cde appears confused (ireason = 0x01)
>>Oct  1 23:45:24 dcerouter kernel: hda: cdroe appears confused (ireason = 
>>0x01)
>>    
>>
>
>Can you try reversing this patch from 2.6.13/2.6.14-rc3 and see if it
>makes a difference?
>
>diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
>--- a/drivers/ide/ide-cd.c
>+++ b/drivers/ide/ide-cd.c
>@@ -431,7 +431,7 @@ void cdrom_analyze_sense_data(ide_drive_
> #if VERBOSE_IDE_CD_ERRORS
> 	{
> 		int i;
>-		const char *s;
>+		const char *s = "bad sense key!";
> 		char buf[80];
> 
> 		printk ("ATAPI device %s:\n", drive->name);
>@@ -446,8 +446,6 @@ void cdrom_analyze_sense_data(ide_drive_
> 
> 		if (sense->sense_key < ARY_LEN(sense_key_texts))
> 			s = sense_key_texts[sense->sense_key];
>-		else
>-			s = "bad sense key!";
> 
> 		printk("%s -- (Sense key=0x%02x)\n", s, sense->sense_key);
> 
>@@ -2657,16 +2655,63 @@ int ide_cdrom_lock_door (struct cdrom_de
> }
> 
> static
>+int ide_cdrom_get_capabilities(ide_drive_t *drive, struct atapi_capabilities_page *cap)
>+{
>+	struct cdrom_info *info = drive->driver_data;
>+	struct cdrom_device_info *cdi = &info->devinfo;
>+	struct packet_command cgc;
>+	int stat, attempts = 3, size = sizeof(*cap);
>+
>+	/*
>+	 * ACER50 (and others?) require the full spec length mode sense
>+	 * page capabilities size, but older drives break.
>+	 */
>+	if (!(!strcmp(drive->id->model, "ATAPI CD ROM DRIVE 50X MAX") ||
>+	    !strcmp(drive->id->model, "WPI CDS-32X")))
>+		size -= sizeof(cap->pad);
>+
>+	init_cdrom_command(&cgc, cap, size, CGC_DATA_UNKNOWN);
>+	do { /* we seem to get stat=0x01,err=0x00 the first time (??) */
>+		stat = cdrom_mode_sense(cdi, &cgc, GPMODE_CAPABILITIES_PAGE, 0);
>+		if (!stat)
>+			break;
>+	} while (--attempts);
>+	return stat;
>+}
>+
>+static
>+void ide_cdrom_update_speed (ide_drive_t *drive, struct atapi_capabilities_page *cap)
>+{
>+	/* The ACER/AOpen 24X cdrom has the speed fields byte-swapped */
>+	if (!drive->id->model[0] &&
>+	    !strncmp(drive->id->fw_rev, "241N", 4)) {
>+		CDROM_STATE_FLAGS(drive)->current_speed  =
>+			(((unsigned int)cap->curspeed) + (176/2)) / 176;
>+		CDROM_CONFIG_FLAGS(drive)->max_speed =
>+			(((unsigned int)cap->maxspeed) + (176/2)) / 176;
>+	} else {
>+		CDROM_STATE_FLAGS(drive)->current_speed  =
>+			(ntohs(cap->curspeed) + (176/2)) / 176;
>+		CDROM_CONFIG_FLAGS(drive)->max_speed =
>+			(ntohs(cap->maxspeed) + (176/2)) / 176;
>+	}
>+}
>+
>+static
> int ide_cdrom_select_speed (struct cdrom_device_info *cdi, int speed)
> {
> 	ide_drive_t *drive = (ide_drive_t*) cdi->handle;
> 	struct request_sense sense;
>+	struct atapi_capabilities_page cap;
> 	int stat;
> 
> 	if ((stat = cdrom_select_speed(drive, speed, &sense)) < 0)
> 		return stat;
> 
>-        cdi->speed = CDROM_STATE_FLAGS(drive)->current_speed;
>+	if (!ide_cdrom_get_capabilities(drive, &cap)) {
>+		ide_cdrom_update_speed(drive, &cap);
>+		cdi->speed = CDROM_STATE_FLAGS(drive)->current_speed;
>+	}
>         return 0;
> }
> 
>@@ -2869,31 +2914,6 @@ static int ide_cdrom_register (ide_drive
> }
> 
> static
>-int ide_cdrom_get_capabilities(ide_drive_t *drive, struct atapi_capabilities_page *cap)
>-{
>-	struct cdrom_info *info = drive->driver_data;
>-	struct cdrom_device_info *cdi = &info->devinfo;
>-	struct packet_command cgc;
>-	int stat, attempts = 3, size = sizeof(*cap);
>-
>-	/*
>-	 * ACER50 (and others?) require the full spec length mode sense
>-	 * page capabilities size, but older drives break.
>-	 */
>-	if (!(!strcmp(drive->id->model, "ATAPI CD ROM DRIVE 50X MAX") ||
>-	    !strcmp(drive->id->model, "WPI CDS-32X")))
>-		size -= sizeof(cap->pad);
>-
>-	init_cdrom_command(&cgc, cap, size, CGC_DATA_UNKNOWN);
>-	do { /* we seem to get stat=0x01,err=0x00 the first time (??) */
>-		stat = cdrom_mode_sense(cdi, &cgc, GPMODE_CAPABILITIES_PAGE, 0);
>-		if (!stat)
>-			break;
>-	} while (--attempts);
>-	return stat;
>-}
>-
>-static
> int ide_cdrom_probe_capabilities (ide_drive_t *drive)
> {
> 	struct cdrom_info *info = drive->driver_data;
>@@ -2978,20 +2998,7 @@ int ide_cdrom_probe_capabilities (ide_dr
> 		}
> 	}
> 
>-	/* The ACER/AOpen 24X cdrom has the speed fields byte-swapped */
>-	if (!drive->id->model[0] &&
>-	    !strncmp(drive->id->fw_rev, "241N", 4)) {
>-		CDROM_STATE_FLAGS(drive)->current_speed  = 
>-			(((unsigned int)cap.curspeed) + (176/2)) / 176;
>-		CDROM_CONFIG_FLAGS(drive)->max_speed = 
>-			(((unsigned int)cap.maxspeed) + (176/2)) / 176;
>-	} else {
>-		CDROM_STATE_FLAGS(drive)->current_speed  = 
>-			(ntohs(cap.curspeed) + (176/2)) / 176;
>-		CDROM_CONFIG_FLAGS(drive)->max_speed = 
>-			(ntohs(cap.maxspeed) + (176/2)) / 176;
>-	}
>-
>+	ide_cdrom_update_speed(drive, &cap);
> 	/* don't print speed if the drive reported 0.
> 	 */
> 	printk(KERN_INFO "%s: ATAPI", drive->name);
>
>
>  
>

