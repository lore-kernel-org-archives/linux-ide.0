From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [v3 3/3] sata: imx: add ahci sata support on imx platforms
Date: Mon, 22 Jul 2013 07:02:56 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D3441A3@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1373017942-12583-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373017942-12583-4-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130705174305.GA28088@mtj.dyndns.org>
 <0E83723C55F66F43A6041464FE31119D31432D@039-SN2MPN1-012.039d.mgd.msft.net>
 <20130706020737.GA9029@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:31969 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755101Ab3GVHDD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Jul 2013 03:03:03 -0400
In-Reply-To: <20130706020737.GA9029@mtj.dyndns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Richard Zhu <richard.zhuhongxing@gmail.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Tejun:
Re-send this email to you and community.
I'm afraid that you may be missed or don't receive it.

BTW, can you help to pick up the #2 and #3(reviewed and acked by Shawn) of the v7 patch-set of this serial?
Thanks in advance.

2013/7/10 HongXing Zhu <richard.zhuhongxing@gmail.com>

    Hi Tejun:
    There are some differences between generic AHCI controller and imx AHCI controller.

    The bits definitions of the HBA registers, the Vendor
    Specific registers, and the AHCI PHY clock, and the PHY signal adjustment window.

     - CAP_SSS(bit20) of the HOST_CAP is writable, default
     value is '0', should be configured to be '1'
     - bit0 (only one AHCI SATA port on imx6q) of the
     HOST_PORTS_IMPL should be set to be '1'.(default 0)
     - One Vendor Specific register HOST_TIMER1MS(offset:0xe0)
     should be configured regarding to the frequency of AHB
     bus clock.
     - Configurations of the AHCI PHY clock, and the signal
     parameters of the GPR13

    I'm afraid that the generic ahci_platform driver is not a good place to contain
    imx6q ahci specific differences.
    As I know that, the AHCI sata on imx53 doesn't have the PHY signal parameters
    adjustment window, but the AHCI sata on imx6q does has one.

    On imx6q, the standard .port_ops = &ahci_platform_ops, is used, but
    .port_ops       = &ahci_platform_retry_srst_ops, would be required by imx53 AHCI controller.

    We can put all the imx AHCI(imx6q, imx53) specific difference into the sata_imx driver,
    and keep ahci_platform as clean as possible, if the separate sata_imx driver can be created.

    How do you think about that?

    BTW, the version4 patch-set would be sent out  a moment later, any suggests and comments are appreciated.

    Best Regards.


    2013/7/6 Tejun Heo <tj@kernel.org>

        Hello,

        On Sat, Jul 06, 2013 at 02:03:30AM +0000, Zhu Richard-R65037 wrote:
        > [Richard] Just like what we dicussed in the previous v1/v2
        > patch-set.  Shawn has the concerns that the IP speicific codes
        > shouldn't be put in the platform level.  So he suggested that setup
        > a stand-alone driver, contained the imx6q ahci sata specific codes,
        > and re-use the generic ahci_platform driver as much as possible.
        > This imx6q standalone ahci sata driver just registers the platform
        > data, and the others would be handled by ahci_platform driver.

        Oh, I'm not objecting to the ahci specific part not being in platform
        code.  I'm wondering whether specific handling for imx6q can be
        included into ahci_platform rather than being in its own driver.  It
        just seems that there aren't too many differences.  I could be
        misreading it so if there are enough differences to warrant a separate
        driver, please enlighten me.

        Thanks!

        --
        tejun

Best Regards
Richard Zhu


-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] On Behalf Of Tejun Heo
Sent: Saturday, July 06, 2013 10:08 AM
To: Zhu Richard-R65037
Cc: Richard Zhu; shawn.guo@linaro.org; linux-arm-kernel@lists.infradead.org; jgarzik@pobox.com; avorontsov@ru.mvista.com; rob.herring@calxeda.com; s.hauer@pengutronix.de; linux-ide@vger.kernel.org
Subject: Re: [v3 3/3] sata: imx: add ahci sata support on imx platforms

Hello,

On Sat, Jul 06, 2013 at 02:03:30AM +0000, Zhu Richard-R65037 wrote:
> [Richard] Just like what we dicussed in the previous v1/v2 patch-set.  
> Shawn has the concerns that the IP speicific codes shouldn't be put in 
> the platform level.  So he suggested that setup a stand-alone driver, 
> contained the imx6q ahci sata specific codes, and re-use the generic 
> ahci_platform driver as much as possible.
> This imx6q standalone ahci sata driver just registers the platform 
> data, and the others would be handled by ahci_platform driver.

Oh, I'm not objecting to the ahci specific part not being in platform code.  I'm wondering whether specific handling for imx6q can be included into ahci_platform rather than being in its own driver.  It just seems that there aren't too many differences.  I could be misreading it so if there are enough differences to warrant a separate driver, please enlighten me.

Thanks!

--
tejun


