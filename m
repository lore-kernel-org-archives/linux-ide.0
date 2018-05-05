From: Mathieu Malaterre <malat@debian.org>
Subject: [PATCH] driver core: add __printf verification to __ata_ehi_pushv_desc
Date: Sat,  5 May 2018 22:00:37 +0200
Message-ID: <20180505200038.17840-1-malat@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

__printf is useful to verify format and arguments. Remove the following
warning (with W=1):

  drivers/ata/libata-eh.c:183:10: warning: function might be possible candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/ata/libata-eh.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index c016829a38fd..513b260bcff1 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -175,8 +175,8 @@ static void ata_eh_handle_port_resume(struct ata_port *ap)
 { }
 #endif /* CONFIG_PM */
 
-static void __ata_ehi_pushv_desc(struct ata_eh_info *ehi, const char *fmt,
-				 va_list args)
+static __printf(2, 0) void __ata_ehi_pushv_desc(struct ata_eh_info *ehi,
+				 const char *fmt, va_list args)
 {
 	ehi->desc_len += vscnprintf(ehi->desc + ehi->desc_len,
 				     ATA_EH_DESC_LEN - ehi->desc_len,
-- 
2.11.0
