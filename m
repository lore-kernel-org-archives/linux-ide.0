From: Zoltan Boszormenyi <zboszor@freemail.hu>
Subject: Re: [2.6 patch] SCSI_SATA has to be a tristate
Date: Sun, 03 Jul 2005 16:01:07 +0200
Message-ID: <42C7EFA3.8010809@freemail.hu>
References: <42C6C5CE.50203@freemail.hu> <20050702214351.GB5346@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dunaweb1.euroweb.hu ([195.184.0.6]:58763 "EHLO
	szolnok.dunaweb.hu") by vger.kernel.org with ESMTP id S261422AbVGCNmd
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Jul 2005 09:42:33 -0400
In-Reply-To: <20050702214351.GB5346@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Adrian Bunk =EDrta:
> On Sat, Jul 02, 2005 at 06:50:22PM +0200, Zoltan Boszormenyi wrote:
>>*** Warning: "ata_device_add" [drivers/scsi/sata_vsc.ko] undefined!
>>...
>>.config is attached.
>=20
>=20
> Thanks for this report, the fix is below.

Thanks, now sata_via and sata_promise load correctly on my machine.

Best regards,
Zolt=E1n B=F6sz=F6rm=E9nyi
