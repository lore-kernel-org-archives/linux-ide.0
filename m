From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2.6.21-rc2] pmac ide: fix pmac_ide_dma_host_on() declaration
Date: Sat, 03 Mar 2007 20:28:47 +0300
Message-ID: <45E9B04F.2080601@ru.mvista.com>
References: <200703031324.l23DOVjO003638@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:45868 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030687AbXCCR25 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Mar 2007 12:28:57 -0500
In-Reply-To: <200703031324.l23DOVjO003638@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: benh@kernel.crashing.org, bzolnier@gmail.com, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

Hello.

Mikael Pettersson wrote:
> Building 2.6.21-rc2 on a PowerMac, I get:
> 
> drivers/ide/ppc/pmac.c: In function 'pmac_ide_setup_dma':
> drivers/ide/ppc/pmac.c:2042: warning: assignment from incompatible pointer type
> drivers/ide/ppc/pmac.c: In function 'pmac_ide_dma_host_on':
> drivers/ide/ppc/pmac.c:1988: warning: control reaches end of non-void function

    This fix is already in the pata-2.6 and -mm trees and has just been pushed 
to Linus:

http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/patches/ide-fix-pmac-breakage.patch

MBR, Sergei
