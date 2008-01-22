From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 08/16] ide: remove ->nice0 and ->nice2 fields from ide_drive_t
Date: Tue, 22 Jan 2008 17:10:39 +0300
Message-ID: <4795F95F.9020708@ru.mvista.com>
References: <20080121233036.30311.76015.sendpatchset@localhost.localdomain> <20080121233130.30311.83202.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:58434 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751977AbYAVOJs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Jan 2008 09:09:48 -0500
In-Reply-To: <20080121233130.30311.83202.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * ->nice0 and ->nice2 ide_drive_t fields are always zero so remove them.

> * IDE_NICE_0 and IDE_NICE_2 defines from <linux/hdreg.h> are no longer
>   used by any kernel code so cover them with #ifndef/#endif __KERNEL__.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
