From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: [RFC] Disk shock protection (revisited)
Date: Thu, 28 Feb 2008 12:00:21 -0500
Message-ID: <87f94c370802280900t6e099ae8q7635c275732c9c3e@mail.gmail.com>
References: <87skzgd1zk.fsf@denkblock.local> <20080226123946.75dbe3d2@core>
	 <87mypl8p49.fsf@denkblock.local> <20080228111349.6831925c@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:47171 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756215AbYB1RAX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Feb 2008 12:00:23 -0500
Received: by an-out-0708.google.com with SMTP id d31so783081and.103
        for <linux-ide@vger.kernel.org>; Thu, 28 Feb 2008 09:00:21 -0800 (PST)
In-Reply-To: <20080228111349.6831925c@core>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, lmb@suse.de

On Thu, Feb 28, 2008 at 6:13 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > That sounds like a non starter. What if the box is busy, what if the
>  > > daemon or something you touch needs memory and causes paging ?
>  >
>  > The daemon runs mlock'd anyway, so there won't be any need for paging
>
>  mlock does not guarantee anything of that form. A syscall by an mlocked
>  process which causes a memory allocation can cause paging of another
>  process on the system.
>
>
>  > there. As for responsiveness under heavy load, I'm not quite sure I get
>  > your meaning. On my system, at least, the only way I have managed to
>  > decrease responsiveness noticeably is to cause a lot of I/O operations
>
>  It depends a lot on hardware but you can certainly get user space delays
>  in seconds as an extreme worst case.

I don't know the details, but I believe the Linux-HA heartbeat daemons
take significant effort to eliminate unexpected delays.  See
http://www.linux-ha.org/

Lars Marowsky-Bree of Novell is extremely involved in the project and
he at least occasionally posts on LKML.  I've cc'ed him.

Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
