From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] IDE: Don't powerdown Compaq Triflex IDE device on suspend
Date: Mon, 16 May 2011 13:25:50 +0400
Message-ID: <4DD0ED9E.2050902@ru.mvista.com>
References: <alpine.DEB.2.00.1105152228530.12411@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35171 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100Ab1EPJ1f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 May 2011 05:27:35 -0400
Received: by ewy4 with SMTP id 4so1189120ewy.19
        for <linux-ide@vger.kernel.org>; Mon, 16 May 2011 02:27:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1105152228530.12411@artax.karlin.mff.cuni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: "David S. Miller" <davem@davemloft.net>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello.

On 16-05-2011 0:32, Mikulas Patocka wrote:

> Don't powerdown Compaq Triflex IDE device on suspend

> This fixes APM suspend on Compaq Armada 7400.
> APM BIOS doesn't suspend if IDE is powered down when suspending.
> The Triflex controller is found only on old Compaq boards,
> so this patch will hopefully have no side effects.

> This patch fixes a suspend regression introduced in
> feb22b7f8e62b1b987a3a1dbad95af767a1df832

    Please also specify that commit's summary in parens -- for the human 
readers. Commit ID is only immediately usable to gitweb.

> Signed-off-by: Mikulas Patocka<mikulas@artax.karlin.mff.cuni.cz>

WBR, Sergei
