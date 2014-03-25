From: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v4 1/4] ata: ahci_platform: fix ahci_platform_data->suspend
	method handling
Date: Tue, 25 Mar 2014 19:51:38 +0100
Message-ID: <1395773501-6663-2-git-send-email-b.zolnierkie@samsung.com>
References: <1395773501-6663-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1395773501-6663-1-git-send-email-b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Viresh Kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Looking at ST SPEAr1340 AHCI code (the only user of the deprecated
pdata->suspend and pdata->resume) it is obvious the we should return
after calling pdata->suspend() only if the function have returned
non-zero return value.  The code has been broken since commit 1e70c2
("ata/ahci_platform: Add clock framework support").  Fix it.

Cc: Viresh Kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
Acked-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
v4:
- no changes
v3:
- no changes
v2:
- updated patch description

 drivers/ata/ahci_platform.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 70fbf66..7bd6adf 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -521,12 +521,19 @@ int ahci_platform_suspend(struct device *dev)
 	if (rc)
 		return rc;
 
-	if (pdata && pdata->suspend)
-		return pdata->suspend(dev);
+	if (pdata && pdata->suspend) {
+		rc = pdata->suspend(dev);
+		if (rc)
+			goto resume_host;
+	}
 
 	ahci_platform_disable_resources(hpriv);
 
 	return 0;
+
+resume_host:
+	ahci_platform_resume_host(dev);
+	return rc;
 }
 EXPORT_SYMBOL_GPL(ahci_platform_suspend);
 
-- 
1.8.2.3
