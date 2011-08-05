From: Kushal Koolwal <kushalkoolwal@gmail.com>
Subject: Re: PATA RDC IDE driver READ DMA error messages
Date: Fri, 5 Aug 2011 11:58:16 -0700
Message-ID: <CA+9rrTpiJ_CeNfbe8hjg68sqQjrb=aFTwNYiJ6pws9pf76+H8Q@mail.gmail.com>
References: <CA+9rrTrmfunATZx4x2Abg8ofpwZFuyEeQFfa4OY0jbeEGWAyhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:42710 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658Ab1HES6R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Aug 2011 14:58:17 -0400
Received: by yie30 with SMTP id 30so28642yie.19
        for <linux-ide@vger.kernel.org>; Fri, 05 Aug 2011 11:58:16 -0700 (PDT)
In-Reply-To: <CA+9rrTrmfunATZx4x2Abg8ofpwZFuyEeQFfa4OY0jbeEGWAyhA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> Whenever a Compact Flash is present on the IDE controller, I get the following ATA error
> handling messages before the IDE Linux kernel driver (pata_rdc.ko)
> finally settles down (after almost a minute or so) to PIO4 speed for the Compact Flash:
I am guessing this may be due to the fact that the pata_rdc driver
does not handle all the cases (cable types and DMA modes) unlike the
Intel piix driver.
