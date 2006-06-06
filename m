From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH 0/6] AHCI suspend/resume support -- take 2
Date: Tue, 06 Jun 2006 18:15:26 +0800
Message-ID: <1149588926.29552.53.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5247 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750774AbWFFKc7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jun 2006 06:32:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hare@suse.de, axboe@suse.de, htejun@gmail.com, jeremy@goop.org, lkml@rtr.ca
Cc: linux-ide@vger.kernel.org

Hello, all

This is the take 2 of AHCI suspend/resume patches.

This series of patches provide the support for AHCI suspend/resume.
The patch works very well on Napa SDV in our lab.

The patch is against libata-dev #upstream
[ef2824073fba9def3cf122e89cc485f66dd71f70].

Compared with last version, the changes are:
1 Use ata_wait_register() to replace the code of waiting register bit to
change
2 Replace mdelay(500) with at most waiting 1 second in ahci_start_fis_rx
()
3 Remove code for cold_presence_detection in ahci_port_spinup()
4 In ahci_port_standby(), refine the code and comments to make the logic
correct
5 Remove the field 'dev_map' of struct ahci_host_priv{} and move the
host interrupt enabling code into ahci_pci_device_resume()

Your comments and bug report are welcome.

Thanks,
Forrest
