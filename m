From: rgheck <rgheck@bobjweil.com>
Subject: Re: Problem with ata layer in 2.6.24
Date: Tue, 29 Jan 2008 12:24:25 -0500
Message-ID: <479F6149.4090304@bobjweil.com>
References: <200801272122.21823.gene.heskett@gmail.com>	<1201539043.31293.7.camel@zem>	<1201540830.6526.19.camel@localhost>	<200801281230.32910.gene.heskett@gmail.com>	<alpine.LNX.1.00.0801281248190.13593@iabervon.org>	<479E1D9E.3000900@bobjweil.com>	<20080129121201.2f727f5f@core>	<479F5D29.1020705@bobjweil.com> <20080129171219.53a8efed@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:59009
	"EHLO QMTA04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751881AbYA2RY2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 12:24:28 -0500
In-Reply-To: <20080129171219.53a8efed@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux ide Mailing list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>   
>   
>> Is this >4GB or >=4GB? I've seen contradictory reports, and I've got 4GB.
>>     
>
> Depends how the memory is mapped. Any memory physically above the 4GB
> boundary
>
>   
Don't know. Is there an easy way to find out?

By the way, and on a totally different subject. I wonder if this:
MODULE_DESCRIPTION("low-level driver for AMD PATA IDE");
mightn't be changed to something like:
MODULE_DESCRIPTION("low-level driver for AMD and nVidia PATA IDE");
It took a fair bit if digging in /sys/ to figure out why I was loading 
pata_amd.

Richard

