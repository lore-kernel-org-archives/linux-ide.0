From: Benny Halevy <bhalevy@panasas.com>
Subject: Is sata_nv compatible with async scsi scan?
Date: Tue, 21 Apr 2009 10:03:51 +0300
Message-ID: <49ED6FD7.3070307@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:32329 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbZDUHD6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Apr 2009 03:03:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Hi Jeff,

Since 2.6.29 I'm having intermittent problems with booting kernels.
After supposedly waiting for scsi async scan to complete,
quite frequently I see errors from the init resume process
when it fails to find the swap partition and later the root
file system fails to load.

A workaround that I found to be helpful is booting the kernel
with scsi_mod.scan=sync so I suspect sata_nv has a problem
with asynchronous scanning.

The two machines this happens on have:
IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)

and

IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)

This one: IDE interface: nVidia Corporation MCP55 SATA Controller (rev a3)
seems to be less prone to the problem, though I tend to reboot it
much less frequently, so it's possible I just happened to be lucky with it.

Benny
