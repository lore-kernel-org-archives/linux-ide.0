From: "Gregor Jasny" <gjasny@googlemail.com>
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
Date: Mon, 30 Oct 2006 14:14:08 +0100
Message-ID: <9d2cd630610300514w355aaf34ue23e4558d713e110@mail.gmail.com>
References: <9d2cd630610291120l3f1b8053i5337cf3a97ba6ff0@mail.gmail.com>
	 <20061030114503.GW4563@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.224]:30638 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964897AbWJ3NOL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Oct 2006 08:14:11 -0500
Received: by hu-out-0506.google.com with SMTP id 28so780866hub
        for <linux-ide@vger.kernel.org>; Mon, 30 Oct 2006 05:14:09 -0800 (PST)
In-Reply-To: <20061030114503.GW4563@kernel.dk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

2006/10/30, Jens Axboe <jens.axboe@oracle.com>:
> Can you confirm that 2.6.18 works?

I've ripped a lot of CDs with this drive and 2.6.18. But I accessed
the drive via the old ide drivers. How Do I enable libata for the PATA
part of my IDE chipset in 2.6.18?

Gregor
