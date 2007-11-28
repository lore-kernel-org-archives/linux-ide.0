From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/6] ide: always use ide_std_init_ports() in setup-pci.c
Date: Wed, 28 Nov 2007 14:45:13 +0300
Message-ID: <474D54C9.6050606@ru.mvista.com>
References: <200711272357.13594.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:53940 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759654AbXK1LpA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 06:45:00 -0500
In-Reply-To: <200711272357.13594.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * ide_init_hwif_ports() call in setup-pci.c::ide_hwif_configure()
>   doesn't depend on the default cotrol register offset, default IRQ
>   or ppc_ide_md.ide_init_hwif implementations so ide_std_init_ports()
>   can always be used.

> * Since 'base' is always non-zero and thus hwif->io_ports[IDE_DATA_OFFSET]
>   is also non-zero always clear hwif->noprobe.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
