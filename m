Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79BFC433FE
	for <linux-ide@archiver.kernel.org>; Thu, 13 Oct 2022 05:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJMFzU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 13 Oct 2022 01:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiJMFzS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 13 Oct 2022 01:55:18 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72436C109
        for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2022 22:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1665640511; x=1697176511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5CiRPgIDP7uz7PRFVbd56oiuqj4J9JjKXOcViKKuO5w=;
  b=eOKWJbFoZlO+a2sS67h+sT7b71Pjd2NWL3DQpagwK2+u+w6AVSIfGLvC
   5S5wjO0YeOySdsjnX4GI4qzVi4Z5Y6nEhh8dYFt7B1Rdzrmfm45Zxgoz/
   hsINIfOtKa/FNWYYigq/5kKchR/J6VMwEEVlJsGubQsTFPjJOwLnTpJCd
   Xs7/g1t0Vb+Lnn3p6vHMyqoO9RMo/dSriqf8xHfss2kIPGYrbmN4j2lCm
   KtOubPKe1wF3LzOU/ECDCftMTTLQRcr1GHkD9jSPvvF1iDWV6GFeEFg4N
   og3uwSKtXNUuXEZ7qI7o0eSbqLOM99zI6eZCtS5npCAV/aS8anOWP3eh1
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,180,1661810400"; 
   d="scan'208";a="26721450"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 13 Oct 2022 07:55:09 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 13 Oct 2022 07:55:09 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 13 Oct 2022 07:55:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1665640509; x=1697176509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5CiRPgIDP7uz7PRFVbd56oiuqj4J9JjKXOcViKKuO5w=;
  b=mkk0PTGTiZRaVs55bjkKQvaaIsfU5b+HOu5BFwSALAKOB2HApBA6H2qY
   Jxc1HvbUXIzLZIVP4HwVq5s+QyMwD/vPdyShaSg8wc7JxwzTdsmtEJRsi
   ndcvQcHCjLPz7aZyRC+YGiOnWukTEBDOIVgPikfbUv5J8ynL+5B6wzOUY
   3NDZneOmiqWA54FHHiaoGcAoXheljeDZTexIfMDkwMIyRDSaFl3LQgcHd
   E4BQLyiBZeyxtED8zJ3gdQur+eUI9xGe4OADfEc10BnLTFQYl6JadIO4m
   8NODq0zbEpiVKT6LOC1o2ip63KZ8r7MkTRNoOdWlSiBTDhl81nrBMzxGv
   w==;
X-IronPort-AV: E=Sophos;i="5.95,180,1661810400"; 
   d="scan'208";a="26721449"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Oct 2022 07:55:08 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id BB1AD280056;
        Thu, 13 Oct 2022 07:55:08 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Fabio Estevam <festevam@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] ata: ahci-imx: Fix MODULE_ALIAS
Date:   Thu, 13 Oct 2022 07:55:06 +0200
Message-ID: <4442509.LvFx2qVVIh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <fe62c669-01e0-52bd-fae2-69fcbc375c23@opensource.wdc.com>
References: <20221012131105.725258-1-alexander.stein@ew.tq-group.com> <5877338.lOV4Wx5bFT@steina-w> <fe62c669-01e0-52bd-fae2-69fcbc375c23@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello Damien,

Am Donnerstag, 13. Oktober 2022, 06:20:16 CEST schrieb Damien Le Moal:
> On 10/12/22 22:30, Alexander Stein wrote:
> > Hello Fabio,
> > 
> > Am Mittwoch, 12. Oktober 2022, 15:23:04 CEST schrieb Fabio Estevam:
> >> Hi Alexander,
> >> 
> >> On Wed, Oct 12, 2022 at 10:11 AM Alexander Stein
> >> 
> >> <alexander.stein@ew.tq-group.com> wrote:
> >>> 'ahci:' is an invalid prefix, preventing the module from autoloading.
> >>> Fix this by using the 'platform:' prefix and DRV_NAME.
> >> 
> >> What about adding a Fixes tag?
> >> 
> >> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> > 
> > Thanks. A Fixes tag seems reasonable, but I have to admit I don't know at
> > which point auto loading stopped working (if it did at all).
> 
> Given that the alias was wrong in the first place when added for a
> platform driver, this I think should be a fix for:
> 
> 9e54eae23bc9 ("ahci_imx: add ahci sata support on imx platforms")

I was hesitating tagging the very first commit, not knowing if it did work at 
that time. But it seems reasonable.

> I can add the Fixes tag when applying.

Thanks!

Best regards,
Alexander


