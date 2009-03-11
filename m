From: Frans Pop <elendil@planet.nl>
Subject: [PATCH,v2][0/2] sata_mv: harddisk activity led no longer responsive on QNAP TS-109
Date: Wed, 11 Mar 2009 08:13:23 +0100
Message-ID: <200903110813.25650.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpm-eml105.kpnxchange.com ([195.121.3.9]:64117 "EHLO
	CPSMTPM-EML105.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751956AbZCKHN3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Mar 2009 03:13:29 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm@vger.kernel.org
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

On Tuesday 10 March 2009, Mark Lord wrote:
> So if you want to rework the first patch so that the blink fix
> works for all GEN_IIE chips, then I'll test it here with a few
> different drives from different vendors and see how the LEDs behave.

Here's version 2 of the patches.

Changes:
- make the quirk valid for all GenIIe chips and not only for SoC
- use a flag to indicate a particular chip needs the quirk
- use a hardware op to enable/disable blink mode

Open issues:
- as I've worked without any specs and only have SoC to test on, please
  check that mv_iie_enable_led_blink is correct for all GenIIe chips
- if mv_iie_enable_led_blink is also valid for GenII chips, the
  first patch can be simplified a bit (no need for mv6xxx_iie_ops)

To test:
* load module with ncq_blink_led=0 (default)
  - check if NCQ is enabled (/sys/block/sda/device/queue_depth > 1)
    if not -> chip does not support NCQ and is thus not affected?
  - cause some disk activity; if led stays on without blinking, the
    chip needs the quirk
  - disable NCQ (echo 1 >/sys/block/sda/device/queue_depth)
  - cause some disk activity; led blinking should be very responsive
    (pre-2.6.26 behavior on my QNAP TS-109)
* load module with ncq_blink_led=1
  - check if NCQ is enabled (/sys/block/sda/device/queue_depth > 1)
  - cause some disk activity; led should now blink in a lazy frequency
    (quirk enabled)
  - disable NCQ (echo 1 >/sys/block/sda/device/queue_depth)
  - cause some disk activity; led blinking should be very responsive
    again (pre-2.6.26 behavior)
  - re-enable NCQ (echo 31 >/sys/block/sda/device/queue_depth)
  - cause some disk activity; led blinking should be lazy again

Cheers,
FJP
