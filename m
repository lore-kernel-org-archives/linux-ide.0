From: Jens Axboe <jens.axboe@oracle.com>
Subject: [PATCH] Maxtor 6B250S0/BANC1B70 hangs with NCQ
Date: Fri, 30 Mar 2007 09:27:58 +0200
Message-ID: <20070330072757.GC6246@kernel.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([62.242.22.158]:17882 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771AbXC3Hc7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Mar 2007 03:32:59 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, htejun@gmail.com, linux-ide@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've seen this several times on this drive, completely reproducible.
Once it has hung, power needs to be cut from the drive to recover it, a
simple reboot is not enough. So I'd suggest disabling NCQ on this
driver.

Error log attached.

Signed-off-by: Jens Axboe <jens.axboe@oracle.com>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f1f595f..ddb3909 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3361,6 +3361,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "FUJITSU MHT2060BH",	NULL,		ATA_HORKAGE_NONCQ },
 	/* NCQ is broken */
 	{ "Maxtor 6L250S0",     "BANC1G10",     ATA_HORKAGE_NONCQ },
+	/* NCQ hard hangs device under heavier load, needs hard power cycle */
+	{ "Maxtor 6B250S0",	"BANC1B70",	ATA_HORKAGE_NONCQ },
 
 	/* Devices with NCQ limits */
 

-- 
Jens Axboe


--J2SCkAp4GZ/dPZZf
Content-Type: text/x-log; charset=us-ascii
Content-Disposition: attachment; filename="maxtor-ncq-error.log"

ata1.00: exception Emask 0x0 SAct 0x7fffffff SErr 0x0 action 0x2 frozen
ata1.00: cmd 61/08:00:3f:00:f4/00:00:0c:00:00/40 tag 0 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:08:3f:00:f8/00:00:0c:00:00/40 tag 1 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:10:3f:00:fc/00:00:0c:00:00/40 tag 2 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:18:3f:00:00/00:00:0d:00:00/40 tag 3 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:20:3f:00:04/00:00:0d:00:00/40 tag 4 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:28:3f:00:08/00:00:0d:00:00/40 tag 5 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:30:3f:00:0c/00:00:0d:00:00/40 tag 6 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:38:3f:00:10/00:00:0d:00:00/40 tag 7 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:40:3f:00:14/00:00:0d:00:00/40 tag 8 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:48:3f:00:18/00:00:0d:00:00/40 tag 9 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:50:3f:00:1c/00:00:0d:00:00/40 tag 10 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:58:3f:00:20/00:00:0d:00:00/40 tag 11 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:60:3f:00:24/00:00:0d:00:00/40 tag 12 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:68:3f:00:28/00:00:0d:00:00/40 tag 13 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:70:3f:00:2c/00:00:0d:00:00/40 tag 14 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:78:3f:00:30/00:00:0d:00:00/40 tag 15 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:80:3f:00:34/00:00:0d:00:00/40 tag 16 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:88:3f:00:38/00:00:0d:00:00/40 tag 17 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:90:3f:00:3c/00:00:0d:00:00/40 tag 18 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:98:3f:00:40/00:00:0d:00:00/40 tag 19 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:a0:3f:00:44/00:00:0d:00:00/40 tag 20 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:a8:3f:00:48/00:00:0d:00:00/40 tag 21 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:b0:3f:00:4c/00:00:0d:00:00/40 tag 22 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:b8:3f:00:50/00:00:0d:00:00/40 tag 23 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:c0:3f:00:54/00:00:0d:00:00/40 tag 24 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:c8:3f:00:dc/00:00:0c:00:00/40 tag 25 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:d0:3f:00:e0/00:00:0c:00:00/40 tag 26 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:d8:3f:00:e4/00:00:0c:00:00/40 tag 27 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:e0:3f:00:e8/00:00:0c:00:00/40 tag 28 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:e8:3f:00:ec/00:00:0c:00:00/40 tag 29 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: cmd 61/08:f0:3f:00:f0/00:00:0c:00:00/40 tag 30 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: soft resetting port
ata1: port is slow to respond, please be patient (Status 0xc0)
ata1: port failed to respond (30 secs, Status 0xc0)
ata1: softreset failed (device not ready)
ata1: softreset failed, retrying in 5 secs
ata1: hard resetting port
ata1: port is slow to respond, please be patient (Status 0x80)
ata1: port failed to respond (30 secs, Status 0x80)
ata1: COMRESET failed (device not ready)
ata1: hardreset failed, retrying in 5 secs
ata1: hard resetting port
ata1: port is slow to respond, please be patient (Status 0x80)
ata1: port failed to respond (30 secs, Status 0x80)
ata1: COMRESET failed (device not ready)
ata1: reset failed, giving up
ata1.00: disabled
ata1: EH complete

--J2SCkAp4GZ/dPZZf--
