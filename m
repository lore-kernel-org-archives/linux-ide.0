From: =?iso-8859-2?B?SmFrdWIgVy4gSvO8d2lja2k=?= <jozwicki@aster.pl>
Subject: ahci_softreset implementation
Date: Thu, 04 Oct 2007 20:39:52 +0200
Message-ID: <op.tzorgqkomy2jnb@celina>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2.aster.pl ([212.76.33.47]:38895 "EHLO mail2.aster.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754300AbXJDTOU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 15:14:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org


Hello,
Recently I have bought mainboard with AMD/ATI 690 + SB600.
2 Seagate 250GB SATA drives are connected. They work with Linux with
AHCI without any problem, I have RAID1 on them.
I've been trying to install Solaris on them, however when 2 drives
are connected one is not visible to OS.
Could you look at Solaris code and tell if I should fill them a bug-report?

http://cvs.opensolaris.org/source/xref/onnv/onnv-gate/usr/src/uts/common/io/sata/adapters/ahci/ahci.c

ahci_port_reset:

/* PxTFD.STS.BSY is supposed to be set */
    2900 	port_task_file = ddi_get32(ahci_ctlp->ahcictl_ahci_acc_handle,
    2901 	    (uint32_t *)AHCI_PORT_PxTFD(ahci_ctlp, port));
    2902 	if (!(port_task_file & AHCI_TFD_STS_BSY)) {
-> 2903 		cmn_err(CE_WARN, "ahci_port_reset: port %d BSY bit "
    2904 		    "is not set after COMINIT signal is received", port);
    2905 		ahci_portp->ahciport_port_state |= SATA_PSTATE_FAILED;
-> 2906 		rval = AHCI_FAILURE;
    2907 		goto out;
    2908 	}

Linux ahci.c::ahci_softreset also has this check, but works.

Regards,
Jakub

-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/
