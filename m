From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/2] drivers: ide: Include appropriate header file in
 ide-pio-blacklist.c
Date: Tue, 17 Dec 2013 08:37:51 -0800
Message-ID: <20131217163751.GC1062@leaf>
References: <d24d7befadfbfb9501d0e873f13e39fd42ec893b.1387278225.git.rashika.kheria@gmail.com>
 <2ec755ae03ae9f912f40a12a241f997909f380a1.1387278225.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:39452 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab3LQQh5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Dec 2013 11:37:57 -0500
Content-Disposition: inline
In-Reply-To: <2ec755ae03ae9f912f40a12a241f997909f380a1.1387278225.git.rashika.kheria@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rashika Kheria <rashika.kheria@gmail.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

On Tue, Dec 17, 2013 at 04:41:11PM +0530, Rashika Kheria wrote:
> Include appropriate header file include/linux/ide.h in file
> ide-pio-blacklist.c because function ide_scan_pio_blacklist() has it'=
s
> prototype declaration in include/linux/ide.h.
>=20
> This eliminates the following warning in ide-pio-blacklist.c:
> drivers/ide/ide-pio-blacklist.c:85:5: warning: no previous prototype =
for =E2=80=98ide_scan_pio_blacklist=E2=80=99 [-Wmissing-prototypes]
>=20
> Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

>  drivers/ide/ide-pio-blacklist.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/ide/ide-pio-blacklist.c b/drivers/ide/ide-pio-bl=
acklist.c
> index a8c2c8f8..40e683a 100644
> --- a/drivers/ide/ide-pio-blacklist.c
> +++ b/drivers/ide/ide-pio-blacklist.c
> @@ -7,6 +7,7 @@
>   */
> =20
>  #include <linux/string.h>
> +#include <linux/ide.h>
> =20
>  static struct ide_pio_info {
>  	const char	*name;
> --=20
> 1.7.9.5
>=20
