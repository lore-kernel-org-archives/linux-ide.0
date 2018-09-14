From: Romain Aviolat <r.aviolat@gmail.com>
Subject: [PATCH] IDE: ide-dma: fix coding style issues with spaces
Date: Fri, 14 Sep 2018 22:25:40 +0200
Message-ID: <20180914202540.11977-1-r.aviolat@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Romain Aviolat <r.aviolat@gmail.com>
List-Id: linux-ide@vger.kernel.org

Fixing multiple coding style issues:
	* prohibited spaces before that ','
	* spaces before tabs

Signed-off-by: Romain Aviolat <r.aviolat@gmail.com>
---
 drivers/ide/ide-dma.c | 74 +++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index 6f344654ef22..1bde6a0ffa11 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -37,46 +37,46 @@
 #include <linux/dma-mapping.h>
 
 static const struct drive_list_entry drive_whitelist[] = {
-	{ "Micropolis 2112A"	,       NULL		},
-	{ "CONNER CTMA 4000"	,       NULL		},
-	{ "CONNER CTT8000-A"	,       NULL		},
-	{ "ST34342A"		,	NULL		},
-	{ NULL			,	NULL		}
+	{ "Micropolis 2112A",	NULL	},
+	{ "CONNER CTMA 4000",	NULL	},
+	{ "CONNER CTT8000-A",	NULL	},
+	{ "ST34342A",		NULL	},
+	{ NULL,			NULL	}
 };
 
 static const struct drive_list_entry drive_blacklist[] = {
-	{ "WDC AC11000H"	,	NULL 		},
-	{ "WDC AC22100H"	,	NULL 		},
-	{ "WDC AC32500H"	,	NULL 		},
-	{ "WDC AC33100H"	,	NULL 		},
-	{ "WDC AC31600H"	,	NULL 		},
-	{ "WDC AC32100H"	,	"24.09P07"	},
-	{ "WDC AC23200L"	,	"21.10N21"	},
-	{ "Compaq CRD-8241B"	,	NULL 		},
-	{ "CRD-8400B"		,	NULL 		},
-	{ "CRD-8480B",			NULL 		},
-	{ "CRD-8482B",			NULL 		},
-	{ "CRD-84"		,	NULL 		},
-	{ "SanDisk SDP3B"	,	NULL 		},
-	{ "SanDisk SDP3B-64"	,	NULL 		},
-	{ "SANYO CD-ROM CRD"	,	NULL 		},
-	{ "HITACHI CDR-8"	,	NULL 		},
-	{ "HITACHI CDR-8335"	,	NULL 		},
-	{ "HITACHI CDR-8435"	,	NULL 		},
-	{ "Toshiba CD-ROM XM-6202B"	,	NULL 		},
-	{ "TOSHIBA CD-ROM XM-1702BC",	NULL 		},
-	{ "CD-532E-A"		,	NULL 		},
-	{ "E-IDE CD-ROM CR-840",	NULL 		},
-	{ "CD-ROM Drive/F5A",	NULL 		},
-	{ "WPI CDD-820",		NULL 		},
-	{ "SAMSUNG CD-ROM SC-148C",	NULL 		},
-	{ "SAMSUNG CD-ROM SC",	NULL 		},
-	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM",	NULL 		},
-	{ "_NEC DV5800A",               NULL            },
-	{ "SAMSUNG CD-ROM SN-124",	"N001" },
-	{ "Seagate STT20000A",		NULL  },
-	{ "CD-ROM CDR_U200",		"1.09" },
-	{ NULL			,	NULL		}
+	{ "WDC AC11000H",			NULL		},
+	{ "WDC AC22100H",			NULL		},
+	{ "WDC AC32500H",			NULL		},
+	{ "WDC AC33100H",			NULL		},
+	{ "WDC AC31600H",			NULL		},
+	{ "WDC AC32100H",			"24.09P07"	},
+	{ "WDC AC23200L",			"21.10N21"	},
+	{ "Compaq CRD-8241B",			NULL		},
+	{ "CRD-8400B",				NULL		},
+	{ "CRD-8480B",				NULL		},
+	{ "CRD-8482B",				NULL		},
+	{ "CRD-84",				NULL		},
+	{ "SanDisk SDP3B",			NULL		},
+	{ "SanDisk SDP3B-64",			NULL		},
+	{ "SANYO CD-ROM CRD",			NULL		},
+	{ "HITACHI CDR-8",			NULL		},
+	{ "HITACHI CDR-8335",			NULL		},
+	{ "HITACHI CDR-8435",			NULL		},
+	{ "Toshiba CD-ROM XM-6202B",		NULL		},
+	{ "TOSHIBA CD-ROM XM-1702BC",		NULL		},
+	{ "CD-532E-A",				NULL		},
+	{ "E-IDE CD-ROM CR-840",		NULL		},
+	{ "CD-ROM Drive/F5A",			NULL		},
+	{ "WPI CDD-820",			NULL		},
+	{ "SAMSUNG CD-ROM SC-148C",		NULL		},
+	{ "SAMSUNG CD-ROM SC",			NULL		},
+	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM",	NULL		},
+	{ "_NEC DV5800A",			NULL		},
+	{ "SAMSUNG CD-ROM SN-124",		"N001"		},
+	{ "Seagate STT20000A",			NULL		},
+	{ "CD-ROM CDR_U200",			"1.09"		},
+	{ NULL,					NULL		}
 
 };
 
-- 
2.17.1
