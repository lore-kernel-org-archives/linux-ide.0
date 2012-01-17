From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v4 05/10] libsas: check for 'gone' expanders in
 smp_execute_task()
Date: Mon, 16 Jan 2012 21:11:27 -0800
Message-ID: <20120117051127.22344.52386.stgit@localhost6.localdomain6>
References: <20120117050847.22344.4961.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20120117050847.22344.4961.stgit@localhost6.localdomain6>
Sender: linux-scsi-owner@vger.kernel.org
To: linux-scsi@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

No sense in issuing or retrying commands to an expander that has been
removed.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/scsi/libsas/sas_expander.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 7701ab5..6fb1f3a 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -74,6 +74,11 @@ static int smp_execute_task(struct domain_device *dev, void *req, int req_size,
 
 	mutex_lock(&dev->ex_dev.cmd_mutex);
 	for (retry = 0; retry < 3; retry++) {
+		if (test_bit(SAS_DEV_GONE, &dev->state)) {
+			res = -ECOMM;
+			break;
+		}
+
 		task = sas_alloc_task(GFP_KERNEL);
 		if (!task) {
 			res = -ENOMEM;

