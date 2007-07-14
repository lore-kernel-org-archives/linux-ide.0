From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] sc1200: remove redundant warning message from sc1200_tune_chipset()
Date: Sat, 14 Jul 2007 20:38:05 +0400
Message-ID: <4698FBED.7060008@ru.mvista.com>
References: <200707132310.50310.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:50476 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755016AbXGNQgA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Jul 2007 12:36:00 -0400
In-Reply-To: <200707132310.50310.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> ide_config_drive_speed() called by sc1200_set_xfer_mode() already gives
> a meaningful warning message in case of failure.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

