Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28F6C4167B
	for <linux-ide@archiver.kernel.org>; Mon,  6 Nov 2023 09:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjKFJyG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 6 Nov 2023 04:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFJyF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 6 Nov 2023 04:54:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDB7A3;
        Mon,  6 Nov 2023 01:54:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1497C433C7;
        Mon,  6 Nov 2023 09:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699264442;
        bh=m/mzm7iLrTsnHtPqt1cu5LmeB8xYFjobdVt0l+eaEJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLsaGwzrWFWwnNwKXBfn9nKroEaC/lpYlJ5ITMpJYGRdbETMVk0ufdlBVT9AZnn2A
         vIY7e705e3516VlJ+T+TeX5IEZh0RPfjmi3hgejXgiVo1TtoX2I3kjALVWiV+EL3V7
         BVgc+4MdNXs4eXSDxIbHI795d7QMMw0xz7dGPfAI=
Date:   Mon, 6 Nov 2023 10:53:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Barker <paul.barker.ct@bp.renesas.com>
Cc:     stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Luis Machado <luis.machado@arm.com>, linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 4.14] ata: ahci: fix enum constants for gcc-13
Message-ID: <2023110651-frays-swapping-4337@gregkh>
References: <20231031173255.28666-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031173255.28666-1-paul.barker.ct@bp.renesas.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Oct 31, 2023 at 05:32:55PM +0000, Paul Barker wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> commit f07788079f515ca4a681c5f595bdad19cfbd7b1d upstream.
> 
> gcc-13 slightly changes the type of constant expressions that are defined
> in an enum, which triggers a compile time sanity check in libata:

All now queued up, thanks.

greg k-h
