From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2] drivers: ide: Include appropriate header file in
 ide-cd_verbose.c
Date: Tue, 17 Dec 2013 12:19:21 +0100
Message-ID: <20131217111920.GA30592@pd.tnic>
References: <d24d7befadfbfb9501d0e873f13e39fd42ec893b.1387278225.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:41746 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090Ab3LQLT0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Dec 2013 06:19:26 -0500
Content-Disposition: inline
In-Reply-To: <d24d7befadfbfb9501d0e873f13e39fd42ec893b.1387278225.git.rashika.kheria@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rashika Kheria <rashika.kheria@gmail.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, josh@joshtriplett.org

On Tue, Dec 17, 2013 at 04:38:16PM +0530, Rashika Kheria wrote:
> Include appropriate header file ide-cd.h in ide-cd_verbose.c because
> function ide_cd_log_error() has its prototype declaration in ide-cd.h=
=2E
> Also, include linux/ide.h because it contains certain declarations
> necessary for including ide-cd.h.
>=20
> This eliminates the following warnings in ide-cd_verbose.c:
> drivers/ide/ide-cd_verbose.c:251:6: warning: no previous prototype fo=
r =E2=80=98ide_cd_log_error=E2=80=99 [-Wmissing-prototypes]

drivers/ide/ is open only to fixes for serious, real bugs - nothing
else. I wouldn't waste my time with it if I were you.

--=20
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
