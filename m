From: Jan Evert van Grootheest <j.e.van.grootheest@caiway.nl>
Subject: Re: [PATCH ht6560b] Force prefetch for some devices
Date: Mon, 18 Feb 2008 16:21:01 +0100
Message-ID: <47B9A25D.4020107@caiway.nl>
References: <47B97EFA.2040805@caiway.nl> <20080218143636.3394eece@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pelian.kabelfoon.nl ([62.45.45.43]:50465 "EHLO
	pelian.kabelfoon.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728AbYBRPVD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Feb 2008 10:21:03 -0500
In-Reply-To: <20080218143636.3394eece@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Alan,

Alan Cox wrote:
> On Mon, 18 Feb 2008 13:50:02 +0100
> Jan Evert van Grootheest <j.e.van.grootheest@caiway.nl> wrote:
>
>   
>> Prefetch needs to be set for some ide devices to work when connected to
>> a ht6560b interface. This was not always done properly, causing a system
>> with a HD and CD on the primary interface to not work properly. Or, in
>> effect, hang hard.
>>
>> This patch forces prefetch on devices before checking whether it
>> is necessary to change the settings in the interface
>>     
>
> Interesting, that is backwards to the docs and not something I've seen.
>   
Hum, I may have an incorrect understanding of the prefetch bit or 
misread the code.
But for sure that patch makes my 486 boot (HD as primary master and CD 
as primary slave).

 From testing I know that the HD works with and without prefetch (it's 
1.15M/s without prefetch, ~950k/s with). And the boot hangs (as in 
powerbutton required) if prefetch is not set for the CD.
For reference, the generic IDE driver is ~850k/s.
> If you are correct then pata_legacy also wants tweaking .
>
> Alan
>   
I think, but didn't look real good nor test yet, that pata_legacy also 
needs something comparable to select_proc? Or is that implemented in 
some generic manner?
Depending on the day job, I could get to testing that somewhere this week.

-- Jan Evert

