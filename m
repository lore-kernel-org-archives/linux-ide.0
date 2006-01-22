From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: various fixes related to EH
Date: Sun, 22 Jan 2006 16:58:30 +0900
Message-ID: <11379167103055-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.194]:32683 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751223AbWAVH6f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 02:58:35 -0500
Received: by xproxy.gmail.com with SMTP id s14so513086wxc
        for <linux-ide@vger.kernel.org>; Sat, 21 Jan 2006 23:58:35 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: htejun@gmail.com

Hello, Jeff, Albert.

This patchset is composed of 12 patches fixing/updating various EH
related stuff in libata.  Although not all of the patches are
logically related, they need to be ordered because they modify
similar parts of code.

#01	: cosmetic
#02	: ata_qc_new/free model
#03	: ata_qc_issue() error handling fix
#04	: detailed AC_ERR_* flags
#05	: return AC_ERR_* from issue functions
#06-07	: ata_eh_qc_retry/complete
#08-12	: eh synchronization (#12 is the pio/eh sync patch I talked
	  about in the thread "update timer for PIO polling - revised")

Jeff, these are hopefully more acceptable patches from my recent EH
work.  I'll soon follow up with more pervasive patches.  My working
version of new EH now does most things described in ATA EH doc
including reset, revalidation and gearing down.  I've also ported
Jen's NCQ support over it, and, although it has a few issues, it's
generally working okay.

I think libata really needs better EH and NCQ/hotplug stuff is already
somewhat late.  I hope we can go somewhere this time.

Thanks

--
tejun


