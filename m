From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 04/21] ide: move some bits from ide-timing.h to <linux/ide.h>
Date: Fri, 30 May 2008 15:45:34 +0400
Message-ID: <483FE8DE.8070502@ru.mvista.com>
References: <20080528213944.16327.92950.sendpatchset@localhost.localdomain> <20080528214019.16327.16020.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:15992 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755914AbYE3Lpt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 May 2008 07:45:49 -0400
In-Reply-To: <20080528214019.16327.16020.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Move struct ide_timing and IDE_TIMING_* defines to <linux/ide.h>
> from drivers/ide/ide-timing.h.

> While at it:

> - use u8/u16 instead of short for struct ide_timing fields

> - use enum for IDE_TIMING_*

> There should be no functional changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei

