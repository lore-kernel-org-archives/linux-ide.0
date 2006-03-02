From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
Date: Wed, 1 Mar 2006 19:20:22 -0700
Message-ID: <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>
References: <1141239617.23202.5.camel@rousalka.dyndns.org>
	 <4405F471.8000602@rtr.ca>
	 <1141254762.11543.10.camel@rousalka.dyndns.org>
	 <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>
	 <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.195]:52401 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751333AbWCBCUY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Mar 2006 21:20:24 -0500
Received: by wproxy.gmail.com with SMTP id 68so299222wri
        for <linux-ide@vger.kernel.org>; Wed, 01 Mar 2006 18:20:24 -0800 (PST)
In-Reply-To: <4406512A.9080708@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>, Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

On 3/1/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> This also begs the question... what controller was being used, when the
> single Maxtor device listed in the blacklist was added?  Perhaps it was
> a problem with the controller, not the device.
>
>         Jeff

As reported here:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=177951

the controller was a 3114, and the bug was "fixed" by blacklisting his
Maxtor drive's FUA support.  I'd like Maxtor drives to be
un-blacklisted if possible.

--eric
