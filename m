From: Tejun Heo <tj@kernel.org>
Subject: result_tf handling in sata_fsl and sas_ata
Date: Thu, 14 Oct 2010 11:28:38 +0200
Message-ID: <4CB6CD46.90303@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49705 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753401Ab0JNJ25 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Oct 2010 05:28:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ashish Kalra <ashish.kalra@freescale.com>, "Darrick J. Wong" <djwong@us.ibm.com>, Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>Mark Lord <k>

Hello,

result_tf is used, among other things, to report the command
completion status for ATA passthrough commands.  Many controllers
emulate TF registers by updating them according to command progress
and received FISes allowing the respective drivers to simply read the
area; however, some native SATA controllers don't bother to emulate TF
registers and simply dump received FISes into predefined areas.

ahci was one of such controllers and the driver was reading the
receive area for D2H Reg FIS to acquire the result taskfile register.
Unfortunately, this is incorrect as successful ATA PIO data-in
commands don't use D2H Reg FIS to update result TF but the host is
supposed to update the Status part of TF from the E_Status field of
the preceding Setup PIO FIS.  This hack is to satisfy the timing
specified from PATA days.  Anyways, so, the qc_fill_rtf method needs
to consider the command protocol and success of the previous command
if the controller doesn't maintain TF registers itself.

I just submitted a patch to fix ahci.  sata_sil24, sata_fsl and
sas_ata seemed to have similar problems, but sata_sil24 properly
emulates TF regs in the PRB section in D2H Reg FIS layout, leaving
sata_fsl and sas_ata, about which I don't have much idea.  So, please
check and take care of them.

For further details, please read the following thread.

  http://thread.gmane.org/gmane.linux.ide/47627

Thanks.

-- 
tejun
