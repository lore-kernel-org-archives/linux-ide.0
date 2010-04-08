From: David Miller <davem@davemloft.net>
Subject: Re: [GIT] IDE
Date: Thu, 08 Apr 2010 11:15:42 -0700 (PDT)
Message-ID: <20100408.111542.185885813.davem@davemloft.net>
References: <20100408.013628.171442882.davem@davemloft.net>
	<alpine.LFD.2.00.1004080800360.3586@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60500
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758895Ab0DHSPk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2010 14:15:40 -0400
In-Reply-To: <alpine.LFD.2.00.1004080800360.3586@i5.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Apr 2010 08:02:45 -0700 (PDT)

> 
> 
> On Thu, 8 Apr 2010, David Miller wrote:
>> 
>> 2) taskfile ops with CFQ scheduler bomb because the taskfile
>>    code allocates a request then changes it's direction (e.g.
>>    READ vs. WRITE) and this makes CFQ explode.  Fix by allocating
>>    the correct request type from the beginning.  From Mikulas Patocka.
> 
> Hmm. Isn't this -stable material too? At least ide-taskfile.c hasn't 
> changed since 2.6.33?

Absolutely and it's in my queue of things to send to Greg KH and
co. once you suck this in.
