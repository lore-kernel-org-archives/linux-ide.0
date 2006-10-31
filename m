From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: sata_via and VT6421 PATA support?
Date: Tue, 31 Oct 2006 11:45:58 +0100
Message-ID: <45472966.80209@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:41899 "EHLO
	mail2.syneticon.net") by vger.kernel.org with ESMTP
	id S1423096AbWJaKqd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Oct 2006 05:46:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail2.syneticon.net (Postfix) with ESMTP id 3120F4D50D
	for <linux-ide@vger.kernel.org>; Tue, 31 Oct 2006 11:46:30 +0100 (CET)
Received: from mail2.syneticon.net ([127.0.0.1])
 by localhost (linux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31111-15 for <linux-ide@vger.kernel.org>;
 Tue, 31 Oct 2006 11:46:02 +0100 (CET)
Received: from postfix1.syneticon.net (postfix1.syneticon.net [192.168.112.6])
	by mail2.syneticon.net (Postfix) with ESMTP
	for <linux-ide@vger.kernel.org>; Tue, 31 Oct 2006 11:46:02 +0100 (CET)
Received: from localhost (filter1.syneticon.net [192.168.113.3])
	by postfix1.syneticon.net (Postfix) with ESMTP id 491B394EF
	for <linux-ide@vger.kernel.org>; Tue, 31 Oct 2006 11:46:02 +0100 (CET)
Received: from postfix1.syneticon.net ([192.168.113.4])
	by localhost (192.168.113.3 [192.168.113.3]) (amavisd-new, port 10025)
	with ESMTP id it+xt7bplTSk for <linux-ide@vger.kernel.org>;
	Tue, 31 Oct 2006 11:45:59 +0100 (CET)
Received: from [192.168.10.145] (xdsl-81-173-189-226.netcologne.de [81.173.189.226])
	by postfix1.syneticon.net (Postfix) with ESMTP
	for <linux-ide@vger.kernel.org>; Tue, 31 Oct 2006 11:45:59 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Almost a year ago, Jeff Garzik posted a patch from VIA which adds 
support for PATA in VT6421 (sata_via driver):

http://lkml.org/lkml/2005/12/11/203

There was a very brief discussion about it, but nothing more.


There were some major changes between 2.6.17 and 2.6.18:

-#define DRV_VERSION    "1.1"
+#define DRV_VERSION    "2.0"


and VIA's patch no longer applies (however, it looks it shouldn't be 
that hard to correct it).


What's the status of sata_via and VT6421 PATA support?


-- 
Tomasz Chmielewski
http://wpkg.org
