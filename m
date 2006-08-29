From: Eric Windisch <eric@grokthis.net>
Subject: Re: Libata-tj-stable patch /w sil3124 and PMP...
	'device	or	resource busy'
Date: Tue, 29 Aug 2006 11:15:01 -0400
Message-ID: <1156864501.3718.46.camel@manet>
References: <44E105A7.3030900@grokthis.net> <44E1C43E.1020302@gmail.com>
	 <44E28313.7050601@grokthis.net>  <44F16750.5080100@gmail.com>
	 <1156727790.28709.1.camel@lennon>  <44F3ACAB.5070506@gmail.com>
	 <1156863511.3718.36.camel@manet>  <44F455C2.1010309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from marley.grokthis.net ([69.93.78.26]:39335 "EHLO
	marley.grokthis.net") by vger.kernel.org with ESMTP id S965026AbWH2PIR
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Aug 2006 11:08:17 -0400
In-Reply-To: <44F455C2.1010309@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

> > I've never used it either, at least not directly.  Whatever it is doing
> > is automatic.  However, you're right, I'm sorry for bringing up someone
> > else's bug -- if nothing else, its good google fodder ;-)  So far, its
> > looking to me like a bug in Ubuntu Dapper.
> 
> Maybe you're supposed to use all disks via dm, which actually makes 
> sense.  Direct partitions on disks are pretty lame way to manage disks 
> these days although I've never used anything else.  :-p

I thought about this, but I couldn't intuitively figure out how.  I'm
not sure that whatever Ubuntu is doing is being done correctly.  I'll
have to read up on it, deal with manually removing these
devices-mappings, or switch to another distribution.  Thanks again!

-- 
Eric Windisch <eric@grokthis.net>
GrokThis.net

