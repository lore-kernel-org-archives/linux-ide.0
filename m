From: s ticket <smticket@gmail.com>
Subject: Re: How to assess PMP register
Date: Sat, 9 May 2009 13:12:41 +0800
Message-ID: <fa69d4570905082212y74242302o5bd8059ce358a4be@mail.gmail.com>
References: <fa69d4570904291849p638b849fm856be97c81340624@mail.gmail.com>
	 <49FA2763.9040409@rtr.ca>
	 <fa69d4570905032204q726728a1qd4be4800b916439a@mail.gmail.com>
	 <49FF7C2A.6030000@rtr.ca>
	 <e7510f760905060003n60535405oaf8e431963b41ddf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:28145 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbZEIFMl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 May 2009 01:12:41 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1083183ywb.1
        for <linux-ide@vger.kernel.org>; Fri, 08 May 2009 22:12:41 -0700 (PDT)
In-Reply-To: <e7510f760905060003n60535405oaf8e431963b41ddf@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, Mark Lord <liml@rtr.ca>

2009/5/6 Gwendal Grignou <gwendal@google.com>:
> - you can not access a PMP device from user space directly because
> there is no file descriptor for it.
> - however, libata stores a dump of PMP registers taken after every
> reset in gscr structure of the ata_device structure that represent the
> PMP in the kernel. You can modify libata to print the registers you
> need.

I add a  `pmp_attach' function ata_port_operation, and call
`sata_pmp_read' in that
function. It works fine. But when I call `sata_pmp_read' in process
context while another
process is writing to disks, the kernel hangs (deadlock?). Is there
any suggestion?
I found that `sata_pmp_read' finally calls `ata_exec_internal_sg' to
do the real work and
'ata_exec_internal_sg' takes ata_port->lock.

BTW, why `sata_pmp_read' and `sata_pmp_write' aren't exported?


                                                jbin
