From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14294] kernel BUG at drivers/ide/ide-disk.c:187
Date: Mon, 12 Oct 2009 21:37:00 GMT
Message-ID: <200910122137.n9CLb07B026383@demeter.kernel.org>
References: <bug-14294-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:39876 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758098AbZJLVhh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Oct 2009 17:37:37 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n9CLb0aJ026384
	for <linux-ide@vger.kernel.org>; Mon, 12 Oct 2009 21:37:00 GMT
In-Reply-To: <bug-14294-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14294





--- Comment #1 from Rafael J. Wysocki <rjw@sisk.pl>  2009-10-12 21:37:00 ---
On Monday 12 October 2009, Santiago Garcia Mantinan wrote:
> Hi!
> 
> > I gave the user a debugging patch, but they reported that they
> > can no longer trigger the issue with 2.6.31.1
> > 
> > See:
> > 
> > 	http://marc.info/?l=linux-ide&m=125469615425454&w=4
> > 
> > Maybe that's enough to close this, I dunno.
> 
> I'm the user with the debugging patch, I'd say no, don't close it.
> 
> Even though on my first tests I had the computer to crash the two weekends I
> had tested, it seems that crashing on weekend was only luck and seems that
> having the bug appear is more difficult than I had thought.
> 
> So... my comments saying that 2.6.31.1 seemed ok are probably wrong (I have
> read the .1 changelog and there is an ata patch, but probably unrelated). It
> is true that I had 2.6.31.1 running for a whole week without it crashing,
> but seems that crashing it may need more time.
> 
> I'm now back to the 2.6.31 with the patch to debug it (3 days uptime) in
> order to gather more info and after I get the info from 2.6.31 I'd test
> 3.6.31.latest or even 2.6.32whatever in case you find that better.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.