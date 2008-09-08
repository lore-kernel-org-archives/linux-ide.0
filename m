From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH] sata_mv: enable active LED blink mode for SoC
Date: Mon, 8 Sep 2008 02:32:22 +0200
Message-ID: <200809080232.23834.elendil@planet.nl>
References: <12207863853449-git-send-email-saeed@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml17.kpnxchange.com ([213.75.38.117]:43193 "EHLO
	hpsmtp-eml17.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751208AbYIHAc0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Sep 2008 20:32:26 -0400
In-Reply-To: <12207863853449-git-send-email-saeed@marvell.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: linux-ide@vger.kernel.org, linux-arm@vger.kernel.org, jeff@garzik.org, liml@rtr.ca, grundler@google.com, buytenh@marvell.com, nico@marvell.com, tbm@cyrius.com

Hello Saeed,

On Sunday 07 September 2008, Saeed Bishara wrote:
> Enabling blink mode makes the SATA active LED more human visible.

The patch does make the led responsive, but it does *not* restore it to 
the old behavior.

With the 2.6.25 kernel (and also during early boot of the device) the
HDD led flashes with an intensity that reflects the amount of disk 
activity (possibly the amount of data transferred), very similar to the 
LAN led.
The flashing was subtle, but very well visible both with low and with high 
disk activity.

With 2.6.26.3 without this patch there is no flashing visible at all.

With this patch applied to 2.6.26.3 I only get a very slow and steady 
blinking of the HDD led. A very regular, almost lazy on/off.
The flashing is related to disk activity in that the led stays on when 
there is no activity, but any relationship to the *intensity* of the disk 
activity is lost.

So, IMO it is an improvement, but it is definitely not a fix for the 
regression.

Cheers,
FJP
