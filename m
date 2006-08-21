From: Lee Trager <Lee@PicturesInMotion.net>
Subject: Re: [PATCH] ide: Reinitilize idedisk_capacity for HPA drives on resume
Date: Mon, 21 Aug 2006 17:18:36 -0400
Message-ID: <44EA232C.30907@PicturesInMotion.net>
References: <44E9038D.4040109@PicturesInMotion.net>
 <44E9E05B.4030502@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_c1i9dEV23I/5pcyp8DikoA)"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta2.srv.hcvlny.cv.net ([167.206.4.197]:35192 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751125AbWHUVTX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Aug 2006 17:19:23 -0400
Received: from [192.168.1.102] (ool-4351c743.dyn.optonline.net [67.81.199.67])
 by mta2.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTP id <0J4D0043I9U9GO00@mta2.srv.hcvlny.cv.net> for
 linux-ide@vger.kernel.org; Mon, 21 Aug 2006 17:18:10 -0400 (EDT)
In-reply-to: <44E9E05B.4030502@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a multi-part message in MIME format.

--Boundary_(ID_c1i9dEV23I/5pcyp8DikoA)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

Sergei Shtylyov wrote:
> Hello.
>
> Lee Trager wrote:
>
>> This patch fixes a problem that when a computer with HPA on it's hard
>> drive comes out of sleep mode it needs the disks capacity reinitialized.
>
>> This is my first patch to the Linux kernel so if I did anything wrong
>> please be gentle ;)
>
>    Your mailer spoils tabs, so either attach your patch or use the
> different
> mailer.
>
> [...]
>
>> diff -Naur linux-2.6.18-rc4-old/drivers/ide/ide.c
>> linux-2.6.18-rc4/drivers/ide/ide.c
>> --- linux-2.6.18-rc4-old/drivers/ide/ide.c    2006-08-19
>> 03:49:03.000000000 -0400
>> +++ linux-2.6.18-rc4/drivers/ide/ide.c    2006-08-20 19:12:38.000000000
>> -0400
>> @@ -1232,6 +1232,7 @@
>>      struct request rq;
>>      struct request_pm_state rqpm;
>>      ide_task_t args;
>> +    int ide_cmd;
>>  
>>      memset(&rq, 0, sizeof(rq));
>>      memset(&rqpm, 0, sizeof(rqpm));
>> @@ -1242,7 +1243,15 @@
>>      rqpm.pm_step = ide_pm_state_start_resume;
>>      rqpm.pm_state = PM_EVENT_ON;
>>  
>> -    return ide_do_drive_cmd(drive, &rq, ide_head_wait);
>> +    ide_cmd = ide_do_drive_cmd(drive, &rq, ide_head_wait);
>> +
>> +    /* check to see if this is a hard drive
>> +     * if it is then checkhpa needs to be
>> +     * disabled */
>> +    if(drive->media == ide_disk && idedisk_supports_hpa(drive->id))
>> +        init_idedisk_capacity(drive);
>> +
>> +    return ide_cmd;
>>  }
>
>    Hm, shouldn't this be handled as a separate resume process step?
>
> MBR, Sergei
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
Ok I attached it now.

--Boundary_(ID_c1i9dEV23I/5pcyp8DikoA)
Content-type: text/plain; name=hpa-resume.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=hpa-resume.patch

diff -Naur linux-2.6.18-rc4-old/include/linux/ide.h linux-2.6.18-rc4/include/linux/ide.h
--- linux-2.6.18-rc4-old/include/linux/ide.h	2006-08-19 03:49:03.000000000 -0400
+++ linux-2.6.18-rc4/include/linux/ide.h	2006-08-20 19:13:10.000000000 -0400
@@ -1201,6 +1201,17 @@
 void ide_register_subdriver(ide_drive_t *, ide_driver_t *);
 void ide_unregister_subdriver(ide_drive_t *, ide_driver_t *);
 
+/* Bits 10 of command_set_1 and cfs_enable_1 must be equal,
+ * so on non-buggy drives we need test only one.
+ * However, we should also check whether these fields are valid.
+*/
+static inline int idedisk_supports_hpa(const struct hd_driveid *id)
+{
+        return (id->command_set_1 & 0x0400) && (id->cfs_enable_1 & 0x0400);
+}
+
+extern void init_idedisk_capacity (ide_drive_t  *drive);
+
 #define ON_BOARD		1
 #define NEVER_BOARD		0

diff -Naur linux-2.6.18-rc4-old/drivers/ide/ide-disk.c linux-2.6.18-rc4/drivers/ide/ide-disk.c
--- linux-2.6.18-rc4-old/drivers/ide/ide-disk.c	2006-08-19 03:49:03.000000000 -0400
+++ linux-2.6.18-rc4/drivers/ide/ide-disk.c	2006-08-20 19:13:56.000000000 -0400
@@ -464,16 +464,6 @@
 }
 
 /*
- * Bits 10 of command_set_1 and cfs_enable_1 must be equal,
- * so on non-buggy drives we need test only one.
- * However, we should also check whether these fields are valid.
- */
-static inline int idedisk_supports_hpa(const struct hd_driveid *id)
-{
-	return (id->command_set_1 & 0x0400) && (id->cfs_enable_1 & 0x0400);
-}
-
-/*
  * The same here.
  */
 static inline int idedisk_supports_lba48(const struct hd_driveid *id)
@@ -528,7 +518,7 @@
  * in above order (i.e., if value of higher priority is available,
  * reset will be ignored).
  */
-static void init_idedisk_capacity (ide_drive_t  *drive)
+void init_idedisk_capacity (ide_drive_t  *drive)
 {
 	struct hd_driveid *id = drive->id;
 	/*
@@ -555,6 +545,8 @@
 	}
 }
 
+EXPORT_SYMBOL(init_idedisk_capacity);
+
 static sector_t idedisk_capacity (ide_drive_t *drive)
 {
 	return drive->capacity64 - drive->sect0;
diff -Naur linux-2.6.18-rc4-old/drivers/ide/ide.c linux-2.6.18-rc4/drivers/ide/ide.c
--- linux-2.6.18-rc4-old/drivers/ide/ide.c	2006-08-19 03:49:03.000000000 -0400
+++ linux-2.6.18-rc4/drivers/ide/ide.c	2006-08-20 19:12:38.000000000 -0400
@@ -1232,6 +1232,7 @@
 	struct request rq;
 	struct request_pm_state rqpm;
 	ide_task_t args;
+	int ide_cmd;
 
 	memset(&rq, 0, sizeof(rq));
 	memset(&rqpm, 0, sizeof(rqpm));
@@ -1242,7 +1243,15 @@
 	rqpm.pm_step = ide_pm_state_start_resume;
 	rqpm.pm_state = PM_EVENT_ON;
 
-	return ide_do_drive_cmd(drive, &rq, ide_head_wait);
+	ide_cmd = ide_do_drive_cmd(drive, &rq, ide_head_wait);
+
+	/* check to see if this is a hard drive
+	 * if it is then checkhpa needs to be
+	 * disabled */
+	if(drive->media == ide_disk && idedisk_supports_hpa(drive->id))
+		init_idedisk_capacity(drive);
+
+	return ide_cmd;
 }
 
 int generic_ide_ioctl(ide_drive_t *drive, struct file *file, struct block_device *bdev,

--Boundary_(ID_c1i9dEV23I/5pcyp8DikoA)--
