From: Aaron Gyes <floam@sh.nu>
Subject: ATAPI works on via_sata, but only sort of.
Date: Sat, 28 Jan 2006 20:07:47 -0800
Message-ID: <1138507667.9669.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.mcdownloads.com ([216.239.132.98]:59578 "EHLO
	mail.3gstech.com") by vger.kernel.org with ESMTP id S1750799AbWA2EHw
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Jan 2006 23:07:52 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.3gstech.com (Postfix) with ESMTP id AC96784DC7A
	for <linux-ide@vger.kernel.org>; Sat, 28 Jan 2006 20:07:51 -0800 (PST)
Received: from mail.3gstech.com ([216.239.132.98])
 by localhost (fungus [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 32585-03 for <linux-ide@vger.kernel.org>;
 Sat, 28 Jan 2006 20:07:51 -0800 (PST)
Received: from [192.168.1.103] (c-24-20-99-84.hsd1.wa.comcast.net [24.20.99.84])
	by mail.3gstech.com (Postfix) with ESMTP id 478A784DC77
	for <linux-ide@vger.kernel.org>; Sat, 28 Jan 2006 20:07:51 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I recently tried out 2.6.16-rc1-mm3 to see if my Plextor PX716-SA would
magically come to life, it did. It had previously not worked in 2.6.15
with the correct parameters being passed to libata. I can seem to read
CDs okay, however every single attempt at burning a CD thus far has
resulted in either a CD that doesn't work or a CD with CRC errors. Is
this expected/known? Can I do anything to fix it or help diagnose the
problem further?

My motherboard is a Asus A8V, VIA K8T800Pro.

Aaron Gyes

