From: Jeff Garzik <jeff@garzik.org>
Subject: [ANN] libata "chilled" for 2.6.18
Date: Sun, 11 Jun 2006 10:14:47 -0400
Message-ID: <448C2557.1000403@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33244 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750943AbWFKOOt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jun 2006 10:14:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>


I won't use the word "frozen", so "chilled" is nearer the mark.  I just 
pulled Tejun's hotplug work into libata-dev.git#upstream (and thus 
#ALL).  This should be the last major API/probe-path/etc. disturbance 
until 2.6.18, and so, would be a good testing point.  Regenerate all 
your libata patches that broke :)

After merging some non-Tejun patches -- yes, others, I haven't forgotten 
you -- I'll post a full changelog and a patch that users can easily test.

	Jeff



