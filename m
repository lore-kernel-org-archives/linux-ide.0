From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: allow ide-generic users to ask it to capture unknown
	devices
Date: Fri, 05 Nov 2004 23:27:56 +0000
Message-ID: <1099697274.5567.76.camel@localhost.localdomain>
References: <1099671737.5556.32.camel@localhost.localdomain>
	 <200411052256.27303.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:34245 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261282AbUKFAas (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 19:30:48 -0500
In-Reply-To: <200411052256.27303.bzolnier@elka.pw.edu.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Gwe, 2004-11-05 at 21:56, Bartlomiej Zolnierkiewicz wrote:
> Why can't generic entry be just added at id 14 in generic_chipsets table?

Because when someone adds an entry they'll break the driver.

> What is the exact purpose of this patch?
> 
> AFAICS this option allows users to use generic code for unknown/unsupported
> devices which can result in unpredictable results (hangs, data corruptions).

Correct but they must force it on by hand. It generates a printk to tell
the user and so its obvious in any bug reports..


