From: David Miller <davem@davemloft.net>
Subject: [GIT]: IDE
Date: Thu, 29 Oct 2009 07:36:57 -0700 (PDT)
Message-ID: <20091029.073657.161810259.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49596
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753813AbZJ2Oge (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Oct 2009 10:36:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Just once bug fix from Mikulas Patocka, need to add back serialization
flag to some CMD64X chip variants.

Please pull, thanks a lot!

The following changes since commit 964fe080d94db82a3268443e9b9ece4c60246414:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../rusty/linux-2.6-for-linus

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/ide-2.6.git master

Mikulas Patocka (1):
      ide: Serialize CMD643 and CMD646 to fix a hardware bug with SSD

 drivers/ide/cmd64x.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)
