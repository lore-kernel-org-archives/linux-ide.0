From: Dan Carpenter <error27@gmail.com>
Subject: potential null deref in ide_port_apply_params()
Date: Sun, 19 Jul 2009 14:44:45 +0300 (EAT)
Message-ID: <alpine.DEB.2.00.0907171311110.12306@bicker>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f184.google.com ([209.85.210.184]:39262 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582AbZGSMm4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Jul 2009 08:42:56 -0400
Received: by yxe14 with SMTP id 14so2909192yxe.33
        for <linux-ide@vger.kernel.org>; Sun, 19 Jul 2009 05:42:56 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Should the "||" in ide_port_for_each_dev() be changed to "&&"?  With the 
current code it looks like "drive" could be null ide_port_apply_params().

#define ide_port_for_each_dev(i, dev, port) \
        for ((i) = 0; ((dev) = (port)->devices[i]) || (i) < MAX_DRIVES; (i)++)

Here is ide_port_apply_params() from drivers/ide/ide.c
   361          ide_port_for_each_dev(i, drive, hwif)
   362                  ide_dev_apply_params(drive, i);

There are a couple similar macros and the callers generally seem to assume 
that drive is non null.

regards,
dan carpenter

