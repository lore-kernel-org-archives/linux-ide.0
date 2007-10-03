From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 01/10] pata_acpi: restore driver
Date: Wed, 03 Oct 2007 16:29:58 -0400
Message-ID: <4703FBC6.80104@garzik.org>
References: <200710022052.l92Kqx0w021673@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34204 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758440AbXJCUaB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2007 16:30:01 -0400
In-Reply-To: <200710022052.l92Kqx0w021673@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org, Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com

akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@redhat.com>
> 
> This patch assumes the mode filter patches were applied, if not then ping
> me and I'll send the trivially different patch (extra argument to
> mode_filter)
> 
> Don't assume the BIOS can validate modes or has any sense at all.  Instead use
> the BIOS timings to deduce the modes.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> Cc: Tejun Heo <htejun@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/Kconfig     |    9 
>  drivers/ata/Makefile    |    2 
>  drivers/ata/pata_acpi.c |  403 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 414 insertions(+)

Can I get a better email subject and patch description please?

Just reply to this email, and I can hand-edit the patch from there.

"pata_acpi: restore driver" is a bad one-line summary, because nothing 
was lost (hence nothing to be restored).  it's simply a new driver.

The patch description is also wanting -- it describes work-in-progress, 
but should really be a summary of what the pata_acpi driver is, why we 
want it, and how it works.

Email some text, and I shall apply straightaway.

	Jeff



