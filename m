From: GrantC <grant_nospam@dodo.com.au>
Subject: Solved: was Re: IDE channels not independent in PIIX4E?
Date: Mon, 28 Feb 2005 17:25:32 +1100
Message-ID: <8e3521tlk6q49848ed3ur869eqdqa5s92e@4ax.com>
References: <07s221pobdf00ogs0cgbg0u2dl6prs4096@4ax.com> <Pine.LNX.4.44.0502271102410.15651-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:36019 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261563AbVB1GZn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Feb 2005 01:25:43 -0500
In-Reply-To: <Pine.LNX.4.44.0502271102410.15651-100000@coffee.psychology.mcmaster.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-ide@vger.kernel.org

Recently, Mark Hahn wrote:

>getting 25 MB/s out of older-generation udma33 controllers isn't bad;
>I don't remember ever getting better than about 28 out of 33, regardless
>of which chipset/memory/cpu.
...
Thanks Mark.

Using gcc-2.95.3 instead of gcc-3.3.4 cut kernel compile time 
for 'time make clean bzImage' from 26 to 16 minutes, everything 
else the same -- slackware-10.1 install with gcc-2.95.3 from 
slackware-8.1.  

I knew I lost that ten minutes somewhere last year, just found 
it by circumnavigating other possibilities :o)

Cheers,
Grant.

