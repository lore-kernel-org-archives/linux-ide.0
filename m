From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 17/21] ide: drop 'initializing' argument from ide_register_hw()
Date: Thu, 13 Dec 2007 19:07:15 +0300
Message-ID: <476158B3.3010706@ru.mvista.com>
References: <200711182331.23988.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:30441 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753007AbXLMQG5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Dec 2007 11:06:57 -0500
In-Reply-To: <200711182331.23988.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>

Bartlomiej Zolnierkiewicz wrote:

> * Rename init_hwif_data() to ide_init_port_data() and export it.

> * For all users of ide_register_hw() with 'initializing' argument set
>   hwif->present and hwif->hold are always zero so convert these host
>   drivers to use ide_find_port()+ide_init_port_data()+ide_init_port_hw()
>   instead (also no need for init_hwif_default() call since the setup
>   done by it gets over-ridden by ide_init_port_data() call).

> * Drop 'initializing' argument from ide_register_hw().

> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Roman Zippel <zippel@linux-m68k.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

