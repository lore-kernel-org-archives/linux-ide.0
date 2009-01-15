From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libata: implement and use HORKAGE_NOSETXFER
Date: Thu, 15 Jan 2009 19:06:29 +0900
Message-ID: <496F0AA5.1000908@kernel.org>
References: <20090107141536.231980@gmx.net>	<20090107142351.79749c05@lxorguk.ukuu.org.uk>	<496ECE36.6010706@kernel.org> <20090115094500.18d60455@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45116 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755643AbZAOKGp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Jan 2009 05:06:45 -0500
In-Reply-To: <20090115094500.18d60455@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Moritz Rigler <moritz1234567@gmx.de>, linux-ide@vger.kernel.org

Alan Cox wrote:
>>> Yes - I'd like it to just work, but I'd like it to just work without
>>> breaking anything else, without adding device specific special cases and
>>> ideally in a way that makes other stuff that is similarly odd just work
>>> too.
>> Then, how do you suggest proceeding on it?  Without a bus tracer, we
>> can't easily tell what Windows is doing and on native SATA skipping
>> SETXFER isn't likely to cause any serious problem.  It's basically
>> noop.
> 
> I would suggest we issue the SETXFER always. If it times out then we will
> revalidate the identify data so we can use that to see what mode we are
> actually in.

Hmmm... our current timeout for SETXFER is 5s, so it wouldn't be nice
but not too bad either.  Alright, I'll brew up something.

-- 
tejun
