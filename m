From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ahci: imx: manage only sata_ref_clk in imx_sata_enable[disable]
Date: Wed, 28 May 2014 13:48:54 -0300
Message-ID: <CAOMZO5Az_JR58a3cwGYK1_vcJ_twz4sEq+NHXv2SZ6yuN=wjGQ@mail.gmail.com>
References: <1401289539-3485-1-git-send-email-shawn.guo@freescale.com>
	<5386026C.1010603@redhat.com>
	<CAOMZO5BkdkU-_s8G5CqVMzfkMgxdUg8bx0JJnqC8dPyFMK=Ocw@mail.gmail.com>
	<538610D5.7070908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:43850 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbaE1Qsz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2014 12:48:55 -0400
Received: by mail-vc0-f171.google.com with SMTP id lc6so12656278vcb.16
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2014 09:48:54 -0700 (PDT)
In-Reply-To: <538610D5.7070908@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, Tejun Heo <tj@kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>, linux-ide@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Wed, May 28, 2014 at 1:37 PM, Hans de Goede <hdegoede@redhat.com> wrote:

> Ah yes I see, the ahci_imx suspend/resume handler now no longer
> touches the controller, but the ata core is still trying to use it.
>
> Ok, in that case I agree that your original patch is the best
> solution.
>
> Your original patch is:
>
> Acked-by: Hans de Goede <hdegoede@redhat.com>

I think you meant Shawn's patch, not mine :-)
