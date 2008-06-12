From: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: macbook pro dvd playback after suspend Buffer I/O error
Date: Thu, 12 Jun 2008 02:10:10 +0000
Message-ID: <dd18b0c30806111910j4b127c32rbd546f885731e18c@mail.gmail.com>
References: <dd18b0c30804032207u36bd1f43l358e9949f0c94f79@mail.gmail.com>
	 <20080404012147.abf8a598.akpm@linux-foundation.org>
	 <484F31B8.8030001@gmail.com>
	 <dd18b0c30806110045s6d19a034yd89b892441bd1621@mail.gmail.com>
	 <dd18b0c30806111131gc1b506cva12f577ebb4afdf9@mail.gmail.com>
	 <485048EC.2080608@gmail.com>
	 <dd18b0c30806111527x22fa895em230ceade4712f073@mail.gmail.com>
	 <4850794F.3000200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:24889 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbYFLCKM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jun 2008 22:10:12 -0400
Received: by an-out-0708.google.com with SMTP id d40so809181and.103
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 19:10:11 -0700 (PDT)
In-Reply-To: <4850794F.3000200@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Jun 12, 2008 at 1:18 AM, Tejun Heo <htejun@gmail.com> wrote:
> Justin Mattock wrote:
>> O.K. attached is dmesg of playing a dvd, then suspending and wakingup,
>> as well as starting after the buffer error.(audit messages)
>> This is interesting, even  pausing the dvd before suspending, causes
>> the same error.
>> I sent a post to mplayer-users to see if there is a way to have
>> mplayer pause and wait for the disk drive to align, but am still
>> waiting
>> for a response.
>
> Can you please do the followings?
>
> 1. dd if=/dev/sr0 of=/dev/null bs=1M
> 2. suspend / resume
> 3. see whether dd fails and post the resulting dmesg.
>
> Thanks.
>
> --
> tejun
>

Hello; I did what you had suggested(twice below is the first,same
results with second)
 upon wakeup dd just quits giving me this:

dd: reading `/dev/sr0': Input/output error
3+1 records in
3+1 records out
3276800 bytes (3.3 MB) copied, 21.834 seconds, 150 kB/s

And under dmesg:
[  329.596421] end_request: I/O error, dev sr0, sector 6400
[  329.596437] Buffer I/O error on device sr0, logical block 800
[  329.596903] Buffer I/O error on device sr0, logical block 833
[  329.596912] Buffer I/O error on device sr0, logical block 834
[  329.596919] Buffer I/O error on device sr0, logical block 835
[  329.596926] Buffer I/O error on device sr0, logical block 836
[  329.596934] Buffer I/O error on device sr0, logical block 837
[  329.596941] Buffer I/O error on device sr0, logical block 838
[  329.596949] Buffer I/O error on device sr0, logical block 839
[  329.596956] Buffer I/O error on device sr0, logical block 840
[  329.596963] Buffer I/O error on device sr0, logical block 841

regards;


-- 
Justin P. Mattock
