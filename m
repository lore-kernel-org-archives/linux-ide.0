From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/1] ide: ide-generic, add another device exception
Date: Sat, 09 Jun 2007 04:28:58 -0400
Message-ID: <466A64CA.5050908@garzik.org>
References: <20601315171560711667@wsc.cz> <200706081418.56217.bzolnier@gmail.com> <20070608135931.GB24346@havoc.gtf.org> <200706082241.24233.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59500 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417AbXFII3H (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 Jun 2007 04:29:07 -0400
In-Reply-To: <200706082241.24233.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Ingo Korb <ml@akana.de>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> On Friday 08 June 2007, Jeff Garzik wrote:
>> On Fri, Jun 08, 2007 at 02:18:55PM +0200, Bartlomiej Zolnierkiewicz wrote:
>>> On Monday 04 June 2007, Jiri Slaby wrote:
>>>> ide-generic, add another device exception
>>> ide-generic is a generic ISA IDE driver, this one is drivers/ide/pci/generic
>>> (a generic IDE PCI driver) - fixed patch description to avoid confusion.
>>>
>>> [ Yes, both drivers need a rename - patches are welcomed. ]
>> Probably best to do a rename from your side, in git.
> 
> AFAIR git-quiltimport of quilt patches should handle this just fine?

'git mv old_name new_name'


