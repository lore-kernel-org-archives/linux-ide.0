From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] drivers: ide: Include appropriate header file in
 ide-cd_verbose.c
Date: Tue, 17 Dec 2013 21:11:42 +0300
Message-ID: <52B093DE.3010309@cogentembedded.com>
References: <d24d7befadfbfb9501d0e873f13e39fd42ec893b.1387278225.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d24d7befadfbfb9501d0e873f13e39fd42ec893b.1387278225.git.rashika.kheria@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rashika Kheria <rashika.kheria@gmail.com>, linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, josh@joshtriplett.org
List-Id: linux-ide@vger.kernel.org

Hello.

On 12/17/2013 02:08 PM, Rashika Kheria wrote:

> Include appropriate header file ide-cd.h in ide-cd_verbose.c because
> function ide_cd_log_error() has its prototype declaration in ide-cd.h=
=2E
> Also, include linux/ide.h because it contains certain declarations
> necessary for including ide-cd.h.

    You should fix "ide-cd.h" if it depends on <linux/ide.h>, not the .=
c file=20
including it.

> This eliminates the following warnings in ide-cd_verbose.c:
> drivers/ide/ide-cd_verbose.c:251:6: warning: no previous prototype fo=
r =E2=80=98ide_cd_log_error=E2=80=99 [-Wmissing-prototypes]

> Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>

WBR, Sergei
