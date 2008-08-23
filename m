From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 04/22] ide-floppy: add ide_floppy_set_media_lock() helper
Date: Sat, 23 Aug 2008 15:49:26 +0400
Message-ID: <48AFF946.4010201@ru.mvista.com>
References: <20080810153527.16255.2504.sendpatchset@localhost.localdomain> <20080810153555.16255.42725.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:31361 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752548AbYHWLte (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Aug 2008 07:49:34 -0400
In-Reply-To: <20080810153555.16255.42725.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Add ide_floppy_set_media_lock() helper and convert idefloppy_open(),
> idefloppy_release() and ide_floppy_lockdoor() to use it.
>
> There should be no functional changes caused by this patch.
>
> Cc: Borislav Petkov <petkovbb@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


