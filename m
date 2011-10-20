From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH ] ide-{cd,floppy,tape}: Do not include <linux/irq.h>
Date: Thu, 20 Oct 2011 14:37:14 +0200
Message-ID: <20111020123714.GB28316@gere.osrc.amd.com>
References: <1319112675-27523-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1319112675-27523-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Oct 20, 2011 at 02:11:15PM +0200, Geert Uytterhoeven wrote:
> The top of <linux/irq.h> has this comment:
>=20
>  * Please do not include this file in generic code.  There is current=
ly
>  * no requirement for any architecture to implement anything held
>  * within this file.
>  *
>  * Thanks. --rmk
>=20
> Remove inclusion of <linux/irq.h>, to prevent the following compile e=
rror
> from happening soon:
>=20
> | include/linux/irq.h:132: error: redefinition of =E2=80=98struct irq=
_data=E2=80=99
> | include/linux/irq.h:286: error: redefinition of =E2=80=98struct irq=
_chip=E2=80=99
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-ide@vger.kernel.org

Acked-by: Borislav Petkov <bp@alien8.de>

Thanks.

--=20
Regards/Gruss,
Boris.
