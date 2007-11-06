From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 10/18] ide: make 'extra' field in struct ide_port_info
 u8
Date: Tue, 06 Nov 2007 14:40:34 +0300
Message-ID: <473052B2.3000800@ru.mvista.com>
References: <200711050025.03967.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:30624 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757465AbXKFLkU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 06:40:20 -0500
In-Reply-To: <200711050025.03967.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> The maximum value used currently for 'extra' field in struct ide_port_info
> is 240.

    It just can't exceed 240 (256 - 16).

> Make 'extra' u8 so it packs nicely together with enablebits[] and 'chipset'
> fields (ide_pci_enablebit_t is 3 bytes and hwif_chipset_t is 1 byte).

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
