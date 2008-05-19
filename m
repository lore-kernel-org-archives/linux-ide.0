From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET #upstream] libata: improve timeout handling for EH commands
Date: Tue, 20 May 2008 02:17:49 +0900
Message-ID: <12112174741373-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.155]:16517 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbYESRSB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 13:18:01 -0400
Received: by po-out-1718.google.com with SMTP id c31so3028399poi.1
        for <linux-ide@vger.kernel.org>; Mon, 19 May 2008 10:18:00 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: liml@rtr.ca

Hello,

[S]ATA has lots of legacy and not in a too healthy way.  The desparate
efforts to keep everything compatible made mundane things quite
challenging.  Probing definitely is one of them.  We now span from
ancient CF devices to port multipliers and quirky ones are easy to
find all along the spectrum.

For example, according to the spec reset protocol and the actual
implementations, there's no defined way to wait for the initial D2H
Reg FIS after hardresetting a fan-out port.  The problem is that the
D2H Reg FIS can arrive during later steps of probing is in progress
and a rogue FIS at the right time can easily make the controller fail
or time out pending operations.

Another problem of the long spectrum is that we can't choose the one
correct value as timeout for operations.  A timeout value which can
cover all the devices is too long and makes EH painfully slow when
something goes wrong.  Choosing shorter timeout means the ancient and
weirdos won't work.

So, we have to resort to smart self adjusting timeouts.  Early
quickies to detect transient failures quickly and later long ones to
cover odd devices.  Deadline driven ata_eh_reset() was a step in that
direction and this patchset, in addition to other timeout related
improvements, applies it to the rest of EH commands.

This patchset contains the following patches.

 01-libata-kill-unused-constants.patch
 02-libata-consistently-use-msecs-for-time-durations.patch
 03-libata-improve-EH-retry-delay-handling.patch
 04-libata-use-ULONG_MAX-to-terminate-reset-timeout-tab.patch
 05-libata-improve-EH-internal-command-timeout-handling.patch

#01, #02 and #04 are preparations.  #02 makes liata use msecs
consistently for time durations.  #03 makes inter-try or inter-reset
delays smarter and allows libata EH to delay less between tries
without sacrificing robustness.  #05 implements per command class
stepped timeouts for EH commands, so that the first IDENTIFY try fails
quickly but later on the device can take full 30secs to think about it
while restricting maximum timeout for SET_FEATURES to 10secs.

This patchset makes whole EH behave much more swiftly and timeout
cases bearable.  :-)

This patchset is on top of

 #upstream-fixes (005b1f7495e812b99b73de5adbc73afd7a1cbcaf)
 + [1] hotplug-fixes patchset

and available as git tree

 http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=improve-timeout
 git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git improve-timeout

 drivers/ata/libata-core.c |   56 +++++++-----
 drivers/ata/libata-eh.c   |  200 +++++++++++++++++++++++++++++++++++++------
 drivers/ata/libata-pmp.c  |   13 --
 drivers/ata/libata-sff.c  |   15 +--
 drivers/ata/libata.h      |    2 
 drivers/ata/pata_bf54x.c  |    6 -
 drivers/ata/pata_scc.c    |    2 
 include/linux/libata.h    |   37 +++++---
 8 files changed, 234 insertions(+), 97 deletions(-)

Thanks.

--
tejun

[1] http://thread.gmane.org/gmane.linux.ide/31572
