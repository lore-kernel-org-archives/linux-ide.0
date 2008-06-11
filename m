From: Tejun Heo <htejun@gmail.com>
Subject: Re: macbook pro dvd playback after suspend Buffer I/O error
Date: Wed, 11 Jun 2008 11:00:24 +0900
Message-ID: <484F31B8.8030001@gmail.com>
References: <dd18b0c30804032207u36bd1f43l358e9949f0c94f79@mail.gmail.com> <20080404012147.abf8a598.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:20387 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256AbYFKCAb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 22:00:31 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1207272rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2008 19:00:31 -0700 (PDT)
In-Reply-To: <20080404012147.abf8a598.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Justin Mattock <justinmattock@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Andrew Morton wrote:
> On Fri, 4 Apr 2008 05:07:45 +0000 "Justin Mattock" <justinmattock@gmail.com> wrote:
> 
>> When playing a DVD and then suspending the system while the DVD is
>> still in play, upon wakeup I'm receiving a Buffer I/O error on device
>> sr0, logical block 356490.
>> the DVD will continue to play but then gmplayer complains: Warning!
>> FPS changed 23.976 -> 29.970 (-5.994005) [4] then the video becomes
>> very choppy. When looking at osx in the same test the DVD will be
>> paused until the cd player aligns itself, then playback will start.
>> With looking further at this I think this is an issue of a library or
>> codec, So with this in mind is there a package that I might look at to
>> see if this resolves the issue. Attached is dmesg of the Buffer I/O
>> regards;
> 
> An ata thing, I assume.  Let's cc linux-ide.
> 
> Is this new behaviour in 2.6.25-rc8, or were earlier kernels OK?

This is due to UNIT ATTENTION condition triggered by reset during
resume.  The following patches should fix it.

http://marc.info/?l=linux-ide&m=121309016918976&w=2
http://marc.info/?l=linux-ide&m=121309016918979&w=2

Thanks.

-- 
tejun
