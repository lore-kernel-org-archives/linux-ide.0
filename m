From: Rolf Offermanns <roffermanns@sysgo.com>
Subject: spin down external ide drive (attached via usb)
Date: Fri, 04 Mar 2005 19:13:18 +0100
Message-ID: <4228A53E.3050801@sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from mail.sysgo.com ([62.8.134.5]:43216 "EHLO mail.sysgo.com")
	by vger.kernel.org with ESMTP id S262956AbVCDSMZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2005 13:12:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 769FEFB887
	for <linux-ide@vger.kernel.org>; Fri,  4 Mar 2005 19:06:28 +0100 (CET)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id 51754FB887
	for <linux-ide@vger.kernel.org>; Fri,  4 Mar 2005 19:06:28 +0100 (CET)
Received: from [172.22.10.10] (rof.sysgo.com [172.22.10.10])
	by donald.sysgo.com (Postfix) with ESMTP id A7E6C11E59B
	for <linux-ide@vger.kernel.org>; Fri,  4 Mar 2005 20:12:22 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi!
Is there a way to spin down an ide drive which is attached via USB?
hdparm does not work, neither do the scsi-idle tools in Debian...

Any help is appreciated.

-Rolf

