From: Greg KH <gregkh@suse.de>
Subject: [patch 04/12] ata_piix: update map 10b for ich8m
Date: Tue, 14 Aug 2007 00:29:07 -0700
Message-ID: <20070814072907.GE15025@kroah.com>
References: <20070814072244.882283903@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751401AbXHNHsv@vger.kernel.org>
Content-Disposition: inline; filename="ata_piix-update-map-10b-for-ich8m.patch"
In-Reply-To: <20070814072813.GA15025@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@kernel.org, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, kristen.c.accardi@intel.com
Cc: Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Michael Krufky <mkrufky@linuxtv.org>, Chuck Ebbert <cebbert@redhat.com>, Domenico Andreoli <cavokz@gmail.com>, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Tejun Heo <htejun@gmail.com>

Fix map entry 10b for ich8.  It's [P0 P2 IDE IDE] like ich6 / ich6m.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Acked-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/ata/ata_piix.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -428,7 +428,7 @@ static const struct piix_map_db ich8_map
 		/* PM   PS   SM   SS       MAP */
 		{  P0,  P2,  P1,  P3 }, /* 00b (hardwired when in AHCI) */
 		{  RV,  RV,  RV,  RV },
-		{  IDE,  IDE,  NA,  NA }, /* 10b (IDE mode) */
+		{  P0,  P2, IDE, IDE }, /* 10b (IDE mode) */
 		{  RV,  RV,  RV,  RV },
 	},
 };

-- 
