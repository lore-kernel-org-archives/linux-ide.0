From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 01/12] ahci: Fix some sparse warnings
Date: Tue, 2 Mar 2010 21:29:25 +0300
Message-ID: <20100302182925.GA3445@oksana.dev.rtsoft.ru>
References: <20100302182850.GA32057@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:38714 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751927Ab0CBS31 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Mar 2010 13:29:27 -0500
Content-Disposition: inline
In-Reply-To: <20100302182850.GA32057@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Following warnings were fixed:

ahci.c:359:1: warning: symbol 'dev_attr_ahci_host_caps' was not declared. Should it be static?
ahci.c:360:1: warning: symbol 'dev_attr_ahci_host_cap2' was not declared. Should it be static?
ahci.c:361:1: warning: symbol 'dev_attr_ahci_host_version' was not declared. Should it be static?
ahci.c:362:1: warning: symbol 'dev_attr_ahci_port_cmd' was not declared. Should it be static?

This was left over:

ahci.c:382:9: warning: Initializer entry defined twice
ahci.c:383:10:   also defined here

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/ata/ahci.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a6a736a..ef7949a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -356,10 +356,10 @@ static ssize_t ahci_show_host_version(struct device *dev,
 static ssize_t ahci_show_port_cmd(struct device *dev,
 				  struct device_attribute *attr, char *buf);
 
-DEVICE_ATTR(ahci_host_caps, S_IRUGO, ahci_show_host_caps, NULL);
-DEVICE_ATTR(ahci_host_cap2, S_IRUGO, ahci_show_host_cap2, NULL);
-DEVICE_ATTR(ahci_host_version, S_IRUGO, ahci_show_host_version, NULL);
-DEVICE_ATTR(ahci_port_cmd, S_IRUGO, ahci_show_port_cmd, NULL);
+static DEVICE_ATTR(ahci_host_caps, S_IRUGO, ahci_show_host_caps, NULL);
+static DEVICE_ATTR(ahci_host_cap2, S_IRUGO, ahci_show_host_cap2, NULL);
+static DEVICE_ATTR(ahci_host_version, S_IRUGO, ahci_show_host_version, NULL);
+static DEVICE_ATTR(ahci_port_cmd, S_IRUGO, ahci_show_port_cmd, NULL);
 
 static struct device_attribute *ahci_shost_attrs[] = {
 	&dev_attr_link_power_management_policy,
-- 
1.7.0

