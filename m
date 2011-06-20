From: Manuel Zerpies <manuel.f.zerpies@ww.stud.uni-erlangen.de>
Subject: Re: [PATCH 01/11] drivers/ide: use printk_ratelimited() instead of printk_ratelimit()
Date: Mon, 20 Jun 2011 10:17:53 +0200
Message-ID: <BANLkTim=yg+tCxa-JhMYw5zsnBSzQqVnqg@mail.gmail.com>
References: <cover.1308142053.git.manuel.f.zerpies@ww.stud.uni-erlangen.de>
	<0a1488254bd51475a90133c0fc41a4d34b533ef4.1308142053.git.manuel.f.zerpies@ww.stud.uni-erlangen.de>
	<20110616141930.GA12872@eferding.osrc.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:52915 "EHLO
	mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750844Ab1FTIXA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Jun 2011 04:23:00 -0400
In-Reply-To: <20110616141930.GA12872@eferding.osrc.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Manuel Zerpies <manuel.f.zerpies@ww.stud.uni-erlangen.de>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel

Hello,
2011/6/16 Borislav Petkov <bp@alien8.de>
>
> On Thu, Jun 16, 2011 at 02:06:37PM +0200, Manuel Zerpies wrote:
>
> Does the printk fit on one line if you do
>
> =A0 =A0 =A0 =A0pr_warn_ratelimited(...)
>
> instead?
>
> Thanks.
>
> --
> Regards/Gruss,
> Boris.

No I'm affraid. I tried it, but it didn't fit the 80 chars per line
code-styling.

>Why not pr_warn_ratelimited()?
>WBR, Sergei

I just kind of ignored it. As you see, I built it in.

Here my new patch:

Since printk_ratelimit() shouldn't be used anymore (see comment in
include/linux/printk.h), replace it with printk_ratelimited().
Signed-off-by: Manuel Zerpies <manuel.f.zerpies@ww.stud.uni-erlangen.de=
>
---
=A0drivers/ide/ide-atapi.c | =A0 =A06 +++---
=A01 files changed, 3 insertions(+), 3 deletions(-)
diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 6f218e01..c9e69d7 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -8,6 +8,7 @@
=A0#include <linux/ide.h>
=A0#include <linux/scatterlist.h>
=A0#include <linux/gfp.h>
+#include <linux/ratelimit.h>

=A0#include <scsi/scsi.h>

@@ -200,9 +201,8 @@ void ide_prep_sense(ide_drive_t *drive, struct requ=
est *rq)
=A0 err =3D blk_rq_map_kern(drive->queue, sense_rq, sense, sense_len,
=A0 =A0 =A0 =A0GFP_NOIO);
=A0 if (unlikely(err)) {
- if (printk_ratelimit())
- printk(KERN_WARNING PFX "%s: failed to map sense "
- =A0 =A0"buffer\n", drive->name);
+ pr_warn_ratelimited(PFX "%s: failed to map sense buffer\n",
+ =A0 =A0drive->name);
=A0 return;
=A0 }

--
1.7.4.1
