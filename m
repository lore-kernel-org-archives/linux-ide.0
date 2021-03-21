Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A2CC433E0
	for <linux-ide@archiver.kernel.org>; Sun, 21 Mar 2021 19:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970AC61941
	for <linux-ide@archiver.kernel.org>; Sun, 21 Mar 2021 19:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhCUTzY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 21 Mar 2021 15:55:24 -0400
Received: from angie.orcam.me.uk ([157.25.102.26]:38022 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhCUTzW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 21 Mar 2021 15:55:22 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 7B85D92009C; Sun, 21 Mar 2021 20:55:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 713E992009B;
        Sun, 21 Mar 2021 20:55:17 +0100 (CET)
Date:   Sun, 21 Mar 2021 20:55:17 +0100 (CET)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/3] ata: Module parameter clean-ups for pata_legacy and
 pata_platform
Message-ID: <alpine.DEB.2.21.2103202152120.21463@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

 In the course of looking into Christoph's recent proposal to drop legacy 
IDE drivers I have come across a number of issues with module parameters 
of the pata_legacy and pata_platform drivers: errors in documentation 
present in the comment form, missing user-visible documentation, and 
unconditional poking at ISA I/O ports in pata_legacy that isn't there with 
the old ide-generic driver (the lack of `probe_mask' parameter).

 Here's a small patch series that addresses these issues.  Overall I 
find the design of the pata_legacy driver's options a bit messy, e.g. the 
`all' vs the `probe_all' parameter, and the interpretation of masks where 
bits correspond to probed PATA locations in a particular system (rather 
than either all known or all existing), but it's been there long enough I 
think we have to keep it, so I merely tried to describe the current 
semantics.  See the individual change descriptions for details.

 The changes have been run-time verified with an EISA system and a single 
ISA PATA adapter at the usual primary I/O location.  They have also been 
verified (mainly for the correctness of MODULE_PARM_DESC use) with an 
x86/PC build (for pata_legacy) and a MIPS/SWARM build (for pata_platform).

 Please apply.

  Maciej
