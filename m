From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [v2 4/4] sata: imx: add ahci sata support on imx platforms
Date: Tue, 2 Jul 2013 02:24:56 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D30C5EF@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1372672975-2997-1-git-send-email-r65037@freescale.com>
 <1372672975-2997-5-git-send-email-r65037@freescale.com>
 <20130701124445.GW516@pengutronix.de>
 <20130701152955.GW13206@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:48977
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751131Ab3GBCZA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Jul 2013 22:25:00 -0400
In-Reply-To: <20130701152955.GW13206@S2101-09.ap.freescale.net>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Zhu <richard.zhuhongxing@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Shawn:
Never mind, I misunderstand what you said.

Now, I know what your are expecting now, would prepare the Version3, and send them later.

Best Regards
Richard Zhu


-----Original Message-----
From: Shawn Guo [mailto:shawn.guo@linaro.org] 
Sent: Monday, July 01, 2013 11:30 PM
To: Sascha Hauer
Cc: Richard Zhu; linux-arm-kernel@lists.infradead.org; jgarzik@pobox.com; avorontsov@ru.mvista.com; rob.herring@calxeda.com; linux-ide@vger.kernel.org; Zhu Richard-R65037
Subject: Re: [v2 4/4] sata: imx: add ahci sata support on imx platforms

On Mon, Jul 01, 2013 at 02:44:45PM +0200, Sascha Hauer wrote:
> On Mon, Jul 01, 2013 at 06:02:55PM +0800, Richard Zhu wrote:
> > imx6q contains one Synopsys AHCI SATA controller, But it can't 
> > shares ahci_platform driver with other controllers.
> > Because there are some misalignments of the bits definitions of the 
> > HBA registers and the Vendor Specific registers
> >  - CAP_SSS(bit20) of the HOST_CAP is writable, default  value is 
> > '0', should be configured to be '1'
> >  - bit0 (only one AHCI SATA port on imx6q) of the  HOST_PORTS_IMPL 
> > should be set to be '1'.(default 0)
> >  - One Vendor Specific register HOST_TIMER1MS(offset:0xe0)  should 
> > be configured regarding to the frequency of AHB  bus clock.
> > 
> > Setup its own ahci sata driver, enable the imx6q ahci sata support, 
> > and update the ahci sata binding document.
> > 
> > Signed-off-by: Richard Zhu <r65037@freescale.com>
> 
> Wait a minute. We suggested to add a i.MX specific ahci driver to put 
> the i.MX speicific setup in there. Now you really post a separate i.MX 
> driver, but instead of putting the setup in there, it's a nearly 
> identical copy of the generic driver *without* the setup and the setup 
> is still in arch/arm/. That doesn't make sense to me.

+1

Richard,

You could have confused by me with pointing you to the sata_highbank driver.  Sorry.  But Sascha posted his work [1] later in the same thread.  That's obviously the way we should go, and I thought you knew you should start your v2 based on that.  You missed that?

Shawn

[1] http://thread.gmane.org/gmane.linux.ide/54410/focus=54434

