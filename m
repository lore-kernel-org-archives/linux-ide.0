From: Mark Lord <liml@rtr.ca>
Subject: Re: [RFC][PATCH] sata-mv: add module parameter msq_blink_led to enable
 quirk for SOC
Date: Tue, 10 Mar 2009 11:06:52 -0400
Message-ID: <49B6820C.1010206@rtr.ca>
References: <200808261124.39282.elendil@planet.nl> <497B2C60.60608@rtr.ca> <200902240933.45874.elendil@planet.nl> <200903101236.30216.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:57383 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755195AbZCJPG4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Mar 2009 11:06:56 -0400
In-Reply-To: <200903101236.30216.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>, Martin Michlmayr <tbm@cyrius.com>

Frans Pop wrote:
> For some Marvell chips the HDD led does not blink when there is disk
> I/O if NCQ is enabled. Only enable the quirk that works around this
> (by enabling blink mode for the led) if parameter msq_blink_led is
> set as it is not clear whether this is a general erratum or related
> to the type of hard disk connected to the controller.
...
+/* msq_blink_led only has effect for SOC */
+module_param(msq_blink_led, int, 0444);
+MODULE_PARM_DESC(msq_blink_led,
+	"Use blink mode quirk for HDD led when MSQ is enabled (0=off, 1=on)");
...

Well, I don't understand the parameter name (msq??),
and I'm not sure if we need a parameter or not.

Saeed said the original patch should apply "for all devices besides
to the SOC", which I think means all GenIIe chip variants.

So if you want to rework the first patch so that the blink fix
works for all GEN_IIE chips, then I'll test it here with a few
different drives from different vendors and see how the LEDs behave.
I also have boards from several different vendors to try it on.

I'd also like to investigate whether the same fix is necessary
for GEN_II chips as well as GEN_IIE.  Perhaps Saeed might provide
further information there, but we shouldn't hold our breaths waiting. :)

Cheers

