From: Aaron Lu <aaron.lu@intel.com>
Subject: STANDBY IMMEDIATE failed on NVIDIA MCP5x controllers when system
 suspend
Date: Mon, 11 Mar 2013 11:42:54 +0800
Message-ID: <513D52BE.7040307@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64214 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753546Ab3CKDls (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 10 Mar 2013 23:41:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bladud@gmail.com, Joe Sapp <nixphoeni+kernel@gmail.com>, Alberto Mattea <support.intranet@libero.it>, Peter Dons Tychsen <donpedro@tdcadsl.dk>, Robert Hancock <hancockrwd@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hi all,

I've seen some reports on STANDBY IMMEDIATE failed on NVIDIA MCP5x
controllers when system goes to suspend(this command is sent by scsi sd
driver on system suspend as a SCSI STOP command, which is translated to
STANDBY IMMEDIATE ATA command). I've no idea of why this happened, so
I wrote this email in hope of getting some new idea.

The related bug report:
https://bugzilla.kernel.org/show_bug.cgi?id=48951

And google search showed that Peter reported a similar problem here:
http://marc.info/?l=linux-ide&m=133534061316338&w=2

And bladud has found that, disable asyn suspend for the scsi target
device can work around this problem.

Please feel free to suggest what can possibly be the cause, thanks.

-Aaron

