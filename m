From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: sata_sil on amd64
Date: Sun, 23 Jan 2005 17:29:50 +0100
Message-ID: <58cb370e050123082935e29d4f@mail.gmail.com>
References: <200501221919.35710.tsm@accesscomm.ca>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:9111 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261324AbVAWQ3y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Jan 2005 11:29:54 -0500
Received: by wproxy.gmail.com with SMTP id 67so56330wri
        for <linux-ide@vger.kernel.org>; Sun, 23 Jan 2005 08:29:50 -0800 (PST)
In-Reply-To: <200501221919.35710.tsm@accesscomm.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tyler Montbriand <tsm@accesscomm.ca>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Sat, 22 Jan 2005 19:19:35 -0600, Tyler Montbriand <tsm@accesscomm.ca> wrote:
> I have been stuck using kernel 2.6.4 for the last year or so for various
> reasons, and now I'm in a vicious catch-22.  If I don't upgrade, I can't use
> NPTL, therefore my system will continue to be susceptible to the
> sigqueue-overflow flaw in linuxthreads.  But if I do upgrade, problems in
> >0.53 sata_sil implementations halt my system in a matter of minutes with
> dmesg entries about imaginary bad blocks.
> 
> 0.53 probably has it's own flaws, but it's been rock-solid running a single
> drive on my computer for a year.  How feasible would it be to forward-port
> this version to a newer kernel, say 2.6.10?  If I fix the header problems
> could it work, or is .10 too structurally different from .4?

Alternatively if you pinpoint the kernel snapshot which introduces this behavior
(-bk patches are available at kernel.org) we may be able to fix sata_sil.

Bartlomiej
