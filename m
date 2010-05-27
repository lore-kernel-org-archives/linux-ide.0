From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 4/4] pata_samsung: Add Samsung PATA controller driver
Date: Thu, 27 May 2010 17:43:47 +0900
Message-ID: <AANLkTikr8txaKEE0FO4d-nA-cpQv3zIQ8TALqM539fhz@mail.gmail.com>
References: <1274948524-2970-1-git-send-email-kgene.kim@samsung.com>
	<1274948524-2970-5-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44836 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757587Ab0E0Int convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 May 2010 04:43:49 -0400
In-Reply-To: <1274948524-2970-5-git-send-email-kgene.kim@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, Abhilash Kesavan <a.kesavan@samsung.com>

On Thu, May 27, 2010 at 5:22 PM, Kukjin Kim <kgene.kim@samsung.com> wro=
te:
> From: Abhilash Kesavan <a.kesavan@samsung.com>
>
> Adds support for the Samsung PATA controller. This driver is based on=
 the
> Libata subsystem and references the earlier patches sent for IDE subs=
ystem.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> =C2=A0drivers/ata/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A09=
 +
> =C2=A0drivers/ata/Makefile =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A0drivers/ata/pata_samsung.c | =C2=A0591

=46asten your seat belts before reading further....

Rather than generic 'samsung', I would suggest the driver named
after the SoC, that is supported first(chronologically) in mainline ker=
nel.
All newer SoCs should be simply taken to contain the controller of that=
 SoC.
Otherwise, the same naming problem comes back to haunt us should
Samsung decides to use a different IP in future SoCs. What would we
call that driver? pata_samsung_v2.c ?

my two sparks
Jassi
