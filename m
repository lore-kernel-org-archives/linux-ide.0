From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: [Bug 15884] cd-burning reduces other simultaneous IO performance
Date: Fri, 30 Apr 2010 23:29:19 -0500
Message-ID: <4BDBAE1F.8090904@hardwarefreak.com>
References: <bug-15884-11633@https.bugzilla.kernel.org/> <201005010129.o411Tgn7022000@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:33965 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab0EAE3V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 May 2010 00:29:21 -0400
Received: from [192.168.100.53] (gffx.hardwarefreak.com [192.168.100.53])
	by greer.hardwarefreak.com (Postfix) with ESMTP id 4B3816C306
	for <linux-ide@vger.kernel.org>; Fri, 30 Apr 2010 23:29:20 -0500 (CDT)
In-Reply-To: <201005010129.o411Tgn7022000@demeter.kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

bugzilla-daemon@bugzilla.kernel.org put forth on 4/30/2010 8:29 PM:

> Now, there may be a difference in what commands the burning software is using
> or the ordering that results in some of them taking longer than it does in
> Windows or something. (I don't know the MMC commands that well but I think some
> of them do have a mode where you can issue the command and poll periodically to
> see if it's done rather than blocking on the operation until it finishes.) That
> isn't anything the kernel can do anything about, though - if something issues a
> command to one drive on the channel that takes a long time, anything wanting to
> access the other drive just has to wait.

This has been known for over a decade.  When I was building white box
Windows systems in the mid-late 90s our SOP was to put burners on a
dedicated IDE port specifically due to what the OP reports over a decade
later as a bug.  As Robert points out above, this isn't a software bug, but
a hardware limitation of IDE.  Parallel SCSI, SAS, and SATA do not suffer
this limitation.  Apparently Windows engineers have developed a method over
the years to mitigate the ill effects of this.  I can tell you from
experience that Windows 9x/ME/NT4/W2K all suffered performance degradation
with HD+burner on the same channel problem.

-- 
Stan
