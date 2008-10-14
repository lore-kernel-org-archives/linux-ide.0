From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: Bug 11581
Date: Tue, 14 Oct 2008 13:53:40 +0200
Message-ID: <9ea470500810140453m6e1f7eb6raf179ee78414e19e@mail.gmail.com>
References: <20081004091232.GB4160@gollum.tnic>
	 <Pine.LNX.4.64.0810051147470.2543@cantor.unex.es>
	 <20081010061610.GA5273@gollum.tnic>
	 <Pine.LNX.4.64.0810101212170.2505@cantor.unex.es>
	 <20081012071523.GA20434@gollum.tnic>
	 <Pine.LNX.4.64.0810141314590.2555@cantor.unex.es>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:38242 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523AbYJNLxm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Oct 2008 07:53:42 -0400
Received: by an-out-0708.google.com with SMTP id d40so159732and.103
        for <linux-ide@vger.kernel.org>; Tue, 14 Oct 2008 04:53:40 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0810141314590.2555@cantor.unex.es>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Santiago Vila <sanvila@unex.es>
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

On Tue, Oct 14, 2008 at 1:18 PM, Santiago Vila <sanvila@unex.es> wrote:
> [ Sorry for the delay, yesterday it was a non-working day here, so
>  rebooting the computer was a little bit dangerous ].
>
>> Ok, it seems that your drive gets puzzled after receiving a GET_CONFIGURATION
>> command. Lets see whether this is the real cause of the problem. Here's a yet
>> another version of the inquisitive patch :) which drops such commands. Please
>> rebuild with it and send me the dmesg. Thanks.
>
> Hurrah!
>
> There is no waiting time during boot anymore, and the drive hdc now works.

Ok, we see now where the problem hides. Nice! However, IIRC, you can boot 2.6.18
with the same Debian unstable setup (correct?) which means that the drive
receives the same commands. So, it seems that there is something in the way the
command is sent to the drive that puzzles it. I'll try to cook up a
debugging patch for 2.6.18 for you to apply so that we can make sure it does
execute GET_CONFIGURATION properly.

Thanks a lot for your work!

-- 
Regards/Gruss,
Boris
