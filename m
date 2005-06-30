From: Steven Schlansker <stevenschlansker@gmail.com>
Subject: Re: siimage card causes repeated oopses and panics on a PowerMac G4 running 2.6.12.1
Date: Thu, 30 Jun 2005 00:58:02 -0700
Message-ID: <8276078A-6BE9-4CD2-941E-23E691C9FA3E@gmail.com>
References: <9c1484f205062702203936d7ca@mail.gmail.com> <58cb370e05062923518ba365b@mail.gmail.com> <1120114579.31924.46.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.195]:10343 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262829AbVF3IAV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jun 2005 04:00:21 -0400
Received: by rproxy.gmail.com with SMTP id i8so67263rne
        for <linux-ide@vger.kernel.org>; Thu, 30 Jun 2005 01:00:21 -0700 (PDT)
In-Reply-To: <1120114579.31924.46.camel@gaston>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I just tried subscribing to the linux-ide mailing list, as this seems  
to be a problem that may take a while to solve.  I very much want to  
look into it more, as I would like to run linux at least part-time on  
this machine.  I tried sending messages to majordomo with no replies  
(yes, it was text/plain) and even the autoanswer@ email address sends  
me nothing.  Very strange.  You had better keep CCing me, I'll debug  
the mailing list more when I'm at least half-awake ;)

Back to the kernel - in the kernel config there are some options,  
things like building debugging symbols in and frame pointers.  I know  
with userspace programs, you can grab core files and use GDB to get a  
good idea of what's going on - can you do this with the kernel?   
(Keep in mind that I have no serial port, just netconsole right now)   
Would turning on all these debugging things help, and if so, how do I  
grab a kcore from a mostly-crashed kernel?  I also assume that you  
would need my vmlinux image.  Would this be helpful, or should I just  
go for tossing in printk?  (The issue with this being that each  
kernel compile takes a good fifteen minutes, as something seems to be  
messed in the dirty-file-checking and it recompiles parts of the  
kernel, changes or no)

I'll give whatever a go tomorrow, erm, this morning...

And, no, sorry I don't live in Australia ;)


Hmm, now that I reread the headers, you did not email the list with  
this.  Should this be taken off-list?  I'll send this to the list  
just in case...

Thank you!

On Jun 29, 2005, at 11:56 PM, Benjamin Herrenschmidt wrote:
>
> Ok, that's weird. Second Oops looks like junk (memory corruption) but
> first Oops does seem to indicate that somebody is trying to use the  
> pmac
> IDE DMA ops on your interface, and it blows up with a NULL  
> dereference.
>
> I'm not sure how to track that down without having the HW at hand  
> at the
> moment though, unless Bart has an idea. You don't happen to be in
> Australia do you ? :)
>
> Might be worth adding some printk's to start_request to see exactly  
> what
> it's doing, what the request looks like and why the hell it's calling
> ide pmac callbacks ...
>
> Ben.


