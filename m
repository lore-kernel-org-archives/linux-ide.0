From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH v2] ide: at91_ide.c bugfix for high master clock
Date: Mon, 13 Dec 2010 22:35:49 +0100
Message-ID: <20101213213549.GA2077@r2bh72.net.upc.cz>
References: <1292100326-637-1-git-send-email-plyatov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx4.wp.pl ([212.77.101.8]:59190 "EHLO mx4.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753252Ab0LMVbA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Dec 2010 16:31:00 -0500
Content-Disposition: inline
In-Reply-To: <1292100326-637-1-git-send-email-plyatov@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Igor Plyatov <plyatov@gmail.com>
Cc: sshtylyov@mvista.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, geomatsi@gmail.com, nicolas.ferre@atmel.com, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, christian.glindkamp@taskit.de, ryan@bluewatersys.com, pgsellmann@portner-elektronik.at

On Sat, Dec 11, 2010 at 11:45:26PM +0300, Igor Plyatov wrote:
> The AT91SAM9 microcontrollers with master clock higher then 105 MHz
> and PIO0, have overflow of the NCS_RD_PULSE value in the MSB. This
> lead to "NCS_RD_PULSE" pulse longer then "NRD_CYCLE" pulse and driver
> does not detect IDE device.

The overflow happens because MSB (bit 6) is multiplied by 256.
NCS pulse length = 256*NCS_RD_PULSE[6] + NCS_RD_PULSE[5:0] clock
cycles. So NCS_RD_PULSE 0x41 gives 257 clock cycles not 65 as we
expected before. Static memory controller behaviour is undefined
when pulse length is bigger than cycle length, so things not work.

> +	u16 ncs_rd_pulse;
>  	unsigned long mode = AT91_SMC_READMODE | AT91_SMC_WRITEMODE |
>  			     AT91_SMC_BAT_SELECT;
>  
> @@ -81,19 +84,29 @@ static void set_smc_timings(const u8 chipselect, const u16 cycle,
>  	if (data_float)
>  		mode |= AT91_SMC_TDF_(data_float);
>  
> +	ncs_rd_pulse = cycle;
> +	if (ncs_rd_pulse > NCS_RD_PULSE_LIMIT) {
> +		ncs_rd_pulse = NCS_RD_PULSE_LIMIT;
> +		pr_warn(DRV_NAME ": ncs_rd_pulse limited to maximal value %d\n",
> +			ncs_rd_pulse);
> +	}

I'm fine with that fix. We can possibly still have problems with higher
frequencies, but I'm not sure if someone will use that hardware with 
faster clocks. 

Thanks
Stanislaw
