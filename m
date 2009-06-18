From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Thu, 18 Jun 2009 08:19:15 GMT
Message-ID: <200906180819.n5I8JFqu029845@demeter.kernel.org>
References: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:53148 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbZFRITN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jun 2009 04:19:13 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5I8JF2M029846
	for <linux-ide@vger.kernel.org>; Thu, 18 Jun 2009 08:19:15 GMT
In-Reply-To: <bug-13399-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399





--- Comment #31 from Borislav Petkov <bbpetkov@yahoo.de>  2009-06-18 08:19:14 ---
Hi,

(In reply to comment #30)
> hda: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
> hda: media error (bad sector): error=0x30 { LastFailedSense=0x03 }
> hda: possibly failed opcode: 0xa0
> ATAPI device hda:
>   Error: Medium error -- (Sense key=0x03)
>   (reserved error code) -- (asc=0x02, ascq=0x00)
>   The failed "Read 10" packet command was: 
>   "28 00 00 00 76 78 00 00 40 00 00 00 00 00 00 00 "
> end_request: I/O error, dev hda, sector 121312
> Buffer I/O error on device hda, logical block 30328
> Buffer I/O error on device hda, logical block 30329
> Buffer I/O error on device hda, logical block 30330
> Buffer I/O error on device hda, logical block 30331
> Buffer I/O error on device hda, logical block 30332
> Buffer I/O error on device hda, logical block 30333
> Buffer I/O error on device hda, logical block 30334
> Buffer I/O error on device hda, logical block 30335
> Buffer I/O error on device hda, logical block 30336
> Buffer I/O error on device hda, logical block 30337
> 
> Just kidding a CD and a whiteboard marker apparently don't mix :). 

You funny guy :)

> I can boot whith a CD, create iso's from CD's and DVD's and copy at
> file level. Since this is my at work pc I dont have musical CD's at
> hand.

Thanks for testing.

> Where did this problem start? I could still use cd's in
> 2.6.29 but in a slackware newsgroup I found this threat:
> http://groups.google.com/group/alt.os.linux.slackware/browse_thread/th
> read/1add287bea50b0bc# slack. Slack current uses 2.6.29.4

The fix might need backporting. If you like, you could test latest
stable kernels (2.6.29.5, maybe even 2.6.28.10) and send me the bootlogs
of those so that we could verify that the fix is needed. That'll be of
great help :).

Thanks,
Boris.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
