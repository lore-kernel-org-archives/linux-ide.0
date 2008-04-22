From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [2.6 patch] select ATA_SFF
Date: Tue, 22 Apr 2008 22:54:21 +0400
Message-ID: <480E345D.9090406@ru.mvista.com>
References: <20080421213147.GH2633@cs181133002.pp.htv.fi> <480DE3C4.5@ru.mvista.com> <480DE6F5.8060403@gmail.com> <480DE9E8.2070809@ru.mvista.com> <480DEB1F.5060500@gmail.com> <480DF7B7.9030000@rtr.ca> <480DF876.7070800@gmail.com> <480DF9BD.1080104@rtr.ca> <480DFE76.8000809@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:34179 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1765323AbYDVSy7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Apr 2008 14:54:59 -0400
In-Reply-To: <480DFE76.8000809@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello, I wrote:

>> I suppose.   If we were needlessly pedantic, then perhaps
>> the libata-bmdma.c should be renamed to libata-sff.c,

    It *was* renamed to libata-sff.c, back in 2006. :-)

>> and the libata-sff.c should be renamed libata-tf.c

    Not before splitting SFF-8038i stuff from it.

>> But there's probably been a document or two since then,
>> where the SFF folks have documented the TF interfaces, too.

>    Don't know, at least I haven't encountered such spec. Unless you mean 
> SFF-8020i (ATAPI CD-ROM spec).

    I've looked thru the list of their spec. and it didn't seem to have any 
about taskfile specifically. SFF-8070 (ATAPI CD-RW) refers to ATA/PI-4 for 
that matter.

MBR, Sergei

