From: Li Yang-R58472 <r58472@freescale.com>
Subject: RE: [PATCH V2 RESEND] fsl-sata: I/O load balancing
Date: Fri, 17 Feb 2012 03:09:54 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F0574273C@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1329284944-17943-1-git-send-email-qiang.liu@freescale.com>
 <1329439216.2892.36.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:50092
	"EHLO DB3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751484Ab2BQDKR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Feb 2012 22:10:17 -0500
In-Reply-To: <1329439216.2892.36.camel@pasglop>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Liu Qiang-B32616 <B32616@freescale.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

>I tried a debian install on the p5020ds here and I find SATA to be
>extremely slow, generating millions of interrupts. I think the defaults
>should be a lot more aggressive at coalescing.

The P5020 has a hardware problem with SATA, making it generate more interrupts than it should.  A new revision of the silicon will fix it.

- Leo

