From: Andrei Martynov <andrei.martynov@web.de>
Subject: IN_BYTE and OUT_BYTE replacement
Date: Thu, 9 Jul 2009 14:28:30 +0200
Message-ID: <327262546.20090709142830@web.de>
Reply-To: Andrei Martynov <andrei.martynov@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:50315 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756240AbZGIM2i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jul 2009 08:28:38 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 3CAA0103D7199
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2009 14:28:37 +0200 (CEST)
Received: from [80.66.20.180] (helo=PDBAMXP)
	by smtp07.web.de with asmtp (WEB.DE 4.110 #277)
	id 1MOsjt-000408-00
	for linux-ide@vger.kernel.org; Thu, 09 Jul 2009 14:28:37 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

there were specific i/o macros IN_BYTE and OUT_BYTE in 2.4 kernel to
access IDE registers, but seems they are gone in 2.6 kernel and
replaced by ioread8 / iowrite8 that are used everywhere and not in
libata only. In my case original code for 2.4 kernel wrote specific
value to undocumented chipset register on *every* r/w access to *any*
IDE register.

#define OUT_BYTE(b,p) { outb(b,p); outb(255, JASPER_IDE_BASE + 0xe0); }
static inline byte jasper_ide_in_byte(int p)
{
        byte b;
        b = (byte)inb(p);
        outb(255, JASPER_IDE_BASE + 0xe0);
        return b;
}
#define IN_BYTE(p) jasper_ide_in_byte(p)

Is there any way to reproduce this behavior in libata other than
redefining ioread8/iowrite8?

-- 
Best regards,
 Andrei                          mailto:andrei.martynov@web.de

