From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/19] ide: update MAINTAINERS entry
Date: Fri, 19 Jan 2007 18:46:31 +0300
Message-ID: <45B0E7D7.3020608@ru.mvista.com>
References: <20070112041720.28755.49663.sendpatchset@localhost.localdomain> <20070112041726.28755.11371.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:17491 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932477AbXASPqd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Jan 2007 10:46:33 -0500
In-Reply-To: <20070112041726.28755.11371.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Hello.

Bartlomiej Zolnierkiewicz wrote:
> [PATCH] ide: update MAINTAINERS entry

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  MAINTAINERS |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

> Index: my-2.6/MAINTAINERS
> ===================================================================
> --- my-2.6.orig/MAINTAINERS
> +++ my-2.6/MAINTAINERS
> @@ -1585,12 +1585,11 @@ M:	ipslinux@adaptec.com
>  W:	http://www.developer.ibm.com/welcome/netfinity/serveraid.html
>  S:	Supported 
>  
> -IDE DRIVER [GENERAL]
> +IDE SUBSYSTEM
>  P:	Bartlomiej Zolnierkiewicz
> -M:	B.Zolnierkiewicz@elka.pw.edu.pl
> -L:	linux-kernel@vger.kernel.org
> +M:	bzolnier@gmail.com
>  L:	linux-ide@vger.kernel.org
> -T:	git kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git
> +T:	quilt kernel.org/pub/linux/kernel/people/bart/pata-2.6/
>  S:	Maintained

    BTW, if I'm (or somebody else) sending patches with IDE driver *fixes*, 
should these be against that quilt tree (containing largely reworked IDE 
code), against fresh Linus' tree (or some recent -rc), or against recent -mm tree?

WBR, Sergei
