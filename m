From: Tejun Heo <htejun@gmail.com>
Subject: Re: macbook pro dvd playback after suspend Buffer I/O error
Date: Thu, 12 Jun 2008 06:51:40 +0900
Message-ID: <485048EC.2080608@gmail.com>
References: <dd18b0c30804032207u36bd1f43l358e9949f0c94f79@mail.gmail.com>	 <20080404012147.abf8a598.akpm@linux-foundation.org>	 <484F31B8.8030001@gmail.com>	 <dd18b0c30806110045s6d19a034yd89b892441bd1621@mail.gmail.com> <dd18b0c30806111131gc1b506cva12f577ebb4afdf9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:17850 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbYFKVvs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jun 2008 17:51:48 -0400
Received: by ti-out-0910.google.com with SMTP id b6so871606tic.23
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 14:51:46 -0700 (PDT)
In-Reply-To: <dd18b0c30806111131gc1b506cva12f577ebb4afdf9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Mattock <justinmattock@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Justin Mattock wrote:
> O.K. I applied the patch here is what I'm seeing:
> 
> [  920.237141] end_request: I/O error, dev sr0, sector 2931560
> [  920.237141] Buffer I/O error on device sr0, logical block 366445
> [  920.237141] Buffer I/O error on device sr0, logical block 366446
> [  920.237141] Buffer I/O error on device sr0, logical block 366447
> [  920.237141] Buffer I/O error on device sr0, logical block 366448
> [  920.237141] Buffer I/O error on device sr0, logical block 366449
> [  920.237141] Buffer I/O error on device sr0, logical block 366450
> [  920.237141] Buffer I/O error on device sr0, logical block 366451
> [  920.237141] Buffer I/O error on device sr0, logical block 366452
> [  920.237141] Buffer I/O error on device sr0, logical block 366453
> [  920.237141] Buffer I/O error on device sr0, logical block 366454
> [  925.431105] __ratelimit: 10100 messages suppressed
> [  925.431118] Buffer I/O error on device sr0, logical block 371516
> [  930.772658] __ratelimit: 2407 messages suppressed
> [  930.772658] Buffer I/O error on device sr0, logical block 372720
> [  935.674943] __ratelimit: 6995 messages suppressed
> [  935.674955] Buffer I/O error on device sr0, logical block 376218
> [  940.685317] __ratelimit: 16949 messages suppressed
> [  940.685329] Buffer I/O error on device sr0, logical block 384693
> [  945.770547] __ratelimit: 17881 messages suppressed
> [  945.770558] Buffer I/O error on device sr0, logical block 393634
> [  950.777243] __ratelimit: 19031 messages suppressed
> [  950.777243] Buffer I/O error on device sr0, logical block 403150
> [  955.788427] __ratelimit: 19035 messages suppressed
> [  955.788439] Buffer I/O error on device sr0, logical block 412668
> [  961.575327] __ratelimit: 16603 messages suppressed
> [  961.575338] Buffer I/O error on device sr0, logical block 420970
> [ 1006.919733] __ratelimit: 9315 messages suppressed
> 
> Almost as if the drive is taking to long to think, by then the cache
> has run out, and the FPS changes,
> the movie itself doesn't become choppy like before, just freezes.
> If you have any other ideas I'm up for that to see.
> regards;

Eh.... strange.  Can you post full kernel log?  And does the dvd work if
you restart playing?

-- 
tejun
