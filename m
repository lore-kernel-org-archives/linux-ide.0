From: Tejun Heo <htejun@gmail.com>
Subject: Re: smartctl causing HSM violation on sata_nv, 2.6.18
Date: Thu, 28 Sep 2006 15:54:09 +0900
Message-ID: <20060928065409.GI25800@htj.dyndns.org>
References: <20060927183339.GA28174@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:15247 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161048AbWI1GyP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Sep 2006 02:54:15 -0400
Received: by py-out-1112.google.com with SMTP id n25so620665pyg
        for <linux-ide@vger.kernel.org>; Wed, 27 Sep 2006 23:54:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060927183339.GA28174@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: linux-ide@vger.kernel.org, smartmontools-support@lists.sourceforge.net

Hello, Jim Paris, Bruce Allen.

On Wed, Sep 27, 2006 at 02:33:39PM -0400, Jim Paris wrote:
> Hi Tejun,
> 
> My NVIDIA SATA controller is having some problems with smartctl on
> 2.6.18 (+ the previously mentioned sata_nv patch).  If I try to enable
> Attribute Autosafe (smartctl -S on) or Automatic Offline (smartctl -o
> on), the controller craps out (but recovers).  Executing the same
> command on an identical disk connected to a SiI3132 works fine.  Other
> SMART stuff (reading attributes, running self-tests) seems to be
> behaving just fine.  

This is because smartctl issues AUTOSAVE and AUTO_OFFLINE w/
HDIO_DRIVE_CMD.  Both SMART subcommands are non-data but still use
non-zero NSECT field.  HDIO_DRIVE_CMD assumes data-in protocol when
NSECT is non-zero.  libata HSM implementation is stricter than ide's
and declares HSM violation when device reports command complete when
it's expecting DRQ.

> ### sata_nv controller (CK804):
> 
> # smartctl -data -S on /dev/disk/by-path/pci-0000:00:07.0-scsi-0:0:0:0
> smartctl version 5.36 [x86_64-unknown-linux-gnu] Copyright (C) 2002-6 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
> 
> === START OF ENABLE/DISABLE COMMANDS SECTION ===
> Error SMART Enable Auto-save failed: Input/output error
> Smartctl: SMART Enable Attribute Autosave Failed.
> 
> A mandatory SMART command failed: exiting. To continue, add one or more '-T permissive' options.
> 
> 
> ### sata_sil24 controller (SiI3132):
> 
> # smartctl -data -S on /dev/disk/by-path/pci-0000:04:00.0-scsi-0:0:0:0
> smartctl version 5.36 [x86_64-unknown-linux-gnu] Copyright (C) 2002-6 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
> 
> === START OF ENABLE/DISABLE COMMANDS SECTION ===
> SMART Attribute Autosave Enabled.

sata_sil24 works because the controller hardware snoops the command
and determines protocol by itself.  So, regardless of what the ioctl
says, it executes the command with non-data protocol.

The following patch against smartmontools-5.36 converts it to use
HDIO_DRIVE_TASK ioctl for AUTOSAVE and AUTO_OFFLINE which don't have
the above issue.

Thanks.

diff -uNr smartmontools-5.36/os_linux.c smartmontools-5.36-fixed/os_linux.c
--- smartmontools-5.36/os_linux.c	2006-04-13 02:02:19.000000000 +0900
+++ smartmontools-5.36-fixed/os_linux.c	2006-09-28 15:41:06.000000000 +0900
@@ -383,14 +383,10 @@
 //   1 if the command succeeded and disk SMART status is "FAILING"
 
 
-// huge value of buffer size needed because HDIO_DRIVE_CMD assumes
-// that buff[3] is the data size.  Since the ATA_SMART_AUTOSAVE and
-// ATA_SMART_AUTO_OFFLINE use values of 0xf1 and 0xf8 we need the space.
-// Otherwise a 4+512 byte buffer would be enough.
-#define STRANGE_BUFFER_LENGTH (4+512*0xf8)
+#define BUFFER_LEN (4+512)
 
 int ata_command_interface(int device, smart_command_set command, int select, char *data){
-  unsigned char buff[STRANGE_BUFFER_LENGTH];
+  unsigned char buff[BUFFER_LEN];
   // positive: bytes to write to caller.  negative: bytes to READ from
   // caller. zero: non-data command
   int copydata=0;
@@ -407,7 +403,7 @@
   // buff[2] contains the ATA SECTOR COUNT REGISTER
   
   // clear out buff.  Large enough for HDIO_DRIVE_CMD (4+512 bytes)
-  memset(buff, 0, STRANGE_BUFFER_LENGTH);
+  memset(buff, 0, BUFFER_LEN);
 
   buff[0]=ATA_SMART_CMD;
   switch (command){
@@ -457,12 +453,14 @@
     buff[2]=ATA_SMART_STATUS;
     break;
   case AUTO_OFFLINE:
-    buff[2]=ATA_SMART_AUTO_OFFLINE;
-    buff[3]=select;   // YET NOTE - THIS IS A NON-DATA COMMAND!!
+    // NSECT is 241 for enable but no data transfer.  Use TASK ioctl.
+    buff[1]=ATA_SMART_AUTO_OFFLINE;
+    buff[2]=select;
     break;
   case AUTOSAVE:
-    buff[2]=ATA_SMART_AUTOSAVE;
-    buff[3]=select;   // YET NOTE - THIS IS A NON-DATA COMMAND!!
+    // NSECT is 248 for enable but no data transfer.  Use TASK ioctl.
+    buff[1]=ATA_SMART_AUTOSAVE;
+    buff[2]=select;
     break;
   case IMMEDIATE_OFFLINE:
     buff[2]=ATA_SMART_IMMEDIATE_OFFLINE;
@@ -517,7 +515,7 @@
     
   // There are two different types of ioctls().  The HDIO_DRIVE_TASK
   // one is this:
-  if (command==STATUS_CHECK){
+  if (command==AUTO_OFFLINE || command==AUTOSAVE || command==STATUS_CHECK){
     int retval;
 
     // NOT DOCUMENTED in /usr/src/linux/include/linux/hdreg.h. You

