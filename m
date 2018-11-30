From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH RFC 07/15] ide: replace **** with a hug
Date: Fri, 30 Nov 2018 11:27:16 -0800
Message-ID: <20181130192737.15053-8-jarkko.sakkinen@linux.intel.com>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, "open list:IDE SUBSYSTEM" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

In order to comply with the CoC, replace **** with a hug.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/ide/cmd640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/cmd640.c b/drivers/ide/cmd640.c
index 004243bd84db..c3b7abf314af 100644
--- a/drivers/ide/cmd640.c
+++ b/drivers/ide/cmd640.c
@@ -11,7 +11,7 @@
  *  This file provides support for the advanced features and bugs
  *  of IDE interfaces using the CMD Technologies 0640 IDE interface chip.
  *
- *  These chips are basically fucked by design, and getting this driver
+ *  These chips are basically hugged by design, and getting this driver
  *  to work on every motherboard design that uses this screwed chip seems
  *  bloody well impossible.  However, we're still trying.
  *
-- 
2.19.1
