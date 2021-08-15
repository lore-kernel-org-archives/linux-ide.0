Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF1DC4338F
	for <linux-ide@archiver.kernel.org>; Sun, 15 Aug 2021 16:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E829C60FD8
	for <linux-ide@archiver.kernel.org>; Sun, 15 Aug 2021 16:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhHOQfN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 15 Aug 2021 12:35:13 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:52351 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhHOQfN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 15 Aug 2021 12:35:13 -0400
Received: from localhost ([98.128.181.94]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M1aQN-1mDODI0LiF-00380Z; Sun, 15 Aug 2021 18:34:35 +0200
Date:   Sun, 15 Aug 2021 18:34:34 +0200
From:   Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] libata: add kernel parameter to force
 ATA_HORKAGE_NO_DMA_LOG
Message-ID: <YRlCGuFDe8epcFTE@reimardoeffinger.de>
References: <20210814134709.16085-1-Reimar.Doeffinger@gmx.de>
 <YRjN4oULwmNKI/yi@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <YRjN4oULwmNKI/yi@infradead.org>
X-Provags-ID: V03:K1:ed5mYX/rCEPzHyI0MHQal3J55amXa7uYDNZnPRElHZVPiUL672u
 RBtOIDzbw1+m6zwJ1JcckfCDEenqIkN3swrOpztxf6BWc7uNkDEGpWNz02X7TxxNO8yYV7M
 yl4DL2C445/S8ufmtMTVW9IkVHpTiM6rMSkw7wFKleOl1cNXl24uRbZ7ecH4ZzktkkN+Rkz
 ib7ThxUc6Gxc3Tlf1eVRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ndl7cIEAwlE=:ehFyDmbILR+43zDuzQNeBw
 5+k0RiPiV777A/MuX65trvtOGjlxl4foL79jR79fJAfdP5ovUsaWmFxZXD+hNEn3dIJhLzcaU
 flTi3yv9H3gMG3GhrRXPHjx+QqvMk05O/hRVM0t9B0UcYpyICiQLT2Bc7y8gPHItNlJ3tytD1
 pSAwnLTnehPj85M2ay3m5Z9myOVyIG6beqHQq/JQSHiRyj1Hyn9cpGBlo/NuDx15eWjLuZTPg
 tdQicJBc6vBNQozXb9uQFgAO7+kg3zqv9vc+cYP5FQJJXNJ0frY+YRltceLMLYkKjLz9BE3SZ
 B1PkKSIZJ62KQL4ISabyADPlJWoKE/mJKtOLffhfxfkvbdVyMfkNIco+hFVSVDgMcD6u6Cjlq
 wmAXY10IP0Gs2JdHY6talCUGHqRf7XT+OLUSNkXWC4QniZ6q4fGvv9UaZpB1v2DbSUjTnusyF
 gjcA46mrJ2GGS8vwjJCpfpNVLgmBGfeaXZBOcAumZETTTCXo98FHzPzgiDVRjrToUD6ZIVO4H
 nVOCeaFNPkiZDCpypz0A/AL6wpbpNnMQseQMa5pwDdGHN9uLlssR+w5i38tsZRk5JFbGE3hW+
 SPNaeYYNoGiQVOr6wvRp8Fkr/bJmhXsqR+0mMHvjMo/EILe7HyPIkeAaeuuDHEVdKejswQaZj
 RMw6IOjx+DZQUGW57aQ+1y74xmrAgfbf6yQyObXWpPYR2HFqP9J2QJQZz4vEaxguR1v5UyK/o
 mXjHQM7kYDtCIwOJRVCux61dE1cJ6rT6Mo5LVbffrWjqRDsiXN5HbZ+nEhylqyXVMyOUR0Wj/
 BQoXhEfEcqOFl77m51pjwmQ944RJU4PmABxP2olOz6ooxs54ekOcJi4El7wths+aMkawLdCzn
 QPyxbr8bFmWwR7W4FVcQ==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi!
On Sun, Aug 15, 2021 at 09:18:42AM +0100, Christoph Hellwig wrote:
> Please just add quirks for the affected setups instead of requiring
> the user to pass an obscure parameter.

I sent a patch for that and still adding the parameter.

For completeness, my original reply which did not make it to the list
(it seems emails from gmx.de do not make it through):
The point of the parameter is to be able to gather data and find out which setups are affected, enabling less knowledgeable users to help.
The sample size so far is 2, and with quite different setups, it's not even clear to me if it's a controller issue, a drive issue, or a combination.
If this feature is not very relevant it would be possible to apply a fairly broad quirk, but I feel a bit hesitant about that.
