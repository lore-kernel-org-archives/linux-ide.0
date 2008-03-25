From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/8] ide: remove IDE_HFLAG_NO_AUTOTUNE host flag
Date: Tue, 25 Mar 2008 19:49:18 +0300
Message-ID: <47E92D0E.6040901@ru.mvista.com>
References: <20080322220623.17636.44337.sendpatchset@localhost.localdomain> <20080322220639.17636.80893.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:46210 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752170AbYCYQry (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 12:47:54 -0400
In-Reply-To: <20080322220639.17636.80893.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Don't set IDE_HFLAG_NO_AUTOTUNE host flag in sgiioc4 and icside
>   host drivers - there is no need for it as they don't implement
>   ->set_pio_mode method.

> * Remove no longer needed IDE_HFLAG_NO_AUTOTUNE host flag.

> There should be no functional changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
