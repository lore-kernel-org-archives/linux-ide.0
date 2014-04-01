From: Biji John <bjohn@tilera.com>
Subject: SATA link issue with Marvell 9170
Date: Tue, 1 Apr 2014 21:17:35 +0000
Message-ID: <26AEAD365CFA784DA33319947CEB5DF86201255F@USCAEXCH1.tad.internal.tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uscamail.tilera.com ([12.218.212.166]:33560 "EHLO
	USCAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbaDAVXE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Apr 2014 17:23:04 -0400
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "tj@kernel.org" <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun,

I'm running into an intermittent issue while trying to run one of our boards. It has the Marvell 9170 SATA controller connected to one of our PCIe buses. On the other side is an MSATA device. I'm running kernel 3.4.76. Intermittently, the link will not come up, it looks like the driver tries to bring the link up at 3Gbps, and then eventually fails, and the kernel will hang waiting for the root device. From doing a Google search, I noticed that this version of the ahci driver does not have the entries for 9170 (and 9178) in ahci_pci_tbl. Is this expected behavior? After adding the following patch, I'm seeing improvement, and am wondering how the patch might be helping in this regard.

        { PCI_DEVICE(0x1b4b, 0x9170),
          .driver_data = board_ahci_yes_fbs },                  /* 88se9170 */

Thanks in advance for your help.

-Biji


