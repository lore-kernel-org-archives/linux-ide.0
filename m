From: Christopher Chan <cchan@outblaze.com>
Subject: Re: linux 2.6.9 controller order reordered. was: [Re: linux 2.6.9
 still having network code problems]
Date: Wed, 03 Nov 2004 23:51:29 +0800
Message-ID: <4188FE81.1030109@outblaze.com>
References: <418741EB.3080701@outblaze.com>	 <20041102011918.2b453e21.akpm@osdl.org>	 <4187478A.1040002@outblaze.com>	 <20041102014119.1a6096cc.akpm@osdl.org>	 <41874D93.9000008@outblaze.com>	 <20041102020712.18218d47.akpm@osdl.org>	 <418751B3.8090003@outblaze.com>	 <20041102022604.262058c4.akpm@osdl.org>	 <1099413643.24934.1.camel@localhost.localdomain>	 <41888160.5080502@outblaze.com> <58cb370e041103050016acc419@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from corpmail.outblaze.com ([203.86.166.82]:20177 "EHLO
	corpmail.outblaze.com") by vger.kernel.org with ESMTP
	id S261623AbUKCPqo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Nov 2004 10:46:44 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by corpmail.outblaze.com (Postfix) with ESMTP id A050837B89
	for <linux-ide@vger.kernel.org>; Wed,  3 Nov 2004 15:46:38 +0000 (GMT)
Received: from smtp1.hk1.outblaze.com (smtp1.hk1.outblaze.com [203.86.166.80])
	by corpmail.outblaze.com (Postfix) with SMTP id A8F0E16DD8C
	for <linux-ide@vger.kernel.org>; Wed,  3 Nov 2004 15:46:37 +0000 (GMT)
In-Reply-To: <58cb370e041103050016acc419@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Do you have CONFIG_BLK_DEV_OFFBOARD=y in your config?

Yes....
> 
> On Wed, 03 Nov 2004 14:57:36 +0800, Christopher Chan <cchan@outblaze.com> wrote:
> 
>>>What are you on about ? The problem is that in the two traces his
>>>serverworks has moved from ide0 to ide2.
> 
> 

