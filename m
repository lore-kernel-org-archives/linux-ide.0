From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Match DMA blacklist entries between ide-dma.c and libata-core.c
Date: Mon, 21 May 2007 22:01:35 -0700
Message-ID: <7v3b1pbgeo.fsf_-_@assigned-by-dhcp.cox.net>
References: <20070521145042.GA6957@redhat.com>
	<20070521171551.0f81a0be@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759344AbXEVFBq@vger.kernel.org>
In-Reply-To: <20070521171551.0f81a0be@the-village.bc.nu> (Alan Cox's message
	of "Mon, 21 May 2007 17:15:51 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, bzolnier@gmail.com, linux-ide@vger.kernel.org, Dave Jones <davej@redhat.com>
List-Id: linux-ide@vger.kernel.org

There are a few entries in ata_device_blacklist[] in libata-core.c
marked with HORKAGE_NODMA but are missing from drive_blacklist[]
in ide-dma.c.  This patch makes the lists in sync.

Also remove a duplicated entry for "SanDisk SDP3B-64".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Recently Alan Cox responded that libata blacklist needs to be
   kept in sync when Dave Jones added STT20000A to DMA blacklist
   in ide-dma.c
---
 drivers/ide/ide-dma.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index b77b7d1..ead141e 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -119,15 +119,17 @@ static const struct drive_list_entry drive_blacklist [] = {
 	{ "HITACHI CDR-8335"	,	"ALL"		},
 	{ "HITACHI CDR-8435"	,	"ALL"		},
 	{ "Toshiba CD-ROM XM-6202B"	,	"ALL"		},
+	{ "TOSHIBA CD-ROM XM-1702BC",	"ALL"		},
 	{ "CD-532E-A"		,	"ALL"		},
 	{ "E-IDE CD-ROM CR-840",	"ALL"		},
 	{ "CD-ROM Drive/F5A",	"ALL"		},
 	{ "WPI CDD-820",		"ALL"		},
 	{ "SAMSUNG CD-ROM SC-148C",	"ALL"		},
 	{ "SAMSUNG CD-ROM SC",	"ALL"		},
-	{ "SanDisk SDP3B-64"	,	"ALL"		},
 	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM",	"ALL"		},
 	{ "_NEC DV5800A",               "ALL"           },  
+	{ "SAMSUNG CD-ROM SN-124",	"N001" },
+	{ "Seagate STT20000A",		"ALL" },
 	{ NULL			,	NULL		}
 
 };
-- 
1.5.2.24.g93d4
