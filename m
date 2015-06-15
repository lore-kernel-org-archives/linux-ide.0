From: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH 4/4] libata: Fall back to unqueued READ LOG EXT if the DMA variant fails
Date: Mon, 15 Jun 2015 10:24:59 -0500
Message-ID: <20150615152459.GA14007@dhcp-10-15-1-8.hsv.redhat.com>
References: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com> <1430790861-30066-4-git-send-email-martin.petersen@oracle.com> <557B39FB.4060304@redhat.com> <yq1wpz5hn0y.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36753 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288AbbFOPNZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Jun 2015 11:13:25 -0400
Content-Disposition: inline
In-Reply-To: <yq1wpz5hn0y.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, hare@suse.de, tj@kernel.org

On Sun, Jun 14, 2015 at 07:45:49PM -0400, Martin K. Petersen wrote:
> >>>>> "David" == David Milburn <dmilburn@redhat.com> writes:
> 
> David> Have you seen both commands fail on any of the Samsung SSD 840
> David> EVO drives?
> 
> David> # dmesg | grep Samsung [ 2.254443] ata10.00: ATA-9: Samsung SSD
> David> 840 EVO 1TB, EXT0BB6Q, max UDMA/133
> 
> I have an 840 EVO in my test box. However, yours is running an older
> firmware that predates queued TRIM support. So I guess that's
> expected...

Ahh, ok, would it be ok to slightly change the error message to indicate
the drive doesn't support queued TRIM.

Thanks.

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8e533f7..601d4f2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2128,6 +2128,7 @@ static int ata_dev_config_ncq(struct ata_device *dev,
 					     0, ap->sector_buf, 1);
 		if (err_mask) {
 			ata_dev_dbg(dev,
+				    "Drive doesn't support queued TRIM, "
 				    "failed to get NCQ Send/Recv Log Emask 0x%x\n",
 				    err_mask);
 		} else {
-- 
1.8.3.1

