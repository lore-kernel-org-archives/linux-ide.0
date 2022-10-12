Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC10C4332F
	for <linux-ide@archiver.kernel.org>; Wed, 12 Oct 2022 13:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiJLNaO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 12 Oct 2022 09:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiJLNaL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2022 09:30:11 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8875230548
        for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2022 06:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1665581407; x=1697117407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VUQfEgYnTxt46y3lPmAjh4eGn2QA84UvLb9AeykCqhw=;
  b=Q0hGa8P3Iy3vC5TePLvf0Vq/9NLSGxG3rNMZmWa9pEVqIrhSTXf6bpxG
   xQ0k9adpVgAwPtQKqjLiLvfEpjvfXn6dX4E7Q1ybnvAbL7YS60Un7NTaT
   8Ar8n0oqCK715mU2eiRsfN4cgoU8KF2pslRl0BDi6fPpWgVjTt3uhN+CT
   R5JOyqAVoMnt8ruhnaCnOlqA8AuDgfZbLyRJD0nA76i+HFjmEIsheKNcp
   GVcOl0HjuJPlbit3uykNVf/82CB7QlDfz4GBHlTE84VrKboONqPdR2U9f
   YhWqeOrgMIwQbO4EJbsf7EMP+RJBNrVmR8XWyZcCRfLMn5Nr3UX/XD8Gq
   w==;
X-IronPort-AV: E=Sophos;i="5.95,179,1661810400"; 
   d="scan'208";a="26710329"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 12 Oct 2022 15:30:05 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 12 Oct 2022 15:30:05 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 12 Oct 2022 15:30:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1665581405; x=1697117405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VUQfEgYnTxt46y3lPmAjh4eGn2QA84UvLb9AeykCqhw=;
  b=W8VnxwtXggs/qFWo3uC3/PTKHpzCKeLLc5mvNOA/6pfc5NpICt1Spyld
   l8h4HxsnhELlJ6VcpqewdHQjs9J6ZnuCrC+KQ3ENKv7bOOS8+XCReIe8W
   Ab3auv6I0c+zULsojtVPS03BEM6eGWoRAyv0gm7AhIyUx56AimvVP5g7Q
   YFfo1aqFERLef2zwtvOsfKESlFc4nQV48lsQR9oQ0fzfC+e4D7p2fr1V7
   6RSC5gafddY+Oigscln/jb3UHD48jqBiEJWUUJ/RM5wtoZJ1qY8wPl+0v
   Je3N5cMSJo3qSHnPjPybKm+yGROR3k5pXOxetxEoIOwzqLzdB0S3rHyC9
   g==;
X-IronPort-AV: E=Sophos;i="5.95,179,1661810400"; 
   d="scan'208";a="26710328"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 12 Oct 2022 15:30:05 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 773CE280056;
        Wed, 12 Oct 2022 15:30:05 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] ata: ahci-imx: Fix MODULE_ALIAS
Date:   Wed, 12 Oct 2022 15:30:05 +0200
Message-ID: <5877338.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAOMZO5DzFtuVxuAhmtsBx+EoxXgeg6nHDeJiLULsY8wRdpXbEw@mail.gmail.com>
References: <20221012131105.725258-1-alexander.stein@ew.tq-group.com> <CAOMZO5DzFtuVxuAhmtsBx+EoxXgeg6nHDeJiLULsY8wRdpXbEw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello Fabio,

Am Mittwoch, 12. Oktober 2022, 15:23:04 CEST schrieb Fabio Estevam:
> Hi Alexander,
> 
> On Wed, Oct 12, 2022 at 10:11 AM Alexander Stein
> 
> <alexander.stein@ew.tq-group.com> wrote:
> > 'ahci:' is an invalid prefix, preventing the module from autoloading.
> > Fix this by using the 'platform:' prefix and DRV_NAME.
> 
> What about adding a Fixes tag?
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks. A Fixes tag seems reasonable, but I have to admit I don't know at 
which point auto loading stopped working (if it did at all).

Best regards,
Alexander



