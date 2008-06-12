From: Tejun Heo <htejun@gmail.com>
Subject: Re: macbook pro dvd playback after suspend Buffer I/O error
Date: Thu, 12 Jun 2008 10:18:07 +0900
Message-ID: <4850794F.3000200@gmail.com>
References: <dd18b0c30804032207u36bd1f43l358e9949f0c94f79@mail.gmail.com>	 <20080404012147.abf8a598.akpm@linux-foundation.org>	 <484F31B8.8030001@gmail.com>	 <dd18b0c30806110045s6d19a034yd89b892441bd1621@mail.gmail.com>	 <dd18b0c30806111131gc1b506cva12f577ebb4afdf9@mail.gmail.com>	 <485048EC.2080608@gmail.com> <dd18b0c30806111527x22fa895em230ceade4712f073@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:41178 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbYFLBSN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jun 2008 21:18:13 -0400
Received: by ti-out-0910.google.com with SMTP id b6so889140tic.23
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 18:18:12 -0700 (PDT)
In-Reply-To: <dd18b0c30806111527x22fa895em230ceade4712f073@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Mattock <justinmattock@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Justin Mattock wrote:
> O.K. attached is dmesg of playing a dvd, then suspending and wakingup,
> as well as starting after the buffer error.(audit messages)
> This is interesting, even  pausing the dvd before suspending, causes
> the same error.
> I sent a post to mplayer-users to see if there is a way to have
> mplayer pause and wait for the disk drive to align, but am still
> waiting
> for a response.

Can you please do the followings?

1. dd if=/dev/sr0 of=/dev/null bs=1M
2. suspend / resume
3. see whether dd fails and post the resulting dmesg.

Thanks.

-- 
tejun
