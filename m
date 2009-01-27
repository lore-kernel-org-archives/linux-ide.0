From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Re: [PATCH 1/4] ide: remove IDE_ARCH_INTR
Date: Tue, 27 Jan 2009 11:42:54 -0800 (PST)
Message-ID: <393174.25588.qm@web52403.mail.re2.yahoo.com>
References: <20090127180246.28089.2981.sendpatchset@localhost.localdomain> <20090127180252.28089.70513.sendpatchset@localhost.localdomain>
Reply-To: "David D. Kilzer" <ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitz@debian.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-m68k@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

[Apologies for resending. The mailing lists on vger freaked out over MIME content in the last message.]

-            (void)ide_ack_intr(hwif);
+            if (hwif->ack_intr(hwif))
+                hwif->ack_intr(hwif);

Shouldn't that be:

-            (void)ide_ack_intr(hwif);
+            if (hwif->ack_intr)
+                hwif->ack_intr(hwif);

Dave
