From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH] ahci, msix: Fix build error for !PCI_MSI
Date: Wed, 17 Jun 2015 17:02:20 +0800
Message-ID: <5581379C.3090607@linux.intel.com>
References: <1433526566-21136-1-git-send-email-rric@kernel.org> <20150616132434.GO10428@rric.localhost> <20150616201341.GD22637@mtj.duckdns.org> <20150617084852.GL4914@rric.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23984 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752582AbbFQJCZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Jun 2015 05:02:25 -0400
In-Reply-To: <20150617084852.GL4914@rric.localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Richter <robert.richter@caviumnetworks.com>, Tejun Heo <tj@kernel.org>
Cc: Robert Richter <rric@kernel.org>, Sunil Goutham <sgoutham@cavium.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org

On 2015/6/17 16:48, Robert Richter wrote:
> From fd984f3be22f27b8d3c4cf577dbbf0a39792ea89 Mon Sep 17 00:00:00 200=
1
> From: Robert Richter <rrichter@cavium.com>
> Date: Wed, 17 Jun 2015 10:33:22 +0200
> Subject: [PATCH] ahci, msix: Fix build error for !PCI_MSI
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> Fixing a build error if PCI_MSI is unset:
>=20
>  drivers/ata/ahci.c: In function =E2=80=98msix_get_desc=E2=80=99:
>  drivers/ata/ahci.c:1210:2: error: =E2=80=98struct pci_dev=E2=80=99 h=
as no member named =E2=80=98msi_list=E2=80=99
>=20
> Catched by Fengguang's build bot.
>=20
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  drivers/ata/ahci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index bdedaa4f9d7b..99cc9526ae95 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1205,13 +1205,14 @@ static inline void ahci_gtf_filter_workaround=
(struct ata_host *host)
> =20
>  static struct msi_desc *msix_get_desc(struct pci_dev *dev, u16 entry=
)
>  {
> +#ifdef CONFIG_PCI_MSI
>  	struct msi_desc *desc;
> =20
>  	list_for_each_entry(desc, &dev->msi_list, list) {
>  		if (desc->msi_attrib.entry_nr =3D=3D entry)
>  			return desc;
>  	}
> -
> +#endif
Hi Robert,
	While at it, could you please help to use  for_each_pci_msi_entry()
from include/linux/msi.h instead of hard-coding? We are trying to refin=
e
the msi_list related code,
so we don't need to touch this code again later.
Thanks!
Gerry

>  	return NULL;
>  }
> =20
>=20
