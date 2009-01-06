From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12320] warn_on_slowpath when playing audio CD
Date: Mon,  5 Jan 2009 21:48:55 -0800 (PST)
Message-ID: <20090106054855.7CAB810800E@picon.linux-foundation.org>
References: <bug-12320-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58515 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750762AbZAFFs6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Jan 2009 00:48:58 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n065mtoc007753
	for <linux-ide@vger.kernel.org>; Mon, 5 Jan 2009 21:48:56 -0800
In-Reply-To: <bug-12320-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12320





------- Comment #17 from nm127@freemail.hu  2009-01-05 21:48 -------
(In reply to comment #16)
> thanks for testing. Hmm, I can reproduce it here with kaffeine. Can you retry
> playing the audio cd with kscd with "Use direct digital playback" enabled,
> under Settings? 

kscd is working with and without "Use direct digital playback" settings. There
is no new message in dmesg while kscd is playing. kaffeine still does not work
and debug messages are printed in dmesg. The version numbers I used: kaffeine
0.8.7, kscd 1.6.

kaffeine reports the following messages on stdout/stderr when trying to play
audio CD:
$ kaffeine 
Checking /dev/hdc for cdrom...
        Testing /dev/hdc for SCSI/MMC interface
                SG_IO device: /dev/hdc

CDROM model sensed sensed: Optiarc DVD RW AD-7543A 1-00 

Checking for SCSI emulation...
        Drive is ATAPI (using SG_IO host adaptor emulation)

Checking for MMC style command set...
        Drive is MMC style
        DMA scatter/gather table entries: 1
        table entry size: 131072 bytes
        maximum theoretical transfer: 55 sectors
        Setting default read size to 27 sectors (63504 bytes).

Verifying CDDA command set...
        Expected command set reads OK.
CDROMREADRAW: Input/output error
CDROMREADRAW: Input/output error
CDROMREADRAW: Input/output error
CDROMREADRAW: Input/output error
CDROMREADRAW: Input/output error
CDROMREADRAW: Input/output error


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
