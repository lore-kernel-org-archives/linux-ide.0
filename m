From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 3/3] ahci: st: Add support for ST's SATA IP
Date: Wed, 26 Feb 2014 13:55:33 +0000
Message-ID: <20140226135533.GN9195@lee--X1>
References: <1393328481-7251-1-git-send-email-lee.jones@linaro.org>
 <1393328481-7251-3-git-send-email-lee.jones@linaro.org>
 <20140225144141.GA26788@htj.dyndns.org>
 <20140226135108.GC17302@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:36070 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbaBZNzj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Feb 2014 08:55:39 -0500
Received: by mail-we0-f182.google.com with SMTP id u57so1694983wes.27
        for <linux-ide@vger.kernel.org>; Wed, 26 Feb 2014 05:55:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140226135108.GC17302@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, DCG_UPD_stlinux_kernel@list.st.com, linux-ide@vger.kernel.org

> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: linux-ide@vger.kernel.org
> > > Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >=20
> > Applied to libata/for-3.15 w/ missing "\n" added to dev_err() in
> > st_ahci_suspend().
>=20
> Reverted from libata/for-3.15 due to build failure.  Please drop
> ahci_platform_put_resource() calls.  ahci_platform now manages it
> through devres.

Ah, nice fixup.

I'll rebase onto your most recent tree and retest.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
