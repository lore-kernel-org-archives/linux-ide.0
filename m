From: Tejun Heo <tj@kernel.org>
Subject: Re: [nForce4] - Repeatable issues with nForce 4
Date: Sun, 14 Sep 2014 18:37:21 +0900
Message-ID: <20140914093721.GA9028@mtj.dyndns.org>
References: <CAO18KQjN88PjQSh0bMo+YgqmSSE--eaxL3Lgo5QeUjg3vMu6iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35401 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbaINJhm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Sep 2014 05:37:42 -0400
Received: by mail-pd0-f182.google.com with SMTP id w10so4343291pde.27
        for <linux-ide@vger.kernel.org>; Sun, 14 Sep 2014 02:37:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAO18KQjN88PjQSh0bMo+YgqmSSE--eaxL3Lgo5QeUjg3vMu6iQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jacobo Pantoja <jacobopantoja@gmail.com>
Cc: linux-ide@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>

(cc'ing Robert Hancock)

Hello,

On Sat, Sep 13, 2014 at 11:50:08PM +0200, Jacobo Pantoja wrote:
> (Sorry if you receive twice, I have noticed that the first email had
> blank subject)
> Dear Tejun Heo and linux-ide team,
> 
> I'm Jacobo Pantoja. I'm a technology passionate and electronics engineer.
> I have my ("beloved") computer with an nForce4 chipset, and I have had almost
> always the ADMA interface enabled. The board itself is ASUS A8N-E, with
> reportedly CK804 chipset, if it may be relevant at all.
> 
> As suggested by Tejun, I'm sending my problem to the list.
> 
> I noticed that from time to time the machine was freezed, but I was not
> able to correctly catch the trigger. Till yesterday.
> 
> I noticed that one of my 2 TB drives had some few sectors, which were
> marked as "pending reallocation", but not reallocated. When this has
> happened to me (in different computers, though), I solved it by dd'ing
> the whole disk, locating the bad sector(s) and filling it with zeroes.
> So I tried... and I have discovered that when a bad sector is tried to
> be read, the system locks up.
> 
> You may find attached:
> * dmesg when adma activated (but not including the moment of the error
>        because the computer freezes)
> * photo taken in the moment of the error with adma activated
> * dmesg when adma is not activated, including the moment of the error
> 
> This is totally reproducible**, and I am willing to do any additional
> testing that may help in solving this issue, if there is any interest.
> 
> **I have noticed, while trying to provide clear dmesg's and so on, that
> if I do the reading with ADMA disabled, the sector may be marked (as expected)
> as definitively bad block, and then reallocated. Given that the drive has
> still some few bad blocks, we have still some chances of reproducing again
> and again, but really I don't know for sure how many tries do we have.

You can create bad blocks using hdparm --make-bad-sector on most
drives.

So, the controller locks up the whole machine while trying to handle a
UNC error.  Heh, it even times out on READ_LOG_EXT during EH.
Unfortunately, I'm not sure there's much we can do at this point.
IIRC, NV ADMA support never really matured which is why it never got
turned on by default.  I wouldn't be too surprised if the issue is
with the controller itself.  Quite a few of these first-gen NCQ
controllers were quite flaky after all.  Robert should know a lot
better than me tho.

Thanks.

-- 
tejun
