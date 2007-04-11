From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Wed, 11 Apr 2007 23:49:36 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0704112347230.20436@yvahk01.tjqt.qr>
References: <461D4E2C.6000704@redhat.com> <Pine.LNX.4.61.0704112315480.20436@yvahk01.tjqt.qr>
 <461D54AF.3060706@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tmailer.gwdg.de ([134.76.10.23]:56821 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161224AbXDKVvP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Apr 2007 17:51:15 -0400
In-Reply-To: <461D54AF.3060706@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org


On Apr 11 2007 17:35, Chuck Ebbert wrote:
>Jan Engelhardt wrote:
>> On Apr 11 2007 17:07, Chuck Ebbert wrote:
>>> When I reboot my notebook, it powers off and powers back on.
>>> On poweroff a loud snapping noise seems to be coming from the
>>> hard drive. Today I noticed there is no "shutdown: hda" on
>>> the console when I reboot. Whne I do a normal poweroff the
>>> message is displayed and there is no noise. Should the IDE
>>> code be changed so it always shuts down the drive?
>> 
>> What sort of notebook? What sort of harddisk?
>
>Compaq Presario V2000 series, with a new Seagate ST9120821A
>120GB 5400RPM drive.

I specifically hoped you might have a TOSHIBA MK2003GAH,
which does a hard unload when left idle for too long.

Only on reboots huh?

What happens if you reboot another OS, freebsd f.ex.? (You can try that off
CD1)

Jan
-- 
