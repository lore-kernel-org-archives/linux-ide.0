From: "Janos Haar" <djani22@netcenter.hu>
Subject: random reboot problem.
Date: Fri, 2 Jun 2006 10:24:09 +0200
Message-ID: <017101c6861d$ef4f19f0$1800a8c0@dcccs>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.dynamicweb.hu ([195.228.155.139]:26011 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751320AbWFBIYe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Jun 2006 04:24:34 -0400
Received: from dcccs (53d8296a.adsl.enternet.hu [83.216.41.106])
	by dynamicweb.hu (8.13.5/8.12.8) with SMTP id k528KpmA002441
	for <linux-ide@vger.kernel.org>; Fri, 2 Jun 2006 10:20:52 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello, list,

I have a random reboot problem, and  i have a  suspicion, there is a bug in
libata somewhere.

I use 4 disk node, each node have 12x300GB Maxtor hdd. (4xIDE + 4xSATA).
All my 48 disk reports clean smart.

But 2 of my node randomly reboots, and have a context to disk usage.
(Network, and all others are checked.)

The entire hw are replaced, and known to be good, except the 4 group of
hdds.

How can i help to debug / check this?

The netconsole, and remote log did not helps.

Cheers,
Janos

