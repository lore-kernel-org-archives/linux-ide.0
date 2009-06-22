From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Mon, 22 Jun 2009 15:49:04 GMT
Message-ID: <200906221549.n5MFn4Rd020967@demeter.kernel.org>
References: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:42592 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbZFVPtB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jun 2009 11:49:01 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5MFn4ZK020968
	for <linux-ide@vger.kernel.org>; Mon, 22 Jun 2009 15:49:04 GMT
In-Reply-To: <bug-13399-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399





--- Comment #43 from Borislav Petkov <bbpetkov@yahoo.de>  2009-06-22 15:49:03 ---
(In reply to comment #42)
> Please explain how to apply patch. I downloaded
> 0001-ide-cd-prevent-null-pointer-deref-via-cdrom_newpc_in.patch & saved
> existing linux-2.6.30 to linux-2.6.30-orig but now what? 
> 
> Also, I noted that your patch-ide-cd/diff-attachment.cgi.html shows lines
> 667-673 are to be changed in the ide-cd.c file, ..but my kernel-2.6.30 ide-cd.c
> file has that data on lines 758-764. Will that make the patch fail?
> 
> I have attached a snapshot1.png file showing my kernel-2.6.30 ide-cd.c file.
> 
> Sorry, but I know very little about applying patches. I do have the
> /usr/bin/patch program though if that is what's needed.

Ah, let's do the thing by foot then since it is easier:

Open drivers/ide/ide-cd.c and locate the following lines (as you've done
already in the screenshot):

756                 } else {
757                         if (uptodate <= 0 && rq->errors == 0)
758                                 rq->errors = -EIO;
759                 }
760
761                 if (uptodate == 0)
762                         ide_cd_error_cmd(drive, cmd);
763
764                 /* make sure it's fully ended */

and change the 761th line from

761                 if (uptodate == 0)

to

761                 if (uptodate == 0 && rq->bio)

and then recompile and install your kernel as you normally do. Then boot
test it to see whether it works. That's it :).

Thanks,
Boris.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
