From: Tejun Heo <htejun@gmail.com>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Sun, 07 Oct 2007 07:02:25 +0900
Message-ID: <470805F1.6050303@gmail.com>
References: <1190521193410-git-send-email-htejun@gmail.com>	<46F9BF3E.5050708@garzik.org>	<46FA1B4E.8090103@gmail.com>	<46FD079F.3010007@garzik.org>	<46FD0D50.8030602@gmail.com>	<46FD1C4A.8010101@garzik.org>	<46FD306C.3050205@gmail.com>	<46FD5DE1.8000206@rtr.ca> <20070928220309.7c9ed816@the-village.bc.nu> <46FDADD9.9050007@garzik.org> <46FE45CE.1050007@rtr.ca> <4700EA52.10701@garzik.org> <47018CEC.6060203@gmail.com> <47024001.6090306@garzik.org> <47024257.4050606@rtr.ca> <470247E1.2070905@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:60308 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbXJFWCe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Oct 2007 18:02:34 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1097478wah
        for <linux-ide@vger.kernel.org>; Sat, 06 Oct 2007 15:02:34 -0700 (PDT)
In-Reply-To: <470247E1.2070905@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> A few days before that, both PMP and SAS /were/ slated for 2.6.24, and
> after I fix the design problems, they will be again.
> 
> One way or another, upstream will /not/ be doing polling PMP in 2.6.24.

Just an update to let you know that I've been working on it.  sata_sil24
works okay but ahci still craps itself after resetting downstream ports.

Thanks.

-- 
tejun
