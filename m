From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: [PATCH]: pcmcia - spot slave decode flaws (for testing)
Date: Sat, 24 Feb 2007 14:23:40 -0700
Message-ID: <311601c90702241323i22215a63l33b30e0f0fb009f0@mail.gmail.com>
References: <20070220181836.524e5f9a@localhost.localdomain>
	 <45DEC5A0.7050107@garzik.org>
	 <20070223120845.19203fcb@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:60522 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932697AbXBXVXl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Feb 2007 16:23:41 -0500
Received: by nz-out-0506.google.com with SMTP id s1so829472nze
        for <linux-ide@vger.kernel.org>; Sat, 24 Feb 2007 13:23:41 -0800 (PST)
In-Reply-To: <20070223120845.19203fcb@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 2/23/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> > Code looks OK. Not applied due to "for testing" note.
> >
> > General comment:  it might be nice to do this in the core, just as a
> > sanity check for a variety of problems, past, present and future.
>
> We tried that with old IDE and all hell broke loose. Lots of virtual disk
> stuff and raid volumes have non-unique serial numbers. We even found a
> case of identically serial numbered Maxtor drives.
>
> It needs to stay in pcmcia, which is the only place we've seen the
> duplication.

I don't think the maxtor drives actually had duplicate serial numbers.
 They were coming back as "M0000000000000000000" or something like
that to the limit of the strlen.  It looked more like buffer
corruption or something, and only happened with one or two people...

--eric
