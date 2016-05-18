From: Damien Le Moal <Damien.LeMoal@hgst.com>
Subject: [PATCH 0/3] ZAC fixes
Date: Wed, 18 May 2016 00:53:04 +0000
Message-ID: <BL2PR04MB19696D0FCFD09EE954C8F2B29F490@BL2PR04MB1969.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sjc00mx1.hgst.com ([199.255.44.36]:30730 "EHLO
	sjc00mx1.hgst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbcERAxI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 May 2016 20:53:08 -0400
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Hannes Reinecke <hare@suse.com>


3 patches to go on top of for-4.7-zac (and Hannes zbc.v6 branch) fixing 
several problems with the NCQ encapsulation of ZAC commands.
The first two are trivial bug fixes.

The third one addresses problems with ATA_CMD_NCQ_NON_DATA command 
processing: this command has no data but ata_is_data and ata_is_dma 
return true, leading to 100% failure on issue for this command. This is 
fixed by changing the interface of ata_is_data and ata_is_dma to also 
allow testing the command code of a task file. For consistency, it may 
be good to change in the same manner the interface of all ata_is_xxx 
functions.

Damien Le Moal (3):
   libata-scsi: Fix translation of REPORT ZONES command
   libata-scsi: Fix ZBC management out command translation
   libata: Fix ATA_CMD_NCQ_NON_DATA processing

  drivers/ata/libata-core.c    |  4 ++--
  drivers/ata/libata-scsi.c    | 14 +++++++-------
  drivers/ata/libata-sff.c     | 10 +++++-----
  drivers/ata/pata_arasan_cf.c |  4 ++--
  drivers/ata/sata_dwc_460ex.c |  6 +++---
  drivers/ata/sata_inic162x.c  |  4 ++--
  drivers/ata/sata_sil.c       |  4 ++--
  drivers/ata/sata_sil24.c     |  4 ++--
  include/linux/libata.h       | 18 ++++++++++++++----
  9 files changed, 39 insertions(+), 29 deletions(-)

-- 
2.5.5


-- 
Damien Le Moal, Ph.D.
Sr. Manager, System Software Group, HGST Research,
HGST, a Western Digital company
Damien.LeMoal@hgst.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.hgst.com
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.

