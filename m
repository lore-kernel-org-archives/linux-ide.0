From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata-rb532-cf: get rid of the irq_to_gpio() call
Date: Thu, 18 Feb 2016 11:28:11 -0500
Message-ID: <20160218162811.GA13177@mtj.duckdns.org>
References: <1455710300-30920-1-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34826 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946877AbcBRQ2N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Feb 2016 11:28:13 -0500
Content-Disposition: inline
In-Reply-To: <1455710300-30920-1-git-send-email-juhosg@openwrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-ide@vger.kernel.org, Alban Bedel <albeu@free.fr>, Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org

On Wed, Feb 17, 2016 at 12:58:20PM +0100, Gabor Juhos wrote:
> The RB532 platform specific irq_to_gpio() implementation has been
> removed with commit 832f5dacfa0b ("MIPS: Remove all the uses of
> custom gpio.h"). Now the platform uses the generic stub which causes
> the following error:

Applied to libata/for-4.5-fixes.  As for the gpiod API conversion,
please do that in separate patches.

Thanks.

-- 
tejun
