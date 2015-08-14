From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] arm: mainstone_defconfig: disable IDE subsystem
Date: Fri, 14 Aug 2015 21:09:07 +0200
Message-ID: <87wpwxadrg.fsf@belgarion.home>
References: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
	<1439571876-13758-14-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439571876-13758-14-git-send-email-b.zolnierkie@samsung.com>
	(Bartlomiej Zolnierkiewicz's message of "Fri, 14 Aug 2015 19:04:29
	+0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> writes:

> This patch disables deprecated IDE subsystem in mainstone_defconfig
> (no IDE host drivers are selected in this config so there is no valid
> reason to enable IDE subsystem itself).
>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

--
Robert
