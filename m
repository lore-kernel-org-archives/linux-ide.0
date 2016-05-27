From: Mason <slash.tmp@free.fr>
Subject: Re: sata_dwc_460ex driver
Date: Fri, 27 May 2016 19:33:05 +0200
Message-ID: <574884D1.9000305@free.fr>
References: <57485F96.8010001@free.fr>
 <CAAd0S9BQoLsz1226seRW697rzNC9=SJDRC=JR2s4242tyg1+4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:7689 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932587AbcE0RdS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 May 2016 13:33:18 -0400
In-Reply-To: <CAAd0S9BQoLsz1226seRW697rzNC9=SJDRC=JR2s4242tyg1+4g@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christian Lamparter <chunkeey@gmail.com>
Cc: Sebastian Frias <sf84@laposte.net>, linux-ide@vger.kernel.org

On 27/05/2016 17:12, Christian Lamparter wrote:

> As far as I know, the ahci dwc core can be supported via the libahci of.
> The binding is already present.
> See http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/ata/ahci-platform.txt
> (snps,dwc-ahci). The SATA_dwc_460ex is not necessary in this case.

Hello Christian,

Thanks for the information.

By the way, I see no difference between using "snps,dwc-ahci"
and "generic-ahci" compatible strings, correct?

Note: I've added linux-ide back to the mix ;-)

Regards.
