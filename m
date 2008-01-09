From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.24 1/1] sata_sil24: prevent hba lockup when pass-through
 ATA commands are used
Date: Wed, 09 Jan 2008 11:17:17 +0900
Message-ID: <47842EAD.9010302@gmail.com>
References: <e7510f760801010850l11b14086oc80ebe5b1f738eb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:36326 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbYAICRX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 21:17:23 -0500
Received: by wa-out-1112.google.com with SMTP id v27so97848wah.23
        for <linux-ide@vger.kernel.org>; Tue, 08 Jan 2008 18:17:23 -0800 (PST)
In-Reply-To: <e7510f760801010850l11b14086oc80ebe5b1f738eb5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Gwendal Grignou wrote:
> Fix commands timeout with Sil3124/3132 based HBA when pass-through ATA
> commands [where ATA_QCFLAG_RESULT_TF is set] are used while other
> commands are active on other devices
> connected to the same port with a Port Multiplier.
> Due to a hardware bug, these commands must be sent alone, like ATAPI commands.

Thanks a lot.  You forgot S-O-B.

Acked-by: Tejun Heo <htejun@gmail.com>

Jeff, please queue this for 2.6.24.  Gwendal, IIRC you guys use lots of
PMPs on your server farms, right?  How is the current code working
there?  Do you guys see any detection problems?

-- 
tejun
