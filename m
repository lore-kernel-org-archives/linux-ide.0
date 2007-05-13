From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: [1/2] 2.6.22-rc1: known regressions
Date: Sun, 13 May 2007 20:14:45 +0200
Message-ID: <46475595.4050105@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:63242 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757489AbXEMSPQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 May 2007 14:15:16 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1189216uga
        for <linux-ide@vger.kernel.org>; Sun, 13 May 2007 11:15:15 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Antonino Ingargiola <tritemio@gmail.com>, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-fsdevel@vger.kernel.org, xfs-masters@oss.sgi.com, Jeremy Fitzhardinge <jeremy@goop.org>, David Chinner <dgc@sgi.com>, Charles Gagalac <charle97@yahoo.com>, Davide Libenzi <davidel@xmailserver.org>

Hi all,

Here is a list of some known regressions in 2.6.22-rc.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions

(http://bugzilla.kernel.org/ is not available, information are not up-to-date)

I2C

Subject    : "Sensors Applet" give an error message "No chip detected"
References : http://lkml.org/lkml/2007/5/13/109
Submitter  : Antonino Ingargiola <tritemio@gmail.com>
Status     : Unknown



SATA/PATA

Subject    : libata crash on halt
References : http://marc.info/?l=linux-ide&m=117899827710565&w=2
Submitter  : Andrew Morton <akpm@linux-foundation.org>
Caused-By  : Tejun Heo <htejun@gmail.com>
             commit 920a4b1038e442700a1cfac77ea7e20bd615a2c3
Status     : problem is being debugged

Subject    : libata reset-seq merge broke sata_sil on sh
References : http://lkml.org/lkml/2007/5/10/63
Submitter  : Paul Mundt <lethal@linux-sh.org>
Handled-By : Tejun Heo <htejun@gmail.com>
Caused-By  : commit 4750def52cb2c21732dda9aa1d43a07db37b0186
Status     : problem is being debugged



File systems

Subject    : applications under wine freezes
References : http://bugzilla.kernel.org/show_bug.cgi?id=8462
Submitter  : Charles Gagalac <charle97@yahoo.com>
Caused-By  : Davide Libenzi <davidel@xmailserver.org>
             commit 6192bd536f96c6a0d969081bc71ae24f9319bfdc
Handled-By : Davide Libenzi <davidel@xmailserver.org>
Status     : problem is being debugged

Subject    : 2.6.21-git10/11: files getting truncated on xfs
References : http://lkml.org/lkml/2007/5/9/410
Submitter  : Jeremy Fitzhardinge <jeremy@goop.org>
Handled-By : David Chinner <dgc@sgi.com>
Patch      : http://lkml.org/lkml/2007/5/12/93
Status     : patch was suggested



Regards,
Michal

-- 
Michal K. K. Piotrowski
Kernel Monkeys
(http://kernel.wikidot.com/start)
