From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [PATCH] PA-RISC update to 87415
Date: Fri, 5 Nov 2004 23:28:13 -0700
Message-ID: <20041106062813.GA13851@colo.lackof.org>
References: <20041103200059.GC17672@colo.lackof.org> <58cb370e04110312215ee851e4@mail.gmail.com> <20041103213351.GB23415@colo.lackof.org> <58cb370e041103140121017ea1@mail.gmail.com> <20041103232356.GD23415@colo.lackof.org> <58cb370e04110512175fc2ded9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:18659 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261317AbUKFG2P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Nov 2004 01:28:15 -0500
Content-Disposition: inline
In-Reply-To: <58cb370e04110512175fc2ded9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: matthew@wil.cx, linux-ide@vger.kernel.org

On Fri, Nov 05, 2004 at 09:17:03PM +0100, Bartlomiej Zolnierkiewicz wrote:
> applied

Thanks!

> I had to cover init_iops_ns87415 by CONFIG_SUPERIO to fix:
> 
> drivers/ide/pci/ns87415.c:95: warning: `superio_ide_init_iops' defined
> but not used
> 
> I also marked init_iops_ns87415 with __devinit

oh - sorry. I only tested with CONFIG_SUPERIO enabled
since that's the platform I'm focused on requires.
Thanks for cleaning up instead of bouncing it.

grant
