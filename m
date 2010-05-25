From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH] libata: Add libata transport class.
Date: Tue, 25 May 2010 12:31:37 -0700
Message-ID: <1274815898-14439-1-git-send-email-gwendal@google.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:55533 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758533Ab0EYTeH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 May 2010 15:34:07 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@google.com>

This is a scheleton for libata transport class. 
It has been proposed a while back, I upgraded to work on 2.6.34rc7

Gwendal Grignou (1):
  Add libata transport class.

 Documentation/ABI/testing/sysfs-ata |   99 +++++
 drivers/ata/Makefile                |    2 +-
 drivers/ata/libata-core.c           |   43 ++-
 drivers/ata/libata-eh.c             |   35 +-
 drivers/ata/libata-pmp.c            |   18 +-
 drivers/ata/libata-scsi.c           |   21 +-
 drivers/ata/libata-transport.c      |  773 +++++++++++++++++++++++++++++++++++
 drivers/ata/libata-transport.h      |   18 +
 drivers/ata/libata.h                |    7 +
 include/linux/libata.h              |    5 +
 10 files changed, 982 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-ata
 create mode 100644 drivers/ata/libata-transport.c
 create mode 100644 drivers/ata/libata-transport.h

