From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 12/14] ata: pata_octeon_cf: Use I/O clock rate for timing calculations.
Date: Thu,  7 Oct 2010 16:03:51 -0700
Message-ID: <1286492633-26885-13-git-send-email-ddaney@caviumnetworks.com>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Cc: David Daney <ddaney@caviumnetworks.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The creation of the I/O clock domain requires some adjustments.  Since
the CF bus timing logic is clocked by the I/O clock, use its rate for
delay calculations.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org
---
 drivers/ata/pata_octeon_cf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 06ddd91..74b8298 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -60,7 +60,7 @@ static unsigned int ns_to_tim_reg(unsigned int tim_mult, unsigned int nsecs)
 	 * Compute # of eclock periods to get desired duration in
 	 * nanoseconds.
 	 */
-	val = DIV_ROUND_UP(nsecs * (octeon_get_clock_rate() / 1000000),
+	val = DIV_ROUND_UP(nsecs * (octeon_get_io_clock_rate() / 1000000),
 			  1000 * tim_mult);
 
 	return val;
-- 
1.7.2.3
