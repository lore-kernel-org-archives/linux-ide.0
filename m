From: Jeremy Jackson <jerj@coplanar.net>
Subject: Re: 2.4.23 IDE hang on boot with two single-channel controllers
Date: Sat, 31 Jul 2004 11:37:04 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <410BBCA0.5020208@coplanar.net>
References: <401538C6.5030609@coplanar.net> <200402180034.44917.bzolnier@elka.pw.edu.pl> <20040731143700.GC6497@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bob.coplanar.net ([216.16.241.10]:24738 "EHLO bob.coplanar.net")
	by vger.kernel.org with ESMTP id S267956AbUGaPhi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Jul 2004 11:37:38 -0400
In-Reply-To: <20040731143700.GC6497@logos.cnet>
List-Id: linux-ide@vger.kernel.org
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Torben Mathiasen <torben.mathiasen@hp.com>, linux-kernel@vger.kernel.org, linux-ide <linux-ide@vger.kernel.org>

Marcelo Tosatti wrote:
> Hi Bart,
> 
> This triflex fix hasnt been merged in v2.4 mainline, it looks 
> pretty straightforward. And it works for Jeremy.

It works for me, in that I can now boot while docked, and I can use the 
CD-ROM in the base station.  /proc/ide/triflex produces several kB or 
binary garbage, but all other files under /proc/ide show sane output.
It has been running stably with 2.4.23 for several months (since Bart's 
sent the patch).

> Shall we merge this in 2.4.28-pre?
> 
> TIA


-- 
Jeremy Jackson
Coplanar Networks
(519)897-1516
http://www.coplanar.net
