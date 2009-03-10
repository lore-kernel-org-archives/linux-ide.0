From: Frans Pop <elendil@planet.nl>
Subject: Re: [RFC][PATCH] sata-mv: add module parameter msq_blink_led to enable quirk for SOC
Date: Tue, 10 Mar 2009 18:09:43 +0100
Message-ID: <200903101809.45770.elendil@planet.nl>
References: <200808261124.39282.elendil@planet.nl> <200903101236.30216.elendil@planet.nl> <49B6820C.1010206@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpm-eml102.kpnxchange.com ([195.121.3.6]:50682 "EHLO
	CPSMTPM-EML102.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755863AbZCJRJt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Mar 2009 13:09:49 -0400
In-Reply-To: <49B6820C.1010206@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>, Martin Michlmayr <tbm@cyrius.com>

On Tuesday 10 March 2009, Mark Lord wrote:
> Frans Pop wrote:
> > For some Marvell chips the HDD led does not blink when there is disk
> > I/O if NCQ is enabled. Only enable the quirk that works around this
> > (by enabling blink mode for the led) if parameter msq_blink_led is
> > set as it is not clear whether this is a general erratum or related
> > to the type of hard disk connected to the controller.
>
> ...
> +/* msq_blink_led only has effect for SOC */
> +module_param(msq_blink_led, int, 0444);
> +MODULE_PARM_DESC(msq_blink_led,
> +	"Use blink mode quirk for HDD led when MSQ is enabled (0=off,
> 1=on)"); ...
>
> Well, I don't understand the parameter name (msq??),

Brainfart: contamination from msi and phonetically ncq and msq are 
somewhat similar :-/
Will fix for next version.

> and I'm not sure if we need a parameter or not.

I don't either. But given the uncertainty surrounding this it seemed like 
as useful feature. I'll leave it as a separate patch so it can either be 
omitted or more easily reverted later.

> Saeed said the original patch should apply "for all devices besides
> to the SOC", which I think means all GenIIe chip variants.
>
> So if you want to rework the first patch so that the blink fix
> works for all GEN_IIE chips, then I'll test it here with a few
> different drives from different vendors and see how the LEDs behave.
> I also have boards from several different vendors to try it on.

Cool. Will do. I'm going to assume I can use the same code to actually 
enable the blink mode.
For the testing at least the parameter will be useful.

> I'd also like to investigate whether the same fix is necessary
> for GEN_II chips as well as GEN_IIE.  Perhaps Saeed might provide
> further information there, but we shouldn't hold our breaths waiting.

OK. I'll implement it as an op so it can be extended as needed.

Thanks,
FJP
