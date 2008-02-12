From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET libata-dev#upstream] clean up scsi_host_templates and ata_port_operations, take #2
Date: Tue, 12 Feb 2008 17:43:11 +0900
Message-ID: <1202805801343-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:10453 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbYBLIne (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 03:43:34 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3595166rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 12 Feb 2008 00:43:33 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@arm.linux.org.uk, alessandro.zummo@towertech

Hello, all.

This is the second take of cleanup-sht-ops patchset.  As the name
suggests it reorganizes and cleans up scsi_host_template and
ata_port_operation tables used by libata core and low level drivers.

Please read the head message of the last take[L] for more info.
Changes from the last take[L] are...

* Updated to fit the current upstream.  sata_mv should be fine now.

* sht and ops conversions separated into two patches as Jeff
  requested.

* Instead of using init-register model for SFF drivers which need to
  initialize host->private_data, @host_priv is added to
  ata_pci_init_one() as Alan requested.

* pata_scc should now have NULL thaw after conversion.

The following drivers need specific platform to build, so they need
verification.  If you work on one of the following drivers, please
verify that the driver builds and works fine.  It would be best if you
can verify that the sht and ops don't change by the fifth and sixth
patches using the method I'll write in another message.

* pata_at32
* pata_bf54x
* pata_icside
* pata_ixp4xx_cf
* pata_mpc52xx
* pata_scc
* sata_fsl

This patchset is on top of

  upstream (bc5468f52b785ffa1fe0ea289baec2c51384d436)
+ prefer-hardreset patchset [1]
+ grace-failure-on-no-reset patch [2]
+ pci-allow-multiple-pcim_enable_device [3]

This patchset is available as GIT branch.

http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=cleanup-sht-ops
git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git cleanup-sht-ops

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/27785
[1] http://thread.gmane.org/gmane.linux.ide/27447
[2] http://article.gmane.org/gmane.linux.ide/27781
[3] http://article.gmane.org/gmane.linux.ide/27782
