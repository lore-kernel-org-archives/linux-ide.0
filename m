From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ahci, msix: Fix build error for !PCI_MSI
Date: Wed, 17 Jun 2015 14:17:34 -0400
Message-ID: <20150617181734.GH22637@mtj.duckdns.org>
References: <1433526566-21136-1-git-send-email-rric@kernel.org>
 <20150616132434.GO10428@rric.localhost>
 <20150616201341.GD22637@mtj.duckdns.org>
 <20150617084852.GL4914@rric.localhost>
 <5581379C.3090607@linux.intel.com>
 <20150617133002.GW10428@rric.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f46.google.com ([209.85.213.46]:33933 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbbFQSRh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Jun 2015 14:17:37 -0400
Content-Disposition: inline
In-Reply-To: <20150617133002.GW10428@rric.localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Richter <robert.richter@caviumnetworks.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Robert Richter <rric@kernel.org>, Sunil Goutham <sgoutham@cavium.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org

On Wed, Jun 17, 2015 at 03:30:02PM +0200, Robert Richter wrote:
> From e43b79f0afd794d3e37ec0922c75e44b1c3f2e22 Mon Sep 17 00:00:00 200=
1
> From: Robert Richter <rrichter@cavium.com>
> Date: Wed, 17 Jun 2015 10:33:22 +0200
> Subject: [PATCH v2] ahci, msix: Fix build error for !PCI_MSI
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> It turned out the irq vector of the msix can be obtained from struct
> msix_entry. This makes the lookup function for msi_desc obsolete.
>=20
> This fixes a build error if PCI_MSI is unset:
>=20
>  drivers/ata/ahci.c: In function =E2=80=98msix_get_desc=E2=80=99:
>  drivers/ata/ahci.c:1210:2: error: =E2=80=98struct pci_dev=E2=80=99 h=
as no member named =E2=80=98msi_list=E2=80=99
>=20
> Catched by Fengguang's build bot.
>=20
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Robert Richter <rrichter@cavium.com>

Applied to libata/for-4.2.

Thanks.

--=20
tejun
