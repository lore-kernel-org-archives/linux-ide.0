From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: implement new initialization model, take #4
Date: Wed, 11 Apr 2007 15:42:04 +0900
Message-ID: <1176273724198-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:40900 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbXDKGmJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Apr 2007 02:42:09 -0400
Received: by nz-out-0506.google.com with SMTP id s1so57271nze
        for <linux-ide@vger.kernel.org>; Tue, 10 Apr 2007 23:42:08 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, brking@linux.vnet.ibm.com, htejun@gmail.com

Hello, all.

This is the fourth take of new-init-model patchset.  Changes from the
last take[L] are...

* memory leak fixed in patch#1
* s/attach/register/g
* ap->cbl == ATA_CBL_* test replaced with ATA_FLAG_SATA test
* updated to the current upstream
* dependency to pci_configure_dma_masks() dropped

This patchset is against

 upstream(c602a03a610d0626599dbfb28e073c58699e5f94)
 + [1] libata-fix-native-mode-disabled-port-handling
 + [2] ahci-implement-ata_save-restore_initial_config
 + [3] ahci-move-port_map-handling-to-ahci_save_initial_config

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/16810
[1] http://article.gmane.org/gmane.linux.ide/16804
[2] http://article.gmane.org/gmane.linux.ide/17302
[3] http://article.gmane.org/gmane.linux.ide/17303


