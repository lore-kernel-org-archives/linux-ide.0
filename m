From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/9] ide: move ack_intr() method into 'struct ide_port_ops'
Date: Fri, 12 Jun 2009 18:19:00 +0200
Message-ID: <200906121819.00690.bzolnier@gmail.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200906102251.16359.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f216.google.com ([209.85.220.216]:54608 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759630AbZFLQRS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jun 2009 12:17:18 -0400
Received: by fxm12 with SMTP id 12so735576fxm.37
        for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2009 09:17:20 -0700 (PDT)
In-Reply-To: <200906102251.16359.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 10 June 2009 20:51:16 Sergei Shtylyov wrote:
> Move the ack_intr() method into 'struct ide_port_ops', also renaming it to
> test_irq() while at it...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> The patch is atop of ide-2.6.git 'for-next' branch.
> 
>  drivers/ide/buddha.c |   27 ++++++++++++++++-----------
>  drivers/ide/gayle.c  |   14 +++++++++-----
>  drivers/ide/ide-io.c |    3 ++-
>  drivers/ide/macide.c |   12 ++++--------
>  include/linux/ide.h  |   10 +---------
>  5 files changed, 32 insertions(+), 34 deletions(-)

Seems to be missing changes to ide-probe.c (!), falconide.c and q40ide.c.
