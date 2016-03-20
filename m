From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: icside: remove incorrect initconst annotation
Date: Sun, 20 Mar 2016 17:01:06 -0400 (EDT)
Message-ID: <20160320.170106.770272160812836442.davem@davemloft.net>
References: <1454941909-2778808-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:60779 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbcCTVBJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Mar 2016 17:01:09 -0400
In-Reply-To: <1454941909-2778808-1-git-send-email-arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon,  8 Feb 2016 15:31:45 +0100

> The icside_probe function can be called for hotplugged devices, so
> its reference to the __initconst icside_v6_port_info variable
> may be invalid, as Kbuild points out:
> 
> WARNING: drivers/ide/icside.o(.text+0x338): Section mismatch in reference from the function icside_probe()
>  to the (unknown reference) .init.rodata:(unknown)
> 
> Interestingly, this problem only shows up with clang but not
> with gcc, which optimizes out the __initconst variable.
> 
> This removes the incorrect annotation.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
