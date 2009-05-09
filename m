From: Tejun Heo <tj@kernel.org>
Subject: Re: How to assess PMP register
Date: Sat, 09 May 2009 14:18:20 +0900
Message-ID: <4A05121C.1040104@kernel.org>
References: <fa69d4570904291849p638b849fm856be97c81340624@mail.gmail.com>	 <49FA2763.9040409@rtr.ca>	 <fa69d4570905032204q726728a1qd4be4800b916439a@mail.gmail.com>	 <49FF7C2A.6030000@rtr.ca>	 <e7510f760905060003n60535405oaf8e431963b41ddf@mail.gmail.com> <fa69d4570905082212y74242302o5bd8059ce358a4be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38336 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975AbZEIFTo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 May 2009 01:19:44 -0400
In-Reply-To: <fa69d4570905082212y74242302o5bd8059ce358a4be@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: s ticket <smticket@gmail.com>
Cc: Gwendal Grignou <gwendal@google.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com, Mark Lord <liml@rtr.ca>

s ticket wrote:
> 2009/5/6 Gwendal Grignou <gwendal@google.com>:
>> - you can not access a PMP device from user space directly because
>> there is no file descriptor for it.
>> - however, libata stores a dump of PMP registers taken after every
>> reset in gscr structure of the ata_device structure that represent the
>> PMP in the kernel. You can modify libata to print the registers you
>> need.
> 
> I add a  `pmp_attach' function ata_port_operation, and call
> `sata_pmp_read' in that
> function. It works fine. But when I call `sata_pmp_read' in process
> context while another
> process is writing to disks, the kernel hangs (deadlock?). Is there
> any suggestion?
> I found that `sata_pmp_read' finally calls `ata_exec_internal_sg' to
> do the real work and
> 'ata_exec_internal_sg' takes ata_port->lock.
> 
> BTW, why `sata_pmp_read' and `sata_pmp_write' aren't exported?

The PMP access functions can only be called from EH context and that's
one of the reasons they aren't exported?  What are you trying to
achieve?

Thanks.

-- 
tejun
