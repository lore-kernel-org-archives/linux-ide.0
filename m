From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 1/2] drivers: ata: Mark the function
 ahci_init_interrupts() as static in ahci.c
Date: Sat, 14 Dec 2013 12:47:13 -0800
Message-ID: <20131214204712.GM17601@leaf>
References: <81391ee13d565f1db31247dfda803cd7123bb8a9.1387029964.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51552 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862Ab3LNUrt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Dec 2013 15:47:49 -0500
Content-Disposition: inline
In-Reply-To: <81391ee13d565f1db31247dfda803cd7123bb8a9.1387029964.git.rashika.kheria@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rashika Kheria <rashika.kheria@gmail.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Sat, Dec 14, 2013 at 07:38:08PM +0530, Rashika Kheria wrote:
> This patch marks the function ahci_init_interrupts() as static in ahc=
i.c
> because it is not used outside this file.
>=20
> Thus, it also eliminates the following warning in ahci.c:
> drivers/ata/ahci.c:1099:5: warning: no previous prototype for =E2=80=98=
ahci_init_interrupts=E2=80=99 [-Wmissing-prototypes]
>=20
> Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

>  drivers/ata/ahci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 14f1e95..4ab1d41 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1097,7 +1097,7 @@ static inline void ahci_gtf_filter_workaround(s=
truct ata_host *host)
>  {}
>  #endif
> =20
> -int ahci_init_interrupts(struct pci_dev *pdev, struct ahci_host_priv=
 *hpriv)
> +static int ahci_init_interrupts(struct pci_dev *pdev, struct ahci_ho=
st_priv *hpriv)
>  {
>  	int rc;
>  	unsigned int maxvec;
> --=20
> 1.7.9.5
>=20
