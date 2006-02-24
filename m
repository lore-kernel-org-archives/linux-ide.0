From: Kumar Gala <galak@kernel.crashing.org>
Subject: IDE timing issue?
Date: Fri, 24 Feb 2006 11:50:35 -0600 (CST)
Message-ID: <Pine.LNX.4.44.0602241140570.2981-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:9368 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932382AbWBXSAN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Feb 2006 13:00:13 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

I'm seeing a timing issue that I was hoping to get some help with.

I've got a simple compact flash IDE device connected in True IDE mode.  
I'm seeing "lost interrupt" messages when I try a simple "mount 
/dev/hda1".

If I had a small amount of delay in udelay(1) in OUTB things seem to work 
ok.

I was wondering about any idea's about what to look at next.  It would 
seem that some control register writes are occuring two fast, is there 
some setting to let the higher layer IDE control know to slow things down 
a little?

thanks

 - kumar

