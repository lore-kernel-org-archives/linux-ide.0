From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: libata equivalent for hdX=remap63
Date: Sun, 02 Sep 2007 14:26:29 +0600
Message-ID: <46DA73B5.5010107@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay4.usu.ru ([194.226.235.39]:52375 "EHLO relay4.usu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886AbXIBIas (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Sep 2007 04:30:48 -0400
Received: from relay4.usu.ru (localhost [127.0.0.1])
	by relay4.usu.ru (PostSystem) with ESMTP id 9914517EBE
	for <linux-ide@vger.kernel.org>; Sun,  2 Sep 2007 14:28:09 +0600 (YEKST)
Received: from usu2.usu.ru (usu2.usu.ru [194.226.237.16])
	by relay4.usu.ru (PostSystem) with ESMTP id 3A4DB17EBE
	for <linux-ide@vger.kernel.org>; Sun,  2 Sep 2007 14:28:09 +0600 (YEKST)
Received: from usu2.usu.ru (localhost.usu2.usu.ru [127.0.0.1])
	by usu2.usu.ru (Postfix) with ESMTP id E59A7A7ECB
	for <linux-ide@vger.kernel.org>; Sun,  2 Sep 2007 14:25:32 +0600 (YEKST)
Received: from ums.usu.ru (ums.usu.ru [194.226.236.116])
	by usu2.usu.ru (Postfix) with ESMTP id 743FEA7ECA
	for <linux-ide@vger.kernel.org>; Sun,  2 Sep 2007 14:25:32 +0600 (YEKST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

sorry if this is a FAQ, but googling for "libata remap63" gives nothing 
useful.

Some old computers need software like "Ontrack Disk Manager" in order to 
see large disks in the other OS. The way to deal with such setup in 
Linux was to add "hdX=remap63" to the kernel arguments. However, I 
cannot find the equivalent of this option in the new libata-based 
drivers. Could you please show how to migrate such systems to libata 
without removing the disk manager?

-- 
Alexander E. Patrakov
(not subscribed to linux-ide, please CC: on replies)
