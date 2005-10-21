From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Merging ATA passthru
Date: Fri, 21 Oct 2005 16:04:24 -0400
Message-ID: <435949C8.1030603@pobox.com>
References: <43593E0A.4070801@pobox.com> <1129924714.2786.38.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:36023 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965157AbVJUUE1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2005 16:04:27 -0400
In-Reply-To: <1129924714.2786.38.camel@laptopd505.fenrus.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Arjan van de Ven wrote:
> On Fri, 2005-10-21 at 15:14 -0400, Jeff Garzik wrote:
> 
>>Folks,
>>
>>Taking Mark Lord's (and others) criticism to heart, I'm going to merge 
>>the ATA passthru work upstream, once 2.6.14 is released.
>>
>>Since there are still some reported problems that I haven't had time to 
>>track down, I'm going to -- like ATAPI -- introduce a module option that 
>>enables passthru.  It will default to off.
>>
>>Other features that follow a similar pattern -- 98% there but needs a 
>>few final tweaks -- will be treated in the same way.
> 
> 
> can you get a patch into -mm that default-on's them? That way the brave
> of heart get it automatic while those who play safe get them
> default-off. Expands your testingbase as well ;)

It currently defaults to on in -mm.  I'll make sure that doesn't change...

	Jeff



