From: Max Kellermann <max@duempel.org>
Subject: [PATCH] libata: add Samsung HD401LJ to the NCQ blacklist
Date: Wed, 18 Apr 2007 08:15:41 +0200
Message-ID: <20070418061541.GA11293@roonstrasse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932478AbXDRGQS@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Yet another hard drive which doesn't seem to get NCQ right.

 ata1: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl
 0x1501000 status 0x400 next cpb count 0xB next cpb idx 0x0
 [...]
 ata1: timeout waiting for ADMA IDLE, stat=0x400
 ata1: timeout waiting for ADMA LEGACY, stat=0x400
 ata1.00: exception Emask 0x0 SAct 0x3fff SErr 0x200000 action 0x2
 frozen
 [...]
 ata1: soft resetting port

http://lkml.org/lkml/2007/3/16/184

Signed-off-by: Max Kellermann <max@duempel.org>

 drivers/ata/libata-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0abd72d..39a4c05 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3374,6 +3374,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "Maxtor 6L250S0",     "BANC1G10",     ATA_HORKAGE_NONCQ },
 	/* NCQ hard hangs device under heavier load, needs hard power cycle */
 	{ "Maxtor 6B250S0",	"BANC1B70",	ATA_HORKAGE_NONCQ },
+        { "SAMSUNG HD401LJ",	NULL,		ATA_HORKAGE_NONCQ, },
 	/* Blacklist entries taken from Silicon Image 3124/3132
 	   Windows driver .inf file - also several Linux problem reports */
 	{ "HTS541060G9SA00",    "MB3OC60D",     ATA_HORKAGE_NONCQ, },
