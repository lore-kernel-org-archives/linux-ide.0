Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC06C4338F
	for <linux-ide@archiver.kernel.org>; Tue, 17 Aug 2021 19:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A5AB60BD3
	for <linux-ide@archiver.kernel.org>; Tue, 17 Aug 2021 19:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhHQTHj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Aug 2021 15:07:39 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:43343 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhHQTHh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2021 15:07:37 -0400
Received: from localhost ([98.128.181.94]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N3bjH-1nGjbI143X-010c8w; Tue, 17 Aug 2021 21:06:55 +0200
Date:   Tue, 17 Aug 2021 21:06:54 +0200
From:   Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        hch@infradead.org, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] libata: Disable ATA_CMD_READ_LOG_DMA_EXT in problematic
 cases.
Message-ID: <YRwIzm8gHuwIlTI7@reimardoeffinger.de>
References: <DM6PR04MB708117F3FD8537CB6875E2C4E7FD9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210816171543.11059-1-Reimar.Doeffinger@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210816171543.11059-1-Reimar.Doeffinger@gmx.de>
X-Provags-ID: V03:K1:L4xesHq5ITk7SIzJunuTvhuekU3UedW5VTFsoTttVzZd8JPP0cJ
 QltQxmPvNgUcyE7ORDWBHEr0CnkA27Fsbr6oUVw1dVL7AdDsaXBtly0v4HmBg5ZQaltbXAG
 fusVQgYNrqyzwUBvYpvdDqJu6oxv/+bpdTyeJqIpbSUzJG1ywFuxqp6qGWLHxcpohD31clm
 984ogDV5OHF19C2qIIj0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rHzX6DPqk1M=:HJlN0i+tYry3ayYAM/2+VF
 ynXI4RtCgb3a0lW/7oSvqmk+xa3hfBOqLuUdNp3wcw0CStMPdymGjH1bASS1ksXi1LHmQwjZ4
 knZxfmKVci2q6nTZelTheHtAlWpOnSIG9KRU5MWeCiOPf9EvC3IAkQwql9W0G+0N4twJLYGOO
 RyUBKBflNXbdciNS/elsIWhOBDSckpnDKBIJvtbJ9AobbvfHUy0DtiUTN/o1ELo1r3xsXPVhP
 +vgknqoFG80L8UazgyCz+v/uUU/T/Ct1EDVJrxRR8LFQvnV2Z0jzp5hF2P753k/hy845G5gEC
 rRRCZ2XTiSZxul8Fqrxzj9OFTP8sBj9oH4pgmkBJVqk9m606URNX7hFoD8wTKuqXo3j7QYyu9
 8r0GVSyaG0k8oddmBwZnd3y8Fow3C53GsbSpQHZKXQKooFWJNc6eZldpCT8MG1Rv61XWzup9J
 J+3HFFcyAO7uRJ1quRNvsAkmhOglEjHhi00Rqs2E1x1P31+h5IKKvdaBkV7vNHUSOD9Gg4lSn
 SvKUf8aHnN//iNWxWiNsJlrtBfuGm8GkCRF7MqoAfUbSS1hP7G5CV8QFje76yvecjdbkKEaGI
 ksOSo7FkBqnVRJusnF3pBffEFdbtOr6F0NGMMosi51ExCUpIfAPvKpPG2O4xR0CJlllwyILP0
 vKpCbK7qc6TjF5Jq0sd4o1f1uc62llPqUyk3WvhhPc7/nYDoljfsofK7i5l3yWYp5qxV+et5j
 bNmcVhr552NO8xauDXzxrdHyrd70Y2VvMYqxIG0Lu0TEFHpp1mlrp6LdOl3eGEyuAMF7E0um7
 NHLZdDX2IXrWtq/F/x6dFszuiBLg3DKYjNn2MK7FcpFN+aL4/GjkHmH43lGshAF6iu2SAf9N5
 zUaN4Ifr8310qb3H9rMQ==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Aug 16, 2021 at 07:15:43PM +0200, Reimar Döffinger wrote:
>  	/* set horkage */
>  	dev->horkage |= ata_dev_blacklisted(dev);
> +	/* Disable READ_LOG_DMA with PATA-SATA adapters, they seem likely to hang */
> +	if (!(ap->flags & ATA_FLAG_SATA))
> +		dev->horkage |= ATA_HORKAGE_NO_DMA_LOG;

If the DMA enable patch is accept then this part is obsolete I believe,
from the testing on my device, leaving just adding the option and
disabling READ_LOG_DMA by default for MX500.
