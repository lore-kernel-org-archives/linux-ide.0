From: Raz <raziebe@gmail.com>
Subject: ata error codes
Date: Tue, 15 Jan 2008 19:39:53 +0200
Message-ID: <5d96567b0801150939y3802a73aqcbab553af5fe6015@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:42680 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbYAORjy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jan 2008 12:39:54 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4449886wah.23
        for <linux-ide@vger.kernel.org>; Tue, 15 Jan 2008 09:39:54 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>

Mr Garzik Hello
ata errors are some times cryptic. I am refering to this line, in the
ata_qc_timeout which holds lots of information.
printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 0x%x\n",
 ap->id,
 qc->tf.command,
 drv_stat,
 host_stat)

These errors varries , and many times SMART cannot help. Is there a
repository for these error codes, (  ata_dump_status isn't enough ).
Is there an API to get these error codes translated to human readable format ?
thank you
-- 
Raz
