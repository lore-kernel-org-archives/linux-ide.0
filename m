Return-Path: <SRS0=PzfI=74=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F020C433E0
	for <linux-ide@archiver.kernel.org>; Mon, 15 Jun 2020 07:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C3E22068E
	for <linux-ide@archiver.kernel.org>; Mon, 15 Jun 2020 07:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgFOHVi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:21:38 -0400
Received: from verein.lst.de ([213.95.11.211]:59980 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgFOHVi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 15 Jun 2020 03:21:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DA67168AFE; Mon, 15 Jun 2020 09:21:36 +0200 (CEST)
Date:   Mon, 15 Jun 2020 09:21:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: fix AHCI_SHT() macro definition
Message-ID: <20200615072136.GB21903@lst.de>
References: <CGME20200612120932eucas1p29411e0c60963fad8c36ca35f2e6b8872@eucas1p2.samsung.com> <0d803e72-b15e-4673-4858-4741f2772fc4@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d803e72-b15e-4673-4858-4741f2772fc4@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Jun 12, 2020 at 02:09:31PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Fix AHCI_SHT() macro definition to not reinitialize .can_queue and
> .sdev_attrs fields.
> 
> This removes gcc warnings from W=1 builds such as:

I think these warnings arg bogus, at least when used with cases like
libata that want to implement inheritance schemes.  Can we get them
removed from W=1 insted if people really are about W=1 builds?
