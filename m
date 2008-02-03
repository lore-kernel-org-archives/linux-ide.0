From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/5] ide: remove write-only ->sata_misc[] from ide_hwif_t
Date: Sun, 03 Feb 2008 20:07:52 +0300
Message-ID: <47A5F4E8.2000403@ru.mvista.com>
References: <200802020145.40429.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:54918 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756664AbYBCRHA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Feb 2008 12:07:00 -0500
In-Reply-To: <200802020145.40429.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Remove write-only ->sata_misc[] from ide_hwif_t.

> * Remove no longer used SATA_{MISC,PHY,IEN}_OFFSET defines.

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
