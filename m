From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/9] via82cxxx: keep local ide_pci_device_t copy
Date: Fri, 16 Nov 2007 19:34:39 +0300
Message-ID: <473DC69F.5060409@ru.mvista.com>
References: <200709242245.17303.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:7032 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751741AbXKPQe1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Nov 2007 11:34:27 -0500
In-Reply-To: <200709242245.17303.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Keep local ide_pci_device_t copy in via_init_one().

> * Adjust ide_pci_device_t copy according to id->driver_data in via_init_one()
>   and remove no longer needed second via82cxxx_chipsets[] entry.

> * via82cxxx_chipsets[] -> via82cxxx_chipset.

> * Remove IDE_HFLAGS_VIA define.

> * Bump driver version.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
