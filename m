From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/7] ide: don't display "BIOS" settings in ide_setup_dma()
Date: Sun, 09 Mar 2008 23:13:55 +0300
Message-ID: <47D44503.6060006@ru.mvista.com>
References: <200803082229.34542.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:36938 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753291AbYCIUMk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Mar 2008 16:12:40 -0400
In-Reply-To: <200803082229.34542.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Nowadays BIOS info is not very useful and only confuses users since:

> - IDE always tries to use DMA

> - BIOS info may not be accurate with modular IDE/libata

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
