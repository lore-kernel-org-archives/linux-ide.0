From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: How do I try libata with a PATA PCI controller?
Date: Mon, 17 Jan 2005 13:51:15 -0500
Message-ID: <87f94c37050117105176054565@mail.gmail.com>
Reply-To: Greg Freemyer <greg.freemyer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:58495 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262588AbVAQSvP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Jan 2005 13:51:15 -0500
Received: by wproxy.gmail.com with SMTP id 67so944326wri
        for <linux-ide@vger.kernel.org>; Mon, 17 Jan 2005 10:51:15 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE Linux <linux-ide@vger.kernel.org>

I have several Adaptec PATA PCI controllers.  (They use SIG
chips/firmware/driver).

Is there a way to use/test them with libata?

In general, should I expect better or worse performance for simple
commands like "dd if=/dev/zero of=/dev/hdc bs=50k"

I am building a dedicated disk cleaner and will be running a lot of
dd's in parrellel.  ie. I can currently do 8 with all drives set to
Master.

Thanks
Greg
-- 
Greg Freemyer
