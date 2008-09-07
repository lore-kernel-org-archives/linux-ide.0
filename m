From: "saeed bishara" <saeed.bishara@gmail.com>
Subject: Re: [PATCH] sata_mv: enable active LED blink mode for SoC
Date: Sun, 7 Sep 2008 14:31:07 +0300
Message-ID: <c70ff3ad0809070431x4e6fe7e6r88161d62b5902bae@mail.gmail.com>
References: <12207863853449-git-send-email-saeed@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:44045 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393AbYIGLbI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Sep 2008 07:31:08 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1146182wfd.4
        for <linux-ide@vger.kernel.org>; Sun, 07 Sep 2008 04:31:07 -0700 (PDT)
In-Reply-To: <12207863853449-git-send-email-saeed@marvell.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: linux-ide@vger.kernel.org, linux-arm@vger.kernel.org, jeff@garzik.org, liml@rtr.ca, grundler@google.com, elendil@planet.nl, buytenh@marvell.com, nico@marvell.com, tbm@cyrius.com

> +       SOC_LED_CTRL_ACT_PRESENCE = (1 << 2),   /* Multiplex presence with */
> +                                               /* the active LED */
meanwhile this mode (multiplexing presence with active LED) is not
enabled, but I believe some boards may need it. if your board already
have this mode then it's probably done by HW by multiplexing the two
wires into one LED.

saeed
