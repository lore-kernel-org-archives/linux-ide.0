Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4C6EB64D9
	for <linux-ide@archiver.kernel.org>; Sun, 18 Jun 2023 03:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjFRDCL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 17 Jun 2023 23:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjFRDCK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 17 Jun 2023 23:02:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81062E5A
        for <linux-ide@vger.kernel.org>; Sat, 17 Jun 2023 20:02:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96CF360F59
        for <linux-ide@vger.kernel.org>; Sun, 18 Jun 2023 03:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AF3C433C0;
        Sun, 18 Jun 2023 03:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687057327;
        bh=zsn3MAoNEGNdsu7vJ+AuTplP3EPHBohVTXdVekodU5U=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=Ub3EBZ8k1PlVeN3OwCsilxB7cwqZJwiKrkUqJscLxGScSmIpUehNSoxKOlo8QDhul
         L7TbBp/QG32K3SeaSqZtGG+uqrxLHuWisaCz6BnUG/k4HXMU4A0RP9SeptGIi0A80q
         U62LoanRT+XzhL5rYev1T3e71yWHAXCGl4yjCHvegIPVwSUua6jX/gXsllokn3mL2d
         LRvBb2uLqmjq40vGru2Dsfl7PgyiXTppPcEpxKSh5UW0E2MoXLtZZW6ECSbqn7yA4H
         yc4axP/IJxOUNJ867nTK+adhzSryDnGSrJ3wATnzEv8Dhaj5CDB3VNQbrrVuHvyOry
         zErvafe+k0Zvw==
Message-ID: <fa363e94-6fba-5199-d02d-8bce1d219007@kernel.org>
Date:   Sun, 18 Jun 2023 12:02:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] ata fixes for 6.4-rc7
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
References: <20230618025811.292922-1-dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20230618025811.292922-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/18/23 11:58, Damien Le Moal wrote:
> Linus,
> 
> The following changes since commit 7f875850f20a42f488840c9df7af91ef7db2d576:
> 
>   ata: libata-scsi: Use correct device no in ata_find_dev() (2023-05-30 08:08:18 +0900)
> 
> are available in the Git repository at:
> 
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.4-rc7
> 
> for you to fetch changes up to 1f219070f4a87ea43fab65f133d0957adbfd2390:
> 
>   ata: libata-scsi: Avoid deadlock on rescan after device resume (2023-06-18 11:53:31 +0900)

Linus,

Please ignore (my apologies for the noise). Resending this.

> 
> ----------------------------------------------------------------
> ata fixes for 6.4-rc7
> 
>  - Avoid deadlocks on resume from sleep by delaying scsi rescan until
>    the scsi device is also fully resumed.
> 
> ----------------------------------------------------------------
> Damien Le Moal (1):
>       ata: libata-scsi: Avoid deadlock on rescan after device resume
> 
>  drivers/ata/libata-core.c |  3 ++-
>  drivers/ata/libata-eh.c   |  2 +-
>  drivers/ata/libata-scsi.c | 22 +++++++++++++++++++++-
>  include/linux/libata.h    |  2 +-
>  4 files changed, 25 insertions(+), 4 deletions(-)

-- 
Damien Le Moal
Western Digital Research

