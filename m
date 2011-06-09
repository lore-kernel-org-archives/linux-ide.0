From: Tejun Heo <tj@kernel.org>
Subject: Re: WRITE DMA EXT failures with JM20330 based sata2ide
Date: Thu, 9 Jun 2011 16:31:12 +0200
Message-ID: <BANLkTimuGOGxJgKJsxUc6ACzEcZwgQuTWw@mail.gmail.com>
References: <isj7ql$4fh$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61455 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab1FIObO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jun 2011 10:31:14 -0400
Received: by qyg14 with SMTP id 14so857798qyg.19
        for <linux-ide@vger.kernel.org>; Thu, 09 Jun 2011 07:31:13 -0700 (PDT)
In-Reply-To: <isj7ql$4fh$1@dough.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Cc: linux-ide@vger.kernel.org

Hello,

On Mon, Jun 6, 2011 at 8:51 PM, Manuel Reimer
<Manuel.Spam@nurfuerspam.de> wrote:
> I've converted a 1,5TB SATA drive to IDE to run it on a UDMA100 IDE
> controller.

Hmmm...

> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata2.00: failed command: WRITE DMA EXT
> ata2.00: cmd 35/00:00:30:07:8a/00:04:57:00:00/e0 tag 0 dma 524288 out
> =A0 =A0 =A0 =A0 res 40/00:ff:00:00:00/00:00:00:00:00/40 Emask 0x4 (ti=
meout)
> ata2.00: status: { DRDY }

Looks like genuine transmission problems.  Lengthening timeout won't
help anything.  It will just make it take longer to fail.

> What I definetly need is some workaround to stop the kernel from spee=
ding
> down until UDMA/25 is reached. This speed is totally unacceptable for=
 such a
> big drive... :-(

Currently, there's no way to disable automatic speed down without
patching the code and given that the mechanism works well for many
cases, I'm somewhat reluctant to introduce changes / switch solely for
this case.  You're having a genuine transmission problem and I think
fixing the underlying hardware issue would be the better choice than
mucking with EH behaviors.

Thank you.

--=20
tejun
