From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata total system lockup fix
Date: Mon, 25 Jul 2005 10:51:33 -0400
Message-ID: <42E4FC75.70006@pobox.com>
References: <42E4ED70.1050501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:43444 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261308AbVGYOvg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jul 2005 10:51:36 -0400
In-Reply-To: <42E4ED70.1050501@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Jeff,
> 
> We corresponded about this bugfix ages ago,
> but I find I'm still patching it into each new
> kernel.org kernel to keep my system from locking
> up hard in the libata error handling path.
> 
> (error handling is triggered by the KDE/Gnome desktop
> polling the empty ATAPI drive every second or two,
> gets an error when no disc inserted, thereby triggering
> SCSI/libata error paths, which lock system hard once
> in a few thousand tries -- about once every two hours).
> 
> This patch originally came to me from you, and I've now
> forgotten where you got it from.  But it does fix the
> problem here.  I have also circulated this patch among
> many other users of "ata_piix" on modern laptops,
> and it seems to cure random lockups for them as well.
> 
> This configuration (2.6 kernel, ata_piix driving hard disk
> and DVD-RW drive in a Centrino laptop) is now very very
> commonplace, and the lockups are driving users crazy.
> 
> Sure would be nice to see it in 2.6.13 or 2.6.14 by default.

The problem with this patch is that is causes leaks, and doesn't 
actually ready the devices because scsi_eh_ready_devs() is never called: 
scsi_eh_abort_cmds() is guaranteed to fail out every time its called.

So it just trades one set of failures for another.  I don't dispute that 
lockups SUCK but someone (me? noone else is stepping up) needs to look 
into fixing it.

When I finish up SATA ATAPI today, I'll put this on the short list.

	Jeff



