From: "Avuton Olrich" <avuton@gmail.com>
Subject: Re: [RFT] major libata update
Date: Mon, 15 May 2006 21:37:52 -0700
Message-ID: <3aa654a40605152137j549ec085l6a5cccf01c1ed6e2@mail.gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org>
	 <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>
	 <446914C7.1030702@garzik.org>
	 <3aa654a40605152036h40fa1cd0x8edd81431c1bd22d@mail.gmail.com>
	 <44694D47.4090204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:17096 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751267AbWEPEhx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2006 00:37:53 -0400
Received: by nf-out-0910.google.com with SMTP id o63so1448nfa
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 21:37:52 -0700 (PDT)
In-Reply-To: <44694D47.4090204@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org

On 5/15/06, Tejun Heo <htejun@gmail.com> wrote:
> Avuton Olrich wrote:

> Are those timeouts back-to-back?  Can you post dmesg w/ timestamp
> (either turn on kernel message timestamping or simply post relevant part
> from /var/log/kern.log).  The drive thinks the command is complete.  You
> might be losing interrupts (you might want to diddle with acpi/irq
> routing stuff) or it could be some other hardware problem.

here's the kern log for the last 24 hours or so:
http://olricha.homelinux.net:8080/dump/kern.log

As I told Jeff, I'm not sure how to diddle with the irq stuff, pointers?

> Does the drive + controller work okay on Windows?  I know people don't
> like this question so much but it's a great way to isolate hardware
> problems as they use completely different driver stack.

Sorry, I haven't owned a copy of Windows in >5 yrs, I would be willing
to try otherwise. This computer worked with a 2 160gb sata drives,
when I traded 2 160gb drives with 2 500gb sata2 drives and started
making heavy use of them this happened, although I haven't had any
issue with the other hard drive yet (I don't think, I need to look
over the logs again to make sure I'm not saying that in err).

...snipped more stuff way above my head...
-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
