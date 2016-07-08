From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
Date: Fri, 08 Jul 2016 22:23:48 +0200
Message-ID: <2773873.Jjn1O47GXr@wuerfel>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Olof Johansson <olof@lixom.net>
List-Id: linux-ide@vger.kernel.org

On Friday, July 8, 2016 5:24:41 PM CEST Bartlomiej Zolnierkiewicz wrote:
> This patch disables deprecated IDE subsystem in assabet_defconfig
> (no IDE host drivers are selected in this config so there is no
> valid reason to enable IDE subsystem itself).
> 
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I think the series makes a lot of sense. I have checked your assertions
in the changelogs and found no flaws in your logic, so I think we should
take them all through arm-soc unless there are other concerns.

Do you have a list of ARM defconfigs that keep using CONFIG_IDE and
how you determined that they need it?

I know that ARCH_RPC/ARCH_ACORN has a couple of special drivers that
have no libata replacement, are there any others like that, or are
they all platforms that should in theory work with libata but need
testing?

	Arnd
