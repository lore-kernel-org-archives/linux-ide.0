From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ahci: imx: PLL clock needs 100us to settle down
Date: Mon, 26 May 2014 14:09:31 -0300
Message-ID: <CAOMZO5DnSVgn+Y_i6b-cSgThh8xmG60Hd70-YrR7ELRNGJ1piQ@mail.gmail.com>
References: <1400330761-2432-1-git-send-email-shawn.guo@freescale.com>
	<CAOMZO5AUFkRY2VJYdTNQvs=vTagFQBaYBynpBRj5e_DsD2EXqQ@mail.gmail.com>
	<20140525064043.GC2650@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:36456 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbaEZRJc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 May 2014 13:09:32 -0400
Received: by mail-vc0-f173.google.com with SMTP id il7so9511559vcb.32
        for <linux-ide@vger.kernel.org>; Mon, 26 May 2014 10:09:31 -0700 (PDT)
In-Reply-To: <20140525064043.GC2650@dragon>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sun, May 25, 2014 at 3:40 AM, Shawn Guo <shawn.guo@freescale.com> wrote:

> Hmm, I haven't seen this?  How do I reproduce it on imx6q?

Run linux-next on a mx6qsabresd with no SATA disk connected and then:

$ echo enabled > /sys/class/tty/ttymxc0/power/wakeup
$ echo mem > /sys/power/state

Hit any key in console and then you will get the warning from ahci_imx suspend.
