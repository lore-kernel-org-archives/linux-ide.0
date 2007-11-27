From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: improve ATAPI data transfer handling
Date: Wed, 28 Nov 2007 00:13:46 +0900
Message-ID: <11961764391983-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.182]:60821 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829AbXK0POK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 10:14:10 -0500
Received: by ro-out-1112.google.com with SMTP id p4so1688059roc
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 07:14:09 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com


Hello guys,

This patchset improves ATAPI PIO/DMA data transfer handling and
contains the following thirteen patches.

 0001-libata-update-atapi_eh_request_sense-such-that-lb.patch
 0002-cdrom-add-more-GPCMD_-constants.patch
 0003-libata-rename-ATA_PROT_ATAPI_-to-ATAPI_PROT_.patch
 0004-libata-add-ATAPI_-cmd-types-and-implement-atapi_cm.patch
 0005-libata-improve-ATAPI-draining.patch
 0006-libata-make-atapi_request_sense-use-sg.patch
 0007-libata-kill-non-sg-DMA-interface.patch
 0008-libata-change-ATA_QCFLAG_DMAMAP-semantics.patch
 0009-libata-convert-to-chained-sg.patch
 0010-libata-add-qc-dma_nbytes.patch
 0011-libata-implement-ATAPI-drain-buffer.patch
 0012-libata-implement-ATAPI-per-command-type-DMA-horkage.patch
 0013-libata-use-PIO-for-misc-ATAPI-commands.patch

0001-0004 are miscellaneous preparation patches.

0005 improves PIO draining.  This should fix regressions introduced by
setting transfer chunk size to allocation size.  I'll post simplified
version for #upstream-fixes.

0006-0008 kills non-sg DMA paths and clean up ATA_QCFLAG_DMAMAP
semantics.

0009 makes libata use chained sg instead of libata's private sg
iteration mechanism.  This is a clean up and will help implementing
DMA and PIO-over-DMA draining.

0010 adds qc->dma_nbytes which represents actual length of buffer
visible to host controller.

0011 implements DMA and PIO-over-DMA draining for misc ATAPI commands.
With this change, all of my ten ATAPI devcies can cope well with
shorter, matching and longer buffers.

0012 implements per-command type ATAPI DMA horkages.  These horkages
kick in on the first failure and don't interfere with other types of
operations.  This should allow libata to go on even when ATAPI DMA
support is flaky.

0013 makes libata always use PIO for misc ATAPI commands.  Yeah, even
with all the previous patches, I think it's much better to
unconditionally use PIO for misc ATAPI commands.  There isn't much to
lose by using PIO and IMHO it's wiser to concentrate our effort into
perfecting PIO support for misc commands and DMA support for bulk data
transfers.  Even if this one gets NACKed now it's definitely something
to think about.

This patchset is against

   #upstream (51a7ee37eaa85b8c35fe6090618e34ed4ce1d316)
 + improve-speed-down patchset, take #3  [1]
 + improve-timing-cod-and-fix-pata_amd, take #2 [2]

This patchset is also available as the following git tree.

master.kernel.org:/pub/scm/linux/kernel/git/tj/libata-dev.git improve-ATAPI-data-transfer

Thanks.

--
tejun

[1] http://thread.gmane.org/gmane.linux.ide/25406
[2] http://thread.gmane.org/gmane.linux.ide/25416
