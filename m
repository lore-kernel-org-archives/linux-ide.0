From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 5/5] ARM: defconfig: Enable generic phy in dove and kirkwood.
Date: Wed, 04 Dec 2013 23:03:46 +0300
Message-ID: <529F8AA2.7080507@cogentembedded.com>
References: <1386177364-10164-1-git-send-email-andrew@lunn.ch> <1386177364-10164-6-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:47091 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933089Ab3LDTDp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Dec 2013 14:03:45 -0500
Received: by mail-lb0-f169.google.com with SMTP id y6so9836967lbh.28
        for <linux-ide@vger.kernel.org>; Wed, 04 Dec 2013 11:03:43 -0800 (PST)
In-Reply-To: <1386177364-10164-6-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, kishon@ti.com
Cc: devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>

Hello.

On 12/04/2013 08:16 PM, Andrew Lunn wrote:

> Now that there is a phy driver for sata, enable generic phy in the
> kirkwood and dove defconfig.

    Same comment about missing linux-arm-kernel in the CC -- this is not a 
libata patch but ARM one.

> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

WBR, Sergei

