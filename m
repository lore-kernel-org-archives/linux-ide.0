From: Tejun Heo <tj@kernel.org>
Subject: Re: libata problems
Date: Fri, 01 Aug 2008 17:48:45 +0900
Message-ID: <4892CDED.6080302@kernel.org>
References: <4880BDCD.4030104@gavsworld.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55899 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120AbYHAItN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Aug 2008 04:49:13 -0400
In-Reply-To: <4880BDCD.4030104@gavsworld.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gavin Cameron <gavin@gavsworld.net>
Cc: linux-ide@vger.kernel.org

Hello, Gavin.

Gavin Cameron wrote:
> I was hunting for a solution to my problem in the "known issues" section
> of the Wiki - my problem being fully described here:
> http://forums.fedoraforum.org/forum/showthread.php?t=192186
>
> Would you be able to shed any light on this problem? Do you require any
> other information from me?
>

It's usually best to describe in the mail again as people (I :-) tend
not to follow link to other forums.  So, ATAPI PIO is timing out.  I
thought we had most of these problems ironed out by now.  Can you please
try 2.6.26 and post full kernel boot log and if it too fails the error
messages?

> Anyway, as a side issue, I read the first problem about frequent head
> unloads and noticed it as another problem I have. So, as requested,
> attached are the outputs of "dmidecode" and "hdparm"
> 
> This is definitelly happening on my PC called "picard" and occasionally
> happens on "kirk" and I'm not sure which drive(s) in "picard" so I've
> attached both.

I don't think it would happen on a custom made PC.  Can you please post
the result of "smartctl -a"?

-- 
tejun
