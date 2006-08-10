From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: /dev/sd*
Date: Thu, 10 Aug 2006 08:19:08 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0608100815450.10926@yvahk01.tjqt.qr>
References: <1155144599.5729.226.camel@localhost.localdomain>
 <20060809212124.GC3691@stusta.de>  <1155160903.5729.263.camel@localhost.localdomain>
  <20060809221857.GG3691@stusta.de> <1155174291.18272.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailer.gwdg.de ([134.76.10.26]:460 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161067AbWHJGVU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Aug 2006 02:21:20 -0400
In-Reply-To: <1155174291.18272.1.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


>> And things become even more confusing considering that the drive might 
>> show up as /dev/sda or /dev/uba depending on the driver used.
>
>Windows people seem to cope ok with C: being IDE and E: being SCSI ;)

You can't compare it like that. Actually, drive letters are more like
bind mounts from "device names" to drive letters. In fact, net drives
are not IDE or SCSI or USB at all, yet they have a drive letter. So the
real CDROM for example is, IIRC, sth. like \\Device\Cdrom0 (it's not a
network path even if it looks like).


Jan Engelhardt
-- 
