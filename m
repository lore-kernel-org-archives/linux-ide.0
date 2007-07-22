From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/11] ide: ide_config_drive_speed() bugfixes
Date: Sun, 22 Jul 2007 22:33:05 +0400
Message-ID: <46A3A2E1.2020500@ru.mvista.com>
References: <200707222030.42305.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:59819 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757716AbXGVSbG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jul 2007 14:31:06 -0400
In-Reply-To: <200707222030.42305.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kou Ishizaki <kou.ishizaki@toshiba.co.jp>, Akira Gouache <akira2.iguchi@toshiba.co.jp>

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Use ->OUTBSYNC instead of ->OUTB when writing command register
>   (needed for scc_pata and pmac host drivers).

> * Don't check DRDY bit of the status register on ATAPI devices
>   (ATAPI devices are free to ignore DRDY bit).

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
