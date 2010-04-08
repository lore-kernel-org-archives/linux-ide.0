From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT] IDE
Date: Thu, 8 Apr 2010 08:02:45 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1004080800360.3586@i5.linux-foundation.org>
References: <20100408.013628.171442882.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43504 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758728Ab0DHPGS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2010 11:06:18 -0400
In-Reply-To: <20100408.013628.171442882.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org



On Thu, 8 Apr 2010, David Miller wrote:
> 
> 2) taskfile ops with CFQ scheduler bomb because the taskfile
>    code allocates a request then changes it's direction (e.g.
>    READ vs. WRITE) and this makes CFQ explode.  Fix by allocating
>    the correct request type from the beginning.  From Mikulas Patocka.

Hmm. Isn't this -stable material too? At least ide-taskfile.c hasn't 
changed since 2.6.33?

Or is the cfq behavior new, and nobody simply cared before? I looked a bit 
at the cfq changes since 2.6.33, and none of them seemed to be relevant. 
But I didn't look very closely.

Hmm?

		Linus
