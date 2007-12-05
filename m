From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: improve ATAPI data transfer handling, take #3
Date: Wed,  5 Dec 2007 16:43:00 +0900
Message-ID: <11968405951262-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:33171 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbXLEHnf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 02:43:35 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6895624wah
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 23:43:35 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

Hello,

This is the third take of improve-ATAPI-data-transfer patchset.
Changes from the last take [L] are.

* 0001-libata-make-atapi_request_sense-use-sg.patch was moved forward
  as Jeff requested.

* 0002-libata-zero-xfer-length-on-ATAPI-data-xfer-IRQ-is-H.patch from
  Albert Lee is added.

* s/buflen/len/ dropped from 0007-change-data_xfer.patch.

* 0012-libata-make-qc-nbytes-include-extra-buffers.patch is previous
  add-dma_nbytes patch.  qc->nbytes is now updated directly and the
  original value is stored in qc->raw_nbytes.

This patchset is against #upstream (f5d10948).

This patchset is also available as the following git tree.

  master.kernel.org:/pub/scm/linux/kernel/git/tj/libata-dev.git improve-ATAPI-data-transfer

If you don't wanna pull the last use-PIO-for-misc-ATAPI-commands
patch, pull from the following head.

  master.kernel.org:/pub/scm/linux/kernel/git/tj/libata-dev.git improve-ATAPI-data-transfer-no-pio

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/25569
