From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCHv3 5/5] ARM: configs: add ahci_mvebu to
 multi_v7_defconfig
Date: Fri, 25 Apr 2014 20:25:18 -0400
Message-ID: <20140426002518.GL28159@titan.lakedaemon.net>
References: <1397574006-5868-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397574006-5868-6-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16436 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbaDZAZg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Apr 2014 20:25:36 -0400
Content-Disposition: inline
In-Reply-To: <1397574006-5868-6-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@linaro.org>
Cc: Tejun Heo <tj@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Arnd, Olof, Kevin,

On Tue, Apr 15, 2014 at 05:00:06PM +0200, Thomas Petazzoni wrote:
> The Marvell Armada 38x platform needs the ahci_mvebu driver enabled
> for the AHCI interfaces, so this commit enables the corresponding
> Kconfig option in multi_v7_defconfig.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Conflict-ridden file, please take directly.

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
