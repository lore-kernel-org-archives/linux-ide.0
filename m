From: kiu <kiu@gmx.net>
Subject: kernel history of ide performance
Date: Tue, 05 Apr 2005 10:46:37 +0200
Message-ID: <1112690797.4252506dd574e@kiun.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:53432 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S261615AbVDEIqp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Apr 2005 04:46:45 -0400
Received: from unknown (HELO blacksheep.qnet) (675341@[217.86.55.180])
          (envelope-sender <kiu@gmx.net>)
          by smtprelay01.ispgateway.de (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <linux-ide@vger.kernel.org>; 5 Apr 2005 08:46:40 -0000
Received: from localhost ([127.0.0.1])
	by blacksheep.qnet with esmtp (Exim 4.50)
	id 1DIjhm-0001tJ-47
	for linux-ide@vger.kernel.org; Tue, 05 Apr 2005 10:46:38 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi ide team,

i often heard "uh, since kernel 2.6.bla the ide perfomance is soo bad".
Because of that (and the joy of writing bash scripts noone else will understand
*g*) i wrote an automated test script to get comparable measurements.

The script compiles 2.6.0-2.6.11.6 (yes "" | make oldconfig), boots each kernel,
runs hdparm/bonnie++ and create some pngs with gnuplot.

I ran the script on a Intel 82371AB/EB/MB PIIX4/PIICeleron 333/IC35L040AVER07
machine and you can find the results here:

    http://www.kiu.weite-welt.com/misc/idetest

I am quite busy at the moment and hopefully have time next month to clean up the
scripts for a release (are you interested?) and do further testing...
-- 
kiu


