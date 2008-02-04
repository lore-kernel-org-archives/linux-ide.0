From: maximilian attems <max@stro.at>
Subject: (fwd) Bug#11922: I/O error on blank tapes
Date: Mon, 4 Feb 2008 15:22:06 +0100
Message-ID: <20080204142206.GB5532@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:41902 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbYBDOWS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 09:22:18 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide@vger.kernel.org, Stephen Kitt <steve@sk2.org>

hello borislav,

may i forward you that *old* Debian kernel bug,
have seen you working on ide-tape:
http://bugs.debian.org/11922
no we don't carry any ide patches anymore.

maybe you've already fixed it in latest?

thanks

-- 
maks

----- Forwarded message from Stephen Kitt <steve@sk2.org> -----

Subject: Bug#11922: I/O error on blank tapes
Date: Sat, 1 Dec 2007 19:06:18 +0100
From: Stephen Kitt <steve@sk2.org>
To: 11922@bugs.debian.org

Hi,

This does still occur with 2.6.22; with a blank tape in my HP DDS-4 drive:

$ tar tzvf /dev/nst0
tar: /dev/nst0: Cannot read: Input/output error
tar: At beginning of tape, quitting now
tar: Error is not recoverable: exiting now

gzip: stdin: unexpected end of file
tar: Child returned status 2
tar: Error exit delayed from previous errors

Nothing gets logged anywhere, which fits the original bug description.

This is a well-known issue: see for example
http://www.sibbald.com/bacula/html-manual/Bacula_Console.html (search for
"blank tape").

Regards,

Stephen



-- 
To UNSUBSCRIBE, email to debian-kernel-REQUEST@lists.debian.org
with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org


----- End forwarded message -----
