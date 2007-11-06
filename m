From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 11/18] pdc202xx_new: move PIO programming code to pdcnew_set_pio_mode()
Date: Tue, 06 Nov 2007 18:13:35 +0300
Message-ID: <4730849F.4050901@ru.mvista.com>
References: <200711050025.47116.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:32133 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755506AbXKFPNW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 10:13:22 -0500
In-Reply-To: <200711050025.47116.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Move PIO programming code from pdcnew_set_mode() to pdcnew_set_pio_mode().

> * Rename pdcnew_set_mode() to pdcnew_set_dma_mode().

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
