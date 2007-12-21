From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 13/63] ide-cd: fix DMA error handling in cdrom_newpc_intr()
Date: Fri, 21 Dec 2007 15:03:37 +0300
Message-ID: <476BAB99.1030606@ru.mvista.com>
References: <200712200202.06988.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:30246 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750736AbXLUMDQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Dec 2007 07:03:16 -0500
In-Reply-To: <200712200202.06988.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Make cdrom_newpc_intr() match cdrom_{read,write}_intr() w.r.t.
> handling DMA errors:

> * disable DMA before cdrom_decode_status() call

> * log the device name and the type of the request (read/write)

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

