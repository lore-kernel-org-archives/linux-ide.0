From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2 3/3] ARM: mvebu: update the SATA compatible string
 for Armada 370/XP
Date: Tue, 14 Jan 2014 15:58:29 +0100
Message-ID: <52D55095.3030305@free-electrons.com>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org> <1389711007-7239-4-git-send-email-simon.guinot@sequanux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:39657 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751672AbaANO6c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jan 2014 09:58:32 -0500
In-Reply-To: <1389711007-7239-4-git-send-email-simon.guinot@sequanux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Guinot <simon.guinot@sequanux.org>, Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, stable@vger.kernel.org, linux-ide@vger.kernel.org, Lior Amsalem <alior@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hi Simon,

On 14/01/2014 15:50, Simon Guinot wrote:
> This patch updates the Armada 370/XP SATA node with the new compatible
> string "marvell,armada-370-xp-sata".

Usually we try to use the name of the first SoC instead of a family name.
So here it should be "marvell,armada-370-sata"

Thanks,

Gregory



> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Lior Amsalem <alior@marvell.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 7f10f627ae5b..b5def2416800 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -152,7 +152,7 @@
>  			};
>  
>  			sata@a0000 {
> -				compatible = "marvell,orion-sata";
> +				compatible = "marvell,armada-370-xp-sata";
>  				reg = <0xa0000 0x5000>;
>  				interrupts = <55>;
>  				clocks = <&gateclk 15>, <&gateclk 30>;
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
