From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3] [POWERPC] MPC8349E-mITX: introduce localbus and pata
 nodes
Date: Tue, 27 Nov 2007 18:49:13 +0300
Message-ID: <474C3C79.5060908@ru.mvista.com>
References: <20071127153708.GA12490@localhost.localdomain> <20071127153940.GC14183@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:43576 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751204AbXK0PtA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Nov 2007 10:49:00 -0500
In-Reply-To: <20071127153940.GC14183@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

Hello.

Anton Vorontsov wrote:

> This patch adds localbus and pata nodes to use CF IDE interface
> on MPC8349E-mITX boards.

> Patch also adds code to probe localbus.

> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/boot/dts/mpc8349emitx.dts    |   17 ++++++++++++++++-
>  arch/powerpc/platforms/83xx/mpc834x_itx.c |   17 +++++++++++++++++
>  2 files changed, 33 insertions(+), 1 deletions(-)

> diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
> index 5072f6d..7a97068 100644
> --- a/arch/powerpc/boot/dts/mpc8349emitx.dts
> +++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
> @@ -249,6 +249,21 @@
>  		device_type = "pci";
>  	};
>  
> +	localbus@e0005000 {
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		compatible = "fsl,mpc8349emitx-localbus",

    Board compatible bus?

> +			     "fsl,mpc8349e-localbus",
> +			     "fsl,pq2pro-localbus";
> +		reg = <e0005000 d8>;
> +		ranges = <3 0 f0000000 210>;
>  
> -
> +		pata@3,0 {
> +			compatible = "fsl,mpc8349emitx-pata", "pata-platform";
> +			reg = <3 0 10 3 20c 4>;
> +			ioport-shift = <1>;

    Bleh... that shift again. And this is surely not a good name for a 
property (where's I/O ports in your case?) -- why not call it "reg-shift" 
(well, I'd call it "reg-size" or "reg-stride" myself :-)?

MBR, Sergei
