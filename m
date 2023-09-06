Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E6EEB8FAF
	for <linux-ide@archiver.kernel.org>; Wed,  6 Sep 2023 13:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241001AbjIFNCb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 6 Sep 2023 09:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjIFNCa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Sep 2023 09:02:30 -0400
Received: from srv.wefi.net (srv.wefi.net [80.66.63.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C78E71724
        for <linux-ide@vger.kernel.org>; Wed,  6 Sep 2023 06:02:24 -0700 (PDT)
Received: from pc2019 (089144221169.atnat0030.highway.webapn.at [89.144.221.169])
        by srv.wefi.net (Postfix) with ESMTPSA id 438795A3586;
        Wed,  6 Sep 2023 15:02:23 +0200 (CEST)
Message-ID: <b8acf4ac24b4b77fa96a687837b2ec5c5f841adb.camel@wefi.net>
Subject: Re: [PATCH v2] ata: ahci: Add Elkhart Lake AHCI controller
From:   Werner Fischer <devlists@wefi.net>
To:     Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Date:   Wed, 06 Sep 2023 15:02:22 +0200
In-Reply-To: <a8b37277-9c20-d9c2-5e9a-4374f9222cd0@kernel.org>
References: <4cbde7d33f5b73b33f798b56b6e3cd3ce3764647.camel@wefi.net>
         <a8b37277-9c20-d9c2-5e9a-4374f9222cd0@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sat, 2023-09-02 at 12:09 +0900, Damien Le Moal wrote:
> Applied to for-6.6. Thanks !
Thank you, too.

> Note: when sending patches, please also add the maintainer(s) to your
> email "to:" list.
Thank you for the hint, I will do it next time.

Best regards,
Werner

