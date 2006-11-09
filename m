From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
Date: Thu, 09 Nov 2006 10:37:21 -0500
Message-ID: <45534B31.50008@cfl.rr.com>
References: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com> <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from iriserv.iradimed.com ([69.44.168.233]:7779 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1424067AbWKIPhQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Nov 2006 10:37:16 -0500
In-Reply-To: <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jano <jasieczek@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Ubuntu uses an initramfs, so unless he has rebuilt his kernel to get 
around that, he should still be using one.

OP, please check dmesg for any new errors after you attempt to mount 
something on hdb.  Also what is the output of a mount command with no 
options?

Jiri Slaby wrote:
> Aah, sorry for the question, you use 2.6.18.1 and there is no such 
> option yet.
> 
> Despite you have ide-generic built-in and other drivers have as a
> module and you don't use initrd. If I was you, I'll try to disable
> ide-generic and choose your ide chipset as built-in in
> ATA/ATAPI/MFM/RLL support under Device drivers.
> 
> regards,

