From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13345] panic when reading data from IDE CDROM with >= 2.6.29
 kernels
Date: Wed, 20 May 2009 18:19:31 GMT
Message-ID: <200905201819.n4KIJVfd024057@demeter.kernel.org>
References: <bug-13345-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:60635 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750AbZETSTa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2009 14:19:30 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4KIJVWo024058
	for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 18:19:31 GMT
In-Reply-To: <bug-13345-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13345





--- Comment #6 from Modestas Vainius <modestas@vainius.eu>  2009-05-20 18:19:31 ---
I'm really sorry, but I realized that I had not rebuilt initrd when I'd
installed a new kernel with the patch applied. So I did that and I can confirm
that I no longer got OOPS but those DMA turn offs were back instead as they
used to happen with <= 2.6.28 kernels:

[  663.442788] hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete
Error }
[  663.445040] hdd: cdrom_decode_status: error=0x40 <3>{ LastFailedSense=0x04 }
[  663.446768] ide: failed opcode was: unknown
[  663.454549] hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete
Error }
[  663.456681] hdd: cdrom_decode_status: error=0x40 <3>{ LastFailedSense=0x04 }
[  663.458541] ide: failed opcode was: unknown
[  663.464783] hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete
Error }
[  663.466847] hdd: cdrom_decode_status: error=0x40 <3>{ LastFailedSense=0x04 }
[  663.468764] ide: failed opcode was: unknown
[  663.473414] hdd: cdrom_decode_status: status=0x51 { DriveReady SeekComplete
Error }
[  663.475365] hdd: cdrom_decode_status: error=0x40 <3>{ LastFailedSense=0x04 }
[  663.477259] ide: failed opcode was: unknown
[  663.477406] hdd: DMA disabled
[  663.520043] hdd: ATAPI reset complete

So yes, I can confirm that the patch fixes the OOPS with 2.6.30-rc5 and
2.6.30-rc6-git5. I'm looking forward to seeing the patch included in 2.6.30-rc7
and 2.6.29.x, it looks pretty important to me.

What is more, I "played" a bit with IDE cabling and switched my CD/DVD drive to
IDE master and I could not even reproduce the errors above (and hence annoying
DMA turn off is gone too) any more. So it is good news on all fronts for me.

I leave it for you to close the bug but it is fully RESOLVED as far as I'm
concerned.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
