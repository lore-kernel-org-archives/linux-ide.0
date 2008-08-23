From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 13/22] ide: add ide_do_test_unit_ready() helper
Date: Sun, 24 Aug 2008 01:31:00 +0400
Message-ID: <48B08194.5030403@ru.mvista.com>
References: <20080810153527.16255.2504.sendpatchset@localhost.localdomain> <20080810153700.16255.79527.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:34985 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752301AbYHWVbH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Aug 2008 17:31:07 -0400
In-Reply-To: <20080810153700.16255.79527.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Add ide_do_test_unit_ready() helper and convert ide-{floppy,tape}.c
>   to use it.
>
> * Remove no longer used idetape_create_test_unit_ready_cmd().
>
> There should be no functional changes caused by this patch.
>
> Cc: Borislav Petkov <petkovbb@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


