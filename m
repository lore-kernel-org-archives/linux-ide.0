From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: remove dead <asm-arm/arch-sa1100/ide.h>
Date: Tue, 14 Oct 2008 22:53:56 +0400
Message-ID: <48F4EAC4.4000702@ru.mvista.com>
References: <200808101745.20434.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:3349 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751859AbYJNSyM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Oct 2008 14:54:12 -0400
In-Reply-To: <200808101745.20434.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

Hello.

Bartlomiej Zolnierkiewicz wrote:

> It has been dead for more than 3 years and needs to be converted
> to use platform PATA support anyway.

    This patch in the current pata-2.6 series does not apply at all.

> Cc: Russell King <rmk@arm.linux.org.uk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applying patch ide-remove-dead-asm-arm-arch-sa1100-ide-h.patch
The text leading up to this was:
--------------------------
|From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
|Subject: [PATCH] ide: remove dead <asm-arm/arch-sa1100/ide.h>
|
|It has been dead for more than 3 years and needs to be converted
|to use platform PATA support anyway.
|
|Cc: Russell King <rmk@arm.linux.org.uk>
|Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
|---
| include/asm-arm/arch-sa1100/ide.h |   75 --------------------------------------
| 1 file changed, 75 deletions(-)
|
|Index: b/include/asm-arm/arch-sa1100/ide.h
|===================================================================
|--- a/include/asm-arm/arch-sa1100/ide.h
|+++ /dev/null
--------------------------
No file to patch.  Skipping patch.
1 out of 1 hunk ignored

MBR, Sergei
