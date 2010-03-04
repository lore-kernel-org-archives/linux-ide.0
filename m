From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH v2 0/2] ahci: Add support for non-PCI devices
Date: Thu, 4 Mar 2010 20:05:25 +0300
Message-ID: <20100304170525.GA8126@oksana.dev.rtsoft.ru>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:37783 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756569Ab0CDRF1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Mar 2010 12:05:27 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Mark Lord <kernel@teksavvy.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all,

Thanks for the feedback on the previous patches!

Here comes v2:

- Patches 1-8 dropped as they are in libata-dev.git;
- Patches 'ahci: Move generic code into libahci' and
  'ahci: Export generic AHCI symbols' were merged into one.
- We no longer touch Kconfig when not needed.
- libahci.h renamed to ahci.h.
- Some cosmetic fixes.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
