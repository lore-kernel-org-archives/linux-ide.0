From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 0/2] add pata_arasan_cf support
Date: Fri, 18 Feb 2011 17:10:12 +0530
Message-ID: <cover.1298029161.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:51402 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754402Ab1BRLlL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2011 06:41:11 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: viresh.linux@gmail.com, shiraz.hashim@st.com, armando.visconti@st.com, amit.goel@st.com, Viresh Kumar <viresh.kumar@st.com>

This patch series adds
 - ata_sff_queue_work() & ata_sff_queue_delayed_work()
 - add support for arasan compact flash controller.

Changes Since V1:
 - add separate patch to introduce ata_sff_queue_work & ata_sff_queue_delayed_work 
 - remove arasan cf drivers workqueue.
 - remove drivers/ata/pata_arasan_cf.h and put register definitions in
   pata_arasan_cf.c
 - take ap->lock and host->lock at relevant places.
 - use bool for variables which can have value 0 or 1.
 - remove bmdma part and override freeze, qc_issue routines.
 - introduce concept of delayed_work if altstatus reg reads ATA_BUSY after DMA
   xfer are over.

Viresh Kumar (2):
  libata-sff: add ata_sff_queue_work() & ata_sff_queue_delayed_work()
  pata_arasan_cf: Adding support for arasan compact flash host
    controller

 MAINTAINERS                         |    7 +
 drivers/ata/Kconfig                 |    6 +
 drivers/ata/Makefile                |    1 +
 drivers/ata/libata-sff.c            |   15 +-
 drivers/ata/pata_arasan_cf.c        |  945 +++++++++++++++++++++++++++++++++++
 include/linux/libata.h              |    3 +
 include/linux/pata_arasan_cf_data.h |   47 ++
 7 files changed, 1022 insertions(+), 2 deletions(-)
 create mode 100644 drivers/ata/pata_arasan_cf.c
 create mode 100644 include/linux/pata_arasan_cf_data.h

-- 
1.7.2.2

