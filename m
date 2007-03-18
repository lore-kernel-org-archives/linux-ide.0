From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] IDE fixes
Date: Sun, 18 Mar 2007 01:44:58 +0100
Message-ID: <200703180144.58509.bzolnier@gmail.com>
References: <200703172207.52352.bzolnier@gmail.com> <Pine.LNX.4.64.0703171702060.4964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:1509 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbXCRAhk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Mar 2007 20:37:40 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1007594uga
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 17:37:39 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0703171702060.4964@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On Sunday 18 March 2007, Linus Torvalds wrote:
> 
> On Sat, 17 Mar 2007, Bartlomiej Zolnierkiewicz wrote:
> > 
> > to receive the following updates:
> > 
> >  b/drivers/ide/Kconfig                       |   48 -
> >  b/drivers/ide/Makefile                      |    1 
> >  b/drivers/ide/arm/icside.c                  |   13 
> >  b/drivers/ide/ide-dma.c                     |    2 
> >  b/drivers/ide/ide.c                         |    4 
> >  b/drivers/ide/mips/au1xxx-ide.c             |    3 
> >  b/drivers/ide/pci/Makefile                  |    1 
> >  b/drivers/ide/pci/cmd64x.c                  |   45 -
> >  b/drivers/ide/pci/jmicron.c                 |   29 
> >  b/drivers/ide/pci/scc_pata.c                |  858 ++++++++++++++++++++++++++++
> >  b/drivers/ide/setup-pci.c                   |    5 
> >  b/include/asm-mips/mach-au1x00/au1xxx_ide.h |   34 -
> >  drivers/ide/ppc/scc_pata.c                  |  858 ----------------------------
> >  13 files changed, 915 insertions(+), 986 deletions(-)
> 
> Please use
> 
> 	git diff -M --stat --summary 
> 
> to generate the diffstat (where the "-M" is the important part). Your 
> "scc_pata.c" change was a pure rename, but because you didn't ask for 
> rename detection, it got shown as a file create/delete pair. It *should* 
> have looked like this:
> 
>  drivers/ide/Kconfig                       |   48 +++++------------------------
>  drivers/ide/Makefile                      |    1 -
>  drivers/ide/arm/icside.c                  |   13 +-------
>  drivers/ide/ide-dma.c                     |    2 +-
>  drivers/ide/ide.c                         |    4 --
>  drivers/ide/mips/au1xxx-ide.c             |    3 +-
>  drivers/ide/pci/Makefile                  |    1 +
>  drivers/ide/pci/cmd64x.c                  |   45 ++++++++++++---------------
>  drivers/ide/pci/jmicron.c                 |   29 ++++++++++++++---
>  drivers/ide/{ppc => pci}/scc_pata.c       |    0
>  drivers/ide/setup-pci.c                   |    5 ---
>  include/asm-mips/mach-au1x00/au1xxx_ide.h |   34 --------------------
>  12 files changed, 57 insertions(+), 128 deletions(-)
>  rename drivers/ide/{ppc => pci}/scc_pata.c (100%)
> 
> which is a lot more accurate than what you get by feeding a diff through 
> "diffstat" that has no clue about renames (look at the summary for number 
> of lines changed ;)

Thanks, I updated my scripts and also a git version installed while at it.

[ I was feeling that I was missing something but these options were
  undocumented in git-1.4.4.2, no longer a case in git-1.5.0.3. :-) ]

Bart
