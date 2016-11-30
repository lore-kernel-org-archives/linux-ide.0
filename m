From: tedheadster <tedheadster@gmail.com>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device probes
 on non-PCI systems
Date: Wed, 30 Nov 2016 12:13:52 -0500
Message-ID: <CAP8WD_YvnjPiRxCR26ntw6HUFwwc3g+butJR_8eDTNCnaUzf6g@mail.gmail.com>
References: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
 <CGME20161129204609epcas1p1cad95d01c97dd23df8006389419628e4@epcas1p1.samsung.com>
 <20161129204602.GD4959@htj.duckdns.org> <2368047.lDgGYdnaMc@amdc3058>
Reply-To: whiteheadm@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f176.google.com ([209.85.213.176]:32805 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758396AbcK3RON (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 30 Nov 2016 12:14:13 -0500
Received: by mail-yb0-f176.google.com with SMTP id v132so18806629yba.0
        for <linux-ide@vger.kernel.org>; Wed, 30 Nov 2016 09:14:13 -0800 (PST)
In-Reply-To: <2368047.lDgGYdnaMc@amdc3058>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Bartlomiej,

> I would also prefer to have such systems detected automatically
> (i.e. by using DMI, please check dmidecode output on this board).
> If this is not possible I'm fine with the change, though I have some
> review comments to the patch itself (please see the other mail).
>

I will try dmidecode when I return from travel on Friday. I predict it
will have nothing, but I will verify. Assuming that turns out to be
correct, I'm posting my revised patch next.

- Matthew
