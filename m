From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
Date: Tue, 08 May 2007 16:52:52 +0200
Message-ID: <46408EC4.9080904@gmail.com>
References: <46362672.7080103@gmx.net>	<4636DCA9.9050803@gmail.com>	<4636FBB7.3030605@gmx.net>	<463AE631.9030701@gmail.com>	<463B7903.4070206@gmx.net>	<463EE239.8060709@gmail.com>	<463F634E.2070103@gmx.net>	<46408C4B.8020401@gmail.com> <20070508155119.4207bbc6@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:28981 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968055AbXEHOxD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 10:53:03 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1748854wxd
        for <linux-ide@vger.kernel.org>; Tue, 08 May 2007 07:53:02 -0700 (PDT)
In-Reply-To: <20070508155119.4207bbc6@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel Beichl <daniel_beichl@gmx.net>, linux-ide@vger.kernel.org

Alan Cox wrote:
>>> A thing that crossed my mind was a timing issue. Perhaps the dmaing of <
>>> 60 bytes is that
>>> fast that the interrupt that causes it is not yet handled correctly. But
>>> this is just a very wild guess.
>> I don't think that can happen.  Controllers are required to queue
>> interrupt till FIFO is flushed.  Can you post dmesg after such errors?
> 
> Random finger in the air guess - the FIFO on the SIL DMA engine is 64
> bytes long ? Perhaps this is something Jeff can query with his contacts
> at Silicon Image ?

That sounds plausible.  I have pretty good relationship with SIMG.  I'll
ask them.

Thanks.

-- 
tejun
