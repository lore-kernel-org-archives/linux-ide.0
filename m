From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: [PATCH] ata: libata-transport.c: local functions should not be exposed globally
Date: Mon, 16 Apr 2012 18:04:41 -0700
Message-ID: <201204161804.41337.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail131.messagelabs.com ([216.82.242.99]:61817 "EHLO
	mail131.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab2DQBE4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Apr 2012 21:04:56 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Functions not referenced outside of a source file should be marked
static to prevent it from being exposed globally.

This quiets the sparse warnings:

warning: symbol 'ata_is_port' was not declared. Should it be static?
warning: symbol 'ata_is_link' was not declared. Should it be static?
warning: symbol 'ata_is_ata_dev' was not declared. Should it be static?

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Jeff Garzik <jgarzik@pobox.com>

---

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 74aaee3..201672a 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -232,7 +232,7 @@ static void ata_tport_release(struct device *dev)
  * Returns:
  *	%1 if the device represents a ATA Port, %0 else
  */
-int ata_is_port(const struct device *dev)
+static int ata_is_port(const struct device *dev)
 {
 	return dev->release == ata_tport_release;
 }
@@ -354,7 +354,7 @@ static void ata_tlink_release(struct device *dev)
  * Returns:
  *	%1 if the device represents a ATA link, %0 else
  */
-int ata_is_link(const struct device *dev)
+static int ata_is_link(const struct device *dev)
 {
 	return dev->release == ata_tlink_release;
 }
@@ -571,7 +571,7 @@ static void ata_tdev_release(struct device *dev)
  * Returns:
  *	%1 if the device represents a ATA device, %0 else
  */
-int ata_is_ata_dev(const struct device *dev)
+static int ata_is_ata_dev(const struct device *dev)
 {
 	return dev->release == ata_tdev_release;
 }
