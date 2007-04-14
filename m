From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH pata-2.6] cmd64x: procfs code fixes/cleanups (take 2)
Date: Sat, 14 Apr 2007 22:11:11 +0200 (MEST)
Message-ID: <200704142011.l3EKBBhf025590@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:39736 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbXDNULZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Apr 2007 16:11:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, sshtylyov@ru.mvista.com
Cc: linux-ide@vger.kernel.org

On Sat, 14 Apr 2007 23:41:16 +0400, Sergei Shtylyov wrote:
> While at it, also perform the following cleanups:
...
> - correct the chipset names (from CMDxxx to PCI-xxx)

Please explain why this rename is a correction.

Did the company making these chips change name at some point?
Or did they change the names of the chips?

CMD64x is an established name, while PCI-xxx is something
I've never heard of (and it sounds awfully generic).

/Mikael
