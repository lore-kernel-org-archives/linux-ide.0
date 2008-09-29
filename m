From: Robert Krawitz <rlk@alum.mit.edu>
Subject: Re: regarding frequent head unload problem
Date: Mon, 29 Sep 2008 07:44:02 -0400
Message-ID: <200809291144.m8TBi2ml004281@dsl092-065-009.bos1.dsl.speakeasy.net>
References: <48E08B99.1070508@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:38840 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbYI2Lur (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 07:50:47 -0400
In-reply-to: <48E08B99.1070508@kernel.org> (tj@kernel.org)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: contact@i-nz.net, aliencoder@gmail.com, pascal@asmodeus.be, carlos.bessa@gmail.com, andrew.vaselaar@trinity.edu, webmaster@dragontower.de, wolfchri@gmail.com, aklitzing@online.de, aladin7501-01@yahoo.de, linux-ide@vger.kernel.org

   Date: Mon, 29 Sep 2008 17:02:33 +0900
   From: Tejun Heo <tj@kernel.org>

   Hello,

   I'm writing to everyone who reported to me or linux-ide about frequent
   head unload problem and the report is not yet committed to
   storage-fixup.conf.

   I'm a bit worried about the explosion of reports because I really
   wanna avoid creating false entries as they will increase power
   consumption on Linux unnecessarily.  I've just updated the Known
   Issues wiki page.  Here are the update parts.

    Note that modern laptop drives are supposed to unload frequently to
    save power. Unless the unloading is excessive, disabling powersaving
    is not a good idea. It seems that most modern drives are rated for
    600,000 load/unload cycles which translates to about two years of
    uptime at 35 unloads per hour. Even when assuming continuous 12 hours
    of usage everyday, this means the drive will only reach its rated
    load/unload cycle limit after four years and shouldn't be considered
    malfunctioning. Please only report cases where the expected uptime is
    significantly lower than two years.

    ... Also, please include how many times the drive unloads the head
    per-hour under nominal usage without any adjustment.

   Machines currently on the storage.fixup list are (or at least supposed
   to be) the extreme cases where the drive unloads its head multiple
   times per minute decreasing its life expectancy to under a year.
   Please double check your machine falls into this category.

Mine was unloading multiple times per minute.  It had accumulated
70,000 cycles within the first month or two of use.

-- 
Robert Krawitz                                     <rlk@alum.mit.edu>

Tall Clubs International  --  http://www.tall.org/ or 1-888-IM-TALL-2
Member of the League for Programming Freedom -- mail lpf@uunet.uu.net
Project lead for Gutenprint   --    http://gimp-print.sourceforge.net

"Linux doesn't dictate how I work, I dictate how Linux works."
--Eric Crampton
