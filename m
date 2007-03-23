From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: HPA patches
Date: Fri, 23 Mar 2007 18:47:26 -0400
Message-ID: <460458FE.4010704@redhat.com>
References: <20070323191321.5d00887a@lxorguk.ukuu.org.uk>	<20070323112411.f6a8a762.randy.dunlap@oracle.com>	<20070323200819.4e734f4f@lxorguk.ukuu.org.uk>	<20070323130315.7ed48121.randy.dunlap@oracle.com> <20070323214704.1e8d5463@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:47115 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992599AbXCWWre (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Mar 2007 18:47:34 -0400
In-Reply-To: <20070323214704.1e8d5463@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kyle@canonical.com

Alan Cox wrote:
>>>> What is 0x40?  can it be #defined (or enum-ed) instead of a magic
>>>> value?  please?  (more of same below)
>>> It's 0x40. Its a "command dependant bit" - no useful name.
>> dependent.  OK, thanks.
> 
> IDE is a bit like that. I'm amazed some of the command flags arent in
> latin.
> 

Hmm, what's latin for "no useful name?" You could call it that.

