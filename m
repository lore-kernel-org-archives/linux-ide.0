From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Tue, 17 Apr 2007 17:15:30 -0300
Message-ID: <20070417201530.GA31265@khazad-dum.debian.net>
References: <461D4E2C.6000704@redhat.com> <20070414105255.GB9157@ucw.cz> <20070415155343.GA12069@khazad-dum.debian.net> <Pine.LNX.4.61.0704152050150.27018@yvahk01.tjqt.qr> <4623F804.3020405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:49414 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161219AbXDQUPg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2007 16:15:36 -0400
Content-Disposition: inline
In-Reply-To: <4623F804.3020405@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Pavel Machek <pavel@ucw.cz>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Mon, 16 Apr 2007, Chuck Ebbert wrote:
> It looks like there are two problems here:
> 
> (1) Some notebooks power off and back on when restarting.

If it happens just under Linux, this is something that really needs to be
addressed post-haste.  Maybe someone should open a bug in bugzilla to help
track it properly?

If it also happens under Windows, you have been sold defective crap that is
being damaged every time you reboot it, get in touch with the manufacturer
and demand a replacement *new* unit with a firmware fix, or your money back.

> (2) Linux (alone) gives a very muted pop on shutdown. This could

Shutdown as in "machine power off", and HDs are under SCSI control (they
appear as scsi devices to userspace, due to libata for example)? Known
issue, see http://bugzilla.kernel.org/show_bug.cgi?id=7838 (actually, IMHO
this fix should have been fast-tracked into 2.6.21, instead of queued for
2.6.22).

Shutdown as in reboot/restart?  New bug that needs to be stomped as soon as
possible, but make sure it is not (1) above.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
