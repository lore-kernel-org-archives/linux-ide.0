From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 7/10] ide: add ->chipset field to ide_pci_device_t
Date: Tue, 18 Sep 2007 11:49:09 +0100
Message-ID: <20070918114909.2ca95d16@the-village.bc.nu>
References: <200709112339.34991.bzolnier@gmail.com>
	<46EC1459.8000709@ru.mvista.com>
	<200709171309.30705.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50296 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754650AbXIRKlm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Sep 2007 06:41:42 -0400
In-Reply-To: <200709171309.30705.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

> It seems that ide_cmd646 causes serialization of interfaces in init_irq()...
> Would be great if somebody could comment more on the reasons for ide_cmd646.

No idea but various CMD64x chips had problems cured by serializing stuff
- notably on some HP boxes.

Alan
