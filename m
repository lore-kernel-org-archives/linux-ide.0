From: Tejun Heo <tj@kernel.org>
Subject: Re: Handling Asynchronous Notification when IO are outstanding
Date: Thu, 25 Mar 2010 08:48:35 +0900
Message-ID: <4BAAA4D3.9050103@kernel.org>
References: <e7510f761003081627o1134b77eud719e033f68488bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46635 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752177Ab0CYHNv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Mar 2010 03:13:51 -0400
In-Reply-To: <e7510f761003081627o1134b77eud719e033f68488bb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Gwendal.

On 03/09/2010 09:27 AM, Gwendal Grignou wrote:
> However, when we enter ata_scsi_error(), if a command is outstanding,
> __ata_port_freeze() is called, preventing  sata_scr_read() to succeed
> in ata_eh_link_autopsy():

Ah... that's an interesting problem.

> 1: removing __ata_port_freeze() in ata_scsi_error() unilaterally is
> very dangerous, it opens a new race condition and may schedule the
> error handler several time.
> 2: in sata_mv, we can not wait for commands to complete like we do for
> NCQ, because in the case above, the command sent to the failed disk
> will never come back.

I don't think there will be race conditions even if you remove
__ata_port_freeze() there.  Port freezing is mostly to protect the
host from malfunctioning controller which could often lead to IRQ
nobody cared issues in the early days.  For FIS based controllers, I
don't think removing it from there would be such a bad idea.

> I am thinking of waiting for all IO to complete on all port but the
> impacted one(s), adding a new action in ehi descriptor to indicate an
> AN is scheduled, and preventing the error to froze the port if only
> IOs to the failed ports are outstanding.
> Then _autopsy_ code would collect and decode SERROR register for the
> failed port.
> 
> Is it the right approach?

My reply is very late but can you please try removing
__ata_port_freeze() and see how it works?

Thanks.

-- 
tejun
