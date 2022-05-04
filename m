Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD86CC433F5
	for <linux-ide@archiver.kernel.org>; Wed,  4 May 2022 14:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351190AbiEDOS0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 4 May 2022 10:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351148AbiEDOSZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 4 May 2022 10:18:25 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8C0427E2
        for <linux-ide@vger.kernel.org>; Wed,  4 May 2022 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651673689; x=1683209689;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3gz1SvToUvc61rP9gSGLK3Q0CP+ks8gO3XkKncVaLcU=;
  b=COCrOYgFrn6DG0na2MMmcR2v4O/gAyDX3R4f9BtIFskS/Kzz1VNbFgWF
   tnuMbda/Veb2245tid+RcSzTxi604ypA321Ol5C5Sggnlb+1ZwXUjz0vO
   Iy/a76LOYvR/rNLLlQTvWw4+AqB2fYqM8OzhmUqrv0zQ/SIUSVFJuxy/i
   PeGmJ9/1EVJKB4y3lpC6rFrmdv4r31ll/B2b52z0a5S/k/vboOzGo3ueV
   D1sm9HBiTIWkPDremD0qY3NU6yfJ5IKcNy2GWynKFhv+2hL/E9OdC4mnd
   +rVAyVmJ7w7Q5L2pLewz7j4bi/cref4Ue4GPIWddBbuPgPVw4Y+SMZyzm
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,198,1647273600"; 
   d="scan'208";a="198343919"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2022 22:14:47 +0800
IronPort-SDR: 3jVR3Lf1M/5up9XWIbOAalj+Mr8BzDMRE2pCGSSk/ZY+Qyto8xnRalXsmyuH5WW7PdkgP/nrka
 b3oDM8Ujv/3aI0m31YwRQbu9p5WOkee9BX/BdBdwgarxSfbQGmFu13dbDQR/PpDUZNUysdFrAQ
 OdknLxwHwINPTzO7rCm3rM8v3bFlLk2nEv8iwv1k5LZiu3/R6qm/pRQtDR6KD5/pdp61g/0XBb
 7Cskn4m+ZyZ0//XVfmKU45nwULcXTChI09R5JramzS/o+6vIxejH/rFlBpxmsSEfVjyOBcVOij
 7CFIlJ2hQP836LCk6l+hNwJ0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2022 06:45:29 -0700
IronPort-SDR: Ev7MJI3q85CXNBjQ5mInbQ6a5N+kDg2ppvAxstwUEoeCSYIhJ0bjGvYCFvpXEevLJbxxVvph32
 FXg1sqApPKNPXE5RIlQbR85ektZfVZWp2PFR09Bv7/gbwd+lES74Bum06zY1cZXqIcBY/8q6gK
 PjAZO7Zx1dSQa9FPgh22bihRdwYDU2wCuMDKh5sKyJRhMGLGmyKZekv/QP0tEsIlM7BvLyqcXj
 cWfXYbrNzHAmUFlAjWlsaRR5f/AF36t+0JDWBbqZXEgLNyHKjPaipMAjtFRub8UAcuqjahejeT
 sUw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2022 07:14:48 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Ktf3V62Mnz1SVp5
        for <linux-ide@vger.kernel.org>; Wed,  4 May 2022 07:14:46 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651673686; x=1654265687; bh=3gz1SvToUvc61rP9gSGLK3Q0CP+ks8gO3Xk
        KncVaLcU=; b=Irb3PekokvtqFuHO2x930y5RXWVryj/RHb7TPBz8hyKjQQGiEZS
        PNlDM4PBOewSd6GF6QqDO6PMCeng/9fFLxdgUo2KnanoesyieOuJq7vgIy5+qpxw
        37+IgA4VWZihtrROBbzcaUPUO/1emO4SxozHORu/HDrxTdhpZr13EOxk5Ls2EfcV
        /KiQamg4sm9jTZI9nmoP0HkKDzR49F0X1N8WiDmHBLdwWy+qovjqnq5+A1piy09q
        sFZWZpyq0sV2yJfo6NNJ7PY1KHDv2FMcro0qaeTbOCc//hkT7yDUI4wcYnREho+7
        1IyVSmCp4iio3QoJKV7OXxGBhwctFUqKhpQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2ByNuHIPrasv for <linux-ide@vger.kernel.org>;
        Wed,  4 May 2022 07:14:46 -0700 (PDT)
Received: from [10.225.81.200] (unknown [10.225.81.200])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Ktf3S0q49z1Rvlc;
        Wed,  4 May 2022 07:14:44 -0700 (PDT)
Message-ID: <a3d58159-292d-70e2-d811-e54c9b49c9c8@opensource.wdc.com>
Date:   Wed, 4 May 2022 23:14:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v1 2/4] powerpc/mpc5xxx: Switch
 mpc5xxx_get_bus_frequency() to use fwnode
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wolfram Sang <wsa@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Anatolij Gustschin <agust@denx.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Mark Brown <broonie@kernel.org>
References: <20220504134449.64473-1-andriy.shevchenko@linux.intel.com>
 <20220504134449.64473-2-andriy.shevchenko@linux.intel.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220504134449.64473-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/05/04 22:44, Andy Shevchenko wrote:
> Switch mpc5xxx_get_bus_frequency() to use fwnode in order to help
> cleaning up other parts of the kernel from OF specific code.
> 
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

For the pata bits,

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
