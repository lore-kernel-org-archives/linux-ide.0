From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] IDE: Silent compiler warning in ide_pio_bytes()
Date: Mon, 22 Jun 2009 16:10:59 -0700 (PDT)
Message-ID: <20090622.161059.69648151.davem@davemloft.net>
References: <20090622211052.45b3cfc5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:57429
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751010AbZFVXKz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jun 2009 19:10:55 -0400
In-Reply-To: <20090622211052.45b3cfc5@hyperion.delvare>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: khali@linux-fr.org
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 22 Jun 2009 21:10:52 +0200

> PageHighMem() isn't cheap so avoid calling it several times on the
> same page. I had the hope that this would silent the following
> compilation warning:
> 
> drivers/ide/ide-taskfile.c: In function 'ide_pio_bytes':
> drivers/ide/ide-taskfile.c:229: warning: 'flags' may be used uninitialized in this function
> 
> which is a false positive, but it did not. So let's just initialize the
> flags and be done with it, so that other developers don't waste their
> time looking at it.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Like Borislav, I think it's better to use uninitialized_var().
It describes the situation completely.

Please submit an updated patch, and thank you for this.
