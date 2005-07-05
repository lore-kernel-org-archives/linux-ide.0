From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [git patches] IDE update
Date: Mon, 04 Jul 2005 22:47:21 -0400
Message-ID: <42C9F4B9.7000805@pobox.com>
References: <Pine.GSO.4.62.0507031847460.678@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:10381 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261755AbVGECr1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jul 2005 22:47:27 -0400
In-Reply-To: <Pine.GSO.4.62.0507031847460.678@mion.elka.pw.edu.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Linus Torvalds <torvalds@osdl.org>

Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> Please pull from:
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/bart/ide-2.6.git
> 
> diffstat+changelog below
> 
> Bartlomiej
> 
> 
>  drivers/ide/Makefile        |    1 -
>  drivers/ide/ide-lib.c       |   13 +++++--------
>  drivers/ide/pci/alim15x3.c  |   10 +++++-----
>  drivers/ide/pci/amd74xx.c   |    7 +++++--
>  drivers/ide/pci/cs5530.c    |    4 ++--
>  drivers/ide/pci/cy82c693.c  |    8 ++++----
>  drivers/ide/pci/it8172.c    |    4 ++--
>  drivers/ide/pci/ns87415.c   |    2 +-
>  drivers/ide/pci/opti621.c   |    2 +-
>  drivers/ide/pci/sc1200.c    |    2 +-
>  drivers/ide/pci/sl82c105.c  |    6 +++---
>  drivers/ide/pci/slc90e66.c  |    2 +-
>  drivers/ide/pci/triflex.c   |    2 +-
>  drivers/ide/pci/via82cxxx.c |    4 ++--
>  include/linux/pci_ids.h     |    1 +
>  15 files changed, 34 insertions(+), 34 deletions(-)

FWIW, we should encourage the janitors to submit patches larger than 
simply one patch per file.  Spreading the -same- logical change across 
multiple patches is really taking the "split it up" mantra too far.

We want logical changes separated...  but this just spams the log IMO.

All of the __devinit changes could have been rolled into a single patch, 
since its going to a single maintainer (Bart).

	Jeff



