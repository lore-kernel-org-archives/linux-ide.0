From: Chuck Ebbert <cebbert@redhat.com>
Subject: Loading both the pata_atiixp and the ahci driver causes problems
Date: Thu, 15 Mar 2007 18:08:53 -0400
Message-ID: <45F9C3F5.4070906@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:36824 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753396AbXCOWI4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Mar 2007 18:08:56 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

If you try to load both the pata_atiixp and the ahci driver
(for the same ATI SB600 adapter), very strange things happen.
The AHCI driver churns for three minutes or so, spewing
messages like this, then nothing works:

<6>ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<4>ata3.00: qc timeout (cmd 0xec)
<4>ata3.00: failed to IDENTIFY (I/O error, err_mask=0x104)

Shouldn't it be able to tell the device has already been
claimed by some other driver?

(This is kernel 2.6.21-rc, and it's almost certainly happening
in 2.6.20 as well.)
