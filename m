From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 13/21] ide: add hwif->chipset fixup to ide_device_add()
Date: Tue, 27 Nov 2007 15:53:22 +0300
Message-ID: <474C1342.2070201@ru.mvista.com>
References: <200711182324.28429.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:41994 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754107AbXK0MxI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Nov 2007 07:53:08 -0500
In-Reply-To: <200711182324.28429.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Add hwif->chipset fixup identical to the one in ideprobe_init()
> to ide_device_add().

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
