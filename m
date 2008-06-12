From: Tejun Heo <htejun@gmail.com>
Subject: Re: macbook pro dvd playback after suspend Buffer I/O error
Date: Thu, 12 Jun 2008 15:26:52 +0900
Message-ID: <4850C1AC.4090809@gmail.com>
References: <dd18b0c30804032207u36bd1f43l358e9949f0c94f79@mail.gmail.com>	 <dd18b0c30806110045s6d19a034yd89b892441bd1621@mail.gmail.com>	 <dd18b0c30806111131gc1b506cva12f577ebb4afdf9@mail.gmail.com>	 <485048EC.2080608@gmail.com>	 <dd18b0c30806111527x22fa895em230ceade4712f073@mail.gmail.com>	 <4850794F.3000200@gmail.com>	 <dd18b0c30806111910j4b127c32rbd546f885731e18c@mail.gmail.com>	 <dd18b0c30806111913gf505c05j479a6a682c2cdd28@mail.gmail.com>	 <4850A2F8.3050404@gmail.com>	 <dd18b0c30806112222k60e411dfs98e4cc7f64938b5b@mail.gmail.com> <dd18b0c30806112315x70dee219oa6738de3e22d4939@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:10491 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbYFLG07 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jun 2008 02:26:59 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2794214waf.23
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 23:26:59 -0700 (PDT)
In-Reply-To: <dd18b0c30806112315x70dee219oa6738de3e22d4939@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Mattock <justinmattock@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Justin Mattock wrote:
> O.K. applied the patch and did what you have described,(except for
> sysctl -w / ended up inserting dev.scsi.logging_level=1 in
> /etc/sysctl.conf)
> This is what dd reported:(same as before)
> dd: reading `/dev/sr0':Input/output error
> 41+1 records in
> 41+1 records out
> 43122688 bytes (43 MB) copied, 41.0967 seconds, 1.0 MB/s
> 
> Attached is dmesg of using dd on the first suspend, and playing a dvd
> on the second.

Ah.. okay.  The drive was becoming ready and the read commands were
retried too fast.  The drive I tested on was fast enough to deliver the
data but yours wasn't.  Hmmm.... This is difficult.  This also poses
problems to live cd distros, I think.  We probably need to make sr wait
for device readiness.  Maybe it's best to put TUR waiting in read error
handling.  I'll think about it.

Thanks.

-- 
tejun
