From: Avi Kivity <avi@redhat.com>
Subject: Re: Implementing NVMHCI...
Date: Mon, 13 Apr 2009 14:18:51 +0300
Message-ID: <49E31F9B.3030602@redhat.com>
References: <20090412091228.GA29937@elte.hu> <Pine.LNX.4.62.0904121806060.9521@tamago.serverit.net> <alpine.LFD.2.00.0904120820410.4583@localhost.localdomain> <49E21E8A.2040005@gmail.com> <alpine.LFD.2.00.0904121012500.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:42012 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753832AbZDMLT5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Apr 2009 07:19:57 -0400
In-Reply-To: <alpine.LFD.2.00.0904121012500.4583@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, Szabolcs Szakacsits <szaka@ntfs-3g.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Grant Grundler <grundler@google.com>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>

Linus Torvalds wrote:
> The hardware sector size is very different. If you have a 32kB hardware 
> sector size, that implies that _all_ IO has to be done with that 
> granularity. Now you can no longer treat the eight pages as individual 
> pages - you _have_ to write them out and read them in as one entity. If 
> you dirty one page, you effectively dirty them all. You can not drop and 
> re-allocate pages one at a time any more.
>   

You can still drop clean pages.  Sure, that costs you performance as 
you'll have to do re-read them in order to write a dirty page, but in 
the common case, the clean pages around would still be available and 
you'd avoid it.

Applications that randomly write to large files can be tuned to use the 
disk sector size.  As for the rest, they're either read-only (executable 
mappings) or sequential.

-- 
error compiling committee.c: too many arguments to function

