From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] MAINTAINERS: update IDE entry
Date: Fri, 24 Apr 2009 12:08:48 +0400
Message-ID: <49F17390.7070003@ru.mvista.com>
References: <200904232248.31735.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:35485 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753533AbZDXII4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Apr 2009 04:08:56 -0400
In-Reply-To: <200904232248.31735.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> By a popular demand quilt tree was replaced by a git one.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  MAINTAINERS |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: b/MAINTAINERS
> ===================================================================
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2743,7 +2743,7 @@ IDE SUBSYSTEM
>  P:	Bartlomiej Zolnierkiewicz
>  M:	bzolnier@gmail.com
>  L:	linux-ide@vger.kernel.org
> -T:	quilt kernel.org/pub/linux/kernel/people/bart/pata-2.6/
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bart/ide-2.6.git
>   

  Does that mean that the patches that have been already accepeted into 
the git tree, can't be updated afterwards (i.e. I have a habit of 
sometimes sending several takes of the same patch)?

WBR, Sergei


