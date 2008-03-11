From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: clean up scsi_host_templates and ata_port_operations, take #3
Date: Tue, 11 Mar 2008 21:05:56 +0900
Message-ID: <12052371651181-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:45241 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757310AbYCKMGO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 08:06:14 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2814301wah.23
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 05:06:13 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@arm.linux.org.uk, alessandro.zummo@towertech


Hello, all.

This is the third take of cleanup-sht-ops patchset.  As the name
suggests it reorganizes and cleans up scsi_host_template and
ata_port_operation tables used by libata core and low level drivers.

Please read the head message of the first take[F] for more info.
Changes from the last take[L] are...

* Updated to fit the current upstream-fixes.

* pata_scc thaw change applied.

* pata_rb500_cf newly converted.

* Updated to accomodate drivers w/o any reset method available.

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
* pata_rb500_cf

This patchset is on top of

  upstream-fixes (3db691daa4f6c4b899e144ea54a65738402c94e3)
+ [1] prefer-hardreset patchset, take#3 (the subject line is wrong)
+ [2] devres-implement-pcim_iomap_regions_request_all
+ [3] ahci-request-all-PCI-BARs
+ [4] libata-PCI-device-should-be-powered-up-before-being-accessed

This patchset is available as GIT branch.

http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=cleanup-sht-ops
git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git cleanup-sht-ops

The verification method is the same as before[B].

Thanks.

--
tejun

[F] http://thread.gmane.org/gmane.linux.ide/27785
[L] http://thread.gmane.org/gmane.linux.ide/28335
[1] http://thread.gmane.org/gmane.linux.ide/29642
[2] http://article.gmane.org/gmane.linux.ide/29653
[3] http://article.gmane.org/gmane.linux.ide/29654
[4] http://article.gmane.org/gmane.linux.ide/29655
[B] http://article.gmane.org/gmane.linux.ide/28357
