From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 08/22] ide: add ide_queue_pc_tail() helper
Date: Sun, 24 Aug 2008 01:58:28 +0400
Message-ID: <48B08804.7070705@ru.mvista.com>
References: <20080810153527.16255.2504.sendpatchset@localhost.localdomain> <20080810153623.16255.96138.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:35153 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753124AbYHWV6f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Aug 2008 17:58:35 -0400
In-Reply-To: <20080810153623.16255.96138.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Add ide_queue_pc_tail() and convert ide-{floppy,tape}.c to use it
>   instead of ide*_queue_pc_tail().
>
> * Remove no longer used ide*_queue_pc_tail().
>
> There should be no functional changes caused by this patch.
>
> Cc: Borislav Petkov <petkovbb@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


