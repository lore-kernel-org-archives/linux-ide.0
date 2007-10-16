From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] IDE updates (part 2)
Date: Tue, 16 Oct 2007 21:41:01 +0200
Message-ID: <200710162141.02019.bzolnier@gmail.com>
References: <200710131825.24768.bzolnier@gmail.com> <200710141807.24295.bzolnier@gmail.com> <1192396500.6188.4.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:40084 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936033AbXJPUto (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Oct 2007 16:49:44 -0400
Received: by ug-out-1314.google.com with SMTP id z38so159272ugc
        for <linux-ide@vger.kernel.org>; Tue, 16 Oct 2007 13:49:43 -0700 (PDT)
In-Reply-To: <1192396500.6188.4.camel@pasglop>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 14 October 2007, Benjamin Herrenschmidt wrote:
> 
> > How's about this patch?
> > 
> > [PATCH] ide-pmac: fix pmac_ide_init_hwif_ports()
> > 
> > * pmac_ide_init_hwif_ports() can be called by ide_init_hwif_ports()
> >   (through ppc_ide_md.ide_init_hwif hook) for non IDE PMAC interfaces.
> >   If this is the case the hw->io_ports[] should be already setup by
> >   ide_init_hwif_ports()->ide_std_init_ports() so remove redundant code
> >   from pmac_ide_init_hwif_ports().
> > 
> >   As side-effect this change fixes ctl_addr == 0 special handling in
> >   ide_init_hwif_ports().
> > 
> > * Fix misleading comment while at it.
> 
> I would have to try it. Problem is, I don't actually have any powermac
> with a PCI IDE controller at hand.. ouch. I'll see what I can find.

Same problem here, would be great if somebody with PMAC could test
this patch (should apply cleanly to Linus' tree).

Well, since the change is pretty safe I'm adding the patch to IDE tree
(so it hopefully gets tested through -mm).

Thanks,
Bart
