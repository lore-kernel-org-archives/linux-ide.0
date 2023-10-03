Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411EAE776DA
	for <linux-ide@archiver.kernel.org>; Tue,  3 Oct 2023 01:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjJCBAk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Oct 2023 21:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjJCBAj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Oct 2023 21:00:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AF0B7
        for <linux-ide@vger.kernel.org>; Mon,  2 Oct 2023 18:00:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0371C433C7;
        Tue,  3 Oct 2023 01:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696294836;
        bh=bQedubQF4+OXZf0VkihIiNxjrWkeNJ0U97cB7jT+w2I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M3vMipy29nrIJ6EP2IVbBZTO/n1Fg7moAL8ZNetxJwwe+TeeGK9y6deTtTWFYs5f3
         dh9fK4n5tWDLbdXPCowuVu2bo1l2KtpJWtsrsdlo055R8p0kA49WurR47Ii31zgXlB
         fylRkmRsgASqXwVyCxIgBS764KP22f7hylyMM3VtYfChOUB+qThrlsiR2HH3Is/MIi
         BobT4kmjQ2AI0QyOo6ReOKChpYhb/4s3IKuXkueUxKkgqQTf8fk/5yWGYqJVf8vhhf
         GdPM80xGscKU/aIRsSH7cKRlDBcQBmE7wTZr//rsv/TJvEsZ6XI9XhSwyfvfTyVaiI
         qr0AmFxaAuW/g==
Message-ID: <6229a9c6-3832-d69b-c565-31710adff6be@kernel.org>
Date:   Tue, 3 Oct 2023 10:00:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ata: ahci: Add Intel Alder Lake-P AHCI controller to low
 power chipsets list
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-ide@vger.kernel.org, Koba Ko <koba.ko@canonical.com>
References: <20230925080538.2894982-1-mika.westerberg@linux.intel.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230925080538.2894982-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/25/23 17:05, Mika Westerberg wrote:
> Intel Alder Lake-P AHCI controller needs to be added to the mobile
> chipsets list in order to have link power management enabled. Without
> this the CPU cannot enter lower power C-states making idle power
> consumption high.
> 
> Cc: Koba Ko <koba.ko@canonical.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to libata for-6.7. Thanks !

-- 
Damien Le Moal
Western Digital Research

