From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: ioctl BLKROSET not working
Date: Wed, 22 Dec 2004 18:30:31 -0500
Message-ID: <87f94c3704122215303c8d9f5c@mail.gmail.com>
Reply-To: Greg Freemyer <greg.freemyer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:61959 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262079AbULVXac (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Dec 2004 18:30:32 -0500
Received: by wproxy.gmail.com with SMTP id 69so42579wri
        for <linux-ide@vger.kernel.org>; Wed, 22 Dec 2004 15:30:31 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, dan mares <dmares@dmares.com>

All,

I would like to use the "hdparm -r 0 /dev/hdc" capability with a
current kernel to make a drive readonly.

I tried it with 2.6.8 and it had no effect with my Adaptec 2-channel
ATA PCI adaptor. (Similar to SIIG).


I looked at hdparm's source and it is calling ioctl with BLKROSET.

I found that in ide.h, but not ide.c  (Not that I would recognise it.)

Should it work? 
Has the functionality been deprecated? 
Is it a driver function or a controller function?

I searched bugzilla (bugme.osdl.org) for "BLKROSET" and found nothing.

Thanks
Greg
-- 
Greg Freemyer
