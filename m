From: Chuck Ebbert <cebbert@redhat.com>
Subject: Another SATA device with spurious NCQ completions
Date: Mon, 25 Jun 2007 14:34:59 -0400
Message-ID: <46800AD3.7050803@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:39051 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbXFYSfQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Jun 2007 14:35:16 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l5PIYxI0007642
	for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 14:34:59 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l5PIYxsP010891
	for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 14:34:59 -0400
Received: from [172.16.83.145] (dhcp83-145.boston.redhat.com [172.16.83.145])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id l5PIYxKS011695
	for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 14:34:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

From:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=245512


The following error consistently appears at apparently random intervals in syslog:

kernel: ata1.00: exception Emask 0x2 SAct 0x1001 SErr 0x0 action 0x2 frozen
kernel: ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x1001
FIS=004040a1:00000800)
kernel: ata1.00: cmd 61/08:00:39:2b:cc/00:00:08:00:00/40 tag 0 cdb 0x0 data 4096 out
kernel:          res 40/00:00:39:2b:cc/00:00:08:00:00/40 Emask 0x2 (HSM violation)
kernel: ata1.00: cmd 61/08:60:e1:2b:cc/00:00:08:00:00/40 tag 12 cdb 0x0 data
4096 out
kernel:          res 40/00:00:39:2b:cc/00:00:08:00:00/40 Emask 0x2 (HSM violation)

Controller is ATI SB600 using the AHCI driver.
64-bit DMA is disabled.
Disk is:
ata1.00: ATA-7: ST3160812AS, 3.ADJ, max UDMA/133


Can't we just turn off NCQ automatically when this happens?
