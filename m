From: Mark Lord <liml@rtr.ca>
Subject: ops->qc_defer not invoked on ata_exec_internal_sg() paths ?
Date: Mon, 25 Feb 2008 19:20:59 -0500
Message-ID: <47C35B6B.8000406@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4193 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760816AbYBZASN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Feb 2008 19:18:13 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

The optional .qc_defer() methods don't seem to be called
on the ata_exec_internal_sg() path.

At present, this is probably okay.  But in the future,
as we add functionality for link power management
and hotplug polling, this could be a problem.

I think.  Or is it possibly also a problem today
for sata_send_pmp() and friends ?

Tejun?
