From: Richard Zhu <richard.zhu@linaro.org>
Subject: Re: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53
	platforms
Date: Wed, 31 Aug 2011 10:08:22 +0800
Message-ID: <CAJNCFV+XFGEba1J2dXDa4YVwqduAPV5y=5JYEXAZ0uv+S60vvw@mail.gmail.com>
References: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
	<CAODfWeEm8bkySXxb1qopbH1VMu-V+33k5x+0+qjABzesT0amOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAODfWeEm8bkySXxb1qopbH1VMu-V+33k5x+0+qjABzesT0amOA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hector Oron <hector.oron@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>
Cc: eric@eukrea.com, eric.miao@linaro.org, linux-ide@vger.kernel.org, kernel@pengutronix.de, avorontsov@ru.mvista.com, jgarzik@pobox.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hi Wolfram:
Thanks for your suggestions.
Accepted.

Hi Hector:
Thanks for your help to tests these patches.

Best Regards
Richard Zhu

On 30 August 2011 18:43, Hector Oron <hector.oron@gmail.com> wrote:
> Hello,
>
> 2011/8/30 Richard Zhu <richard.zhu@linaro.org>:
>> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
>> ---
>> =A0arch/arm/mach-mx5/clock-mx51-mx53.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 19 =
++++
>> =A0arch/arm/mach-mx5/devices-imx53.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A04 +
>> =A0arch/arm/plat-mxc/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A01 +
>> =A0arch/arm/plat-mxc/ahci_sata.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0104 +++++++++++++++++++++++
>> =A0arch/arm/plat-mxc/devices/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A04 +
>> =A0arch/arm/plat-mxc/devices/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A01 +
>> =A0arch/arm/plat-mxc/devices/platform-ahci-imx.c =A0 | =A0 66 ++++++++++=
++++
>> =A0arch/arm/plat-mxc/include/mach/ahci_sata.h =A0 =A0 =A0| =A0 33 +++++++
>> =A0arch/arm/plat-mxc/include/mach/devices-common.h | =A0 10 ++
>> =A09 files changed, 242 insertions(+), 0 deletions(-)
>> =A0create mode 100644 arch/arm/plat-mxc/ahci_sata.c
>> =A0create mode 100644 arch/arm/plat-mxc/devices/platform-ahci-imx.c
>> =A0create mode 100644 arch/arm/plat-mxc/include/mach/ahci_sata.h
>
> The good news are that I have tested this patch series on i.MX53 LOCO
> board and it seems to work fine here. Thanks.
>
>
> Tested-By: Hector Oron Martinez <hector.oron@gmail.com>
>
> --
> =A0H=E9ctor Or=F3n =A0-.. . -... .. .- -. =A0 -.. . ...- . .-.. --- .--. =
. .-.
>
