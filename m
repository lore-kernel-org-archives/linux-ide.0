From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: Thu, 27 Mar 2008 19:14:22 +0900
Message-ID: <12066128663306-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:1228 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276AbYC0KOg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Mar 2008 06:14:36 -0400
Received: by wa-out-1112.google.com with SMTP id v27so4737774wah.23
        for <linux-ide@vger.kernel.org>; Thu, 27 Mar 2008 03:14:33 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca

Hello, all.

I was going through mailbox and saw Alan's patch[A] which didn't get
the love it deserved.  It turned out that ata_flush_cache() function
the patch modifies had been dead for some time.  I ended up re-doing
it in the EH framework and it turned out okay.

After the patchset, on FLUSH failure, the following is done.

  1. It's always retried with longer timeout (60s for now) after
     failure.

  2. If the device is making progress by retrying, humor it for longer
     (20 tries for now).

  3. If the device is fails the command with the same failed sector,
     retry fewer times (log2 of the original number of tries).

  4. If retried FLUSH fails for something other than device error,
     don't keep retrying.  We're likely wasting time.

As the code is being smart against retrying needlessly, it won't be
too dangerous to increase the 20 tries (taken from Alan's patch) but I
think it's as good as any other random number.  If anyone knows any
meaningful number, please chime in.  The same goes for 60 secs timeout
too.

I made a debug patch to trigger timeouts and device errors on FLUSH.
I'll post the patch as a reply.  It adds the following four module
params which can be written runtime via /sys/module/libata/parameters.

  flush_dbg_do_timeout:
	If non-zero value is written, the specfied number of FLUSHes
	will be timed out.

  flush_dbg_do_deverr:
	If non-zero value is written, the specfied number of FLUSHes
	will be terminated with device error.

  flush_dbg_fail_sector:
	The failed sector for the next deverr.

  flush_dbg_fail_increment:
        Number of sectors to add to fail_sector after each deverr.

I tested different scenarios and it all seems to work fine but it
would be really great if someone can test this on a (hmmm....) live
dying drive.

This patchet is for #upstream but generated on top of

  #upstream-fixes (4cde32fc4b32e96a99063af3183acdfd54c563f0)
+ [1] libata: ATA_EHI_LPM should be ATA_EH_LPM

as there is a humongous patchset pending review #upstream.  Once this
gets acked, I'll move it over to #upstream.  It shouldn't interfere
too much anyway.

Thanks.

--
tejun

[A] http://article.gmane.org/gmane.linux.ide/28835
[1] http://article.gmane.org/gmane.linux.ide/30077
