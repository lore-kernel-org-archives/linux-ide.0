From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: sparse patches for libata
Date: Wed, 13 Feb 2008 21:30:34 -0800
Message-ID: <1202967034.2748.37.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.232]:17294 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbYBNFah (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 00:30:37 -0500
Received: by wx-out-0506.google.com with SMTP id h31so227256wxd.4
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 21:30:36 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>

Just a note to let you know that with the series of 11 patches
I just sent, libata is almost sparse-clean on X86_32 (~250 sparse
warnings to ~40).

The remaining warnings are:

drivers/ata/libata-core.c:7089:7: warning: symbol 'rc' shadows an earlier one
drivers/ata/libata-core.c:7030:9: originally declared here
drivers/ata/libata-core.c:5610:2: warning: context imbalance in 'ata_hsm_move' - different lock contexts for basic block
drivers/ata/libata-core.c:4821:20: warning: potentially expensive pointer subtraction
drivers/ata/libata-core.c:5039:9: warning: potentially expensive pointer subtraction
drivers/ata/libata-core.c:5194:9: warning: potentially expensive pointer subtraction
drivers/ata/libata-core.c:6664:20: warning: potentially expensive pointer subtraction


[repeated 29 times, will look at possibly silencing this if it can be
done nicely]
include/linux/libata.h:1214:13: warning: potentially expensive pointer subtraction

include/linux/scatterlist.h:184:9: warning: potentially expensive pointer subtraction

drivers/ata/libata-scsi.c:1865:14: warning: symbol 'ata_scsiop_inq_89' was not declared. Should it be static?

Same issue as the FIT macro replacement patch I did, except open-coded
min_t and max_t.
drivers/ata/pata_amd.c:59:11: warning: symbol '__x' shadows an earlier one
drivers/ata/pata_amd.c:59:11: originally declared here

Other than that drivers/ata is sparse clean.

Cheers,

Harvey

