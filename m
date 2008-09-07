From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 01/18] ide: add ->read_sff_dma_status method
Date: Sun, 07 Sep 2008 22:49:14 +0400
Message-ID: <48C4222A.6000506@ru.mvista.com>
References: <20080620213323.13202.71450.sendpatchset@localhost.localdomain> <48BE8EFD.70103@ru.mvista.com> <200809032013.08489.bzolnier@gmail.com> <48C41A2E.8040907@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:17987 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754108AbYIGSsg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Sep 2008 14:48:36 -0400
In-Reply-To: <48C41A2E.8040907@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, I wrote:

>    Hm, I guess I'm seeing a real issue

    Nevermind, it's just ide_read_sff_dma_status() used for hwif->tp_ops-> 
read_sff_dma_status() method in the driver where it clearly doesn't make 
sense.  But it seems it never gets called in these cases anyway (only adds a 
confusion :-).

> with this patch...

    Not with this patch actually, with the one that introduced 'struct tp_ops'.

>> Thanks,
>> Bart

MBR, Sergei
