From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 1/2] drivers: ide: Include appropriate header file in
 ide-cd_verbose.c
Date: Tue, 17 Dec 2013 08:37:03 -0800
Message-ID: <20131217163703.GB1062@leaf>
References: <d24d7befadfbfb9501d0e873f13e39fd42ec893b.1387278225.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48219 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063Ab3LQQhL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Dec 2013 11:37:11 -0500
Content-Disposition: inline
In-Reply-To: <d24d7befadfbfb9501d0e873f13e39fd42ec893b.1387278225.git.rashika.kheria@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rashika Kheria <rashika.kheria@gmail.com>
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

On Tue, Dec 17, 2013 at 04:38:16PM +0530, Rashika Kheria wrote:
> Include appropriate header file ide-cd.h in ide-cd_verbose.c because
> function ide_cd_log_error() has its prototype declaration in ide-cd.h=
=2E
> Also, include linux/ide.h because it contains certain declarations
> necessary for including ide-cd.h.
>=20
> This eliminates the following warnings in ide-cd_verbose.c:
> drivers/ide/ide-cd_verbose.c:251:6: warning: no previous prototype fo=
r =E2=80=98ide_cd_log_error=E2=80=99 [-Wmissing-prototypes]
>=20
> Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

>  drivers/ide/ide-cd_verbose.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/ide/ide-cd_verbose.c b/drivers/ide/ide-cd_verbos=
e.c
> index 6490a2d..f079ca2 100644
> --- a/drivers/ide/ide-cd_verbose.c
> +++ b/drivers/ide/ide-cd_verbose.c
> @@ -9,7 +9,9 @@
>  #include <linux/kernel.h>
>  #include <linux/blkdev.h>
>  #include <linux/cdrom.h>
> +#include <linux/ide.h>
>  #include <scsi/scsi.h>
> +#include "ide-cd.h"
> =20
>  #ifndef CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS
>  void ide_cd_log_error(const char *name, struct request *failed_comma=
nd,
> --=20
> 1.7.9.5
>=20
