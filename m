From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.19-rc5: known regressions with patches
Date: Mon, 13 Nov 2006 23:14:46 +0100
Message-ID: <20061113221446.GJ22565@stusta.de>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30474 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1755369AbWKMWOl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Nov 2006 17:14:41 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Aaron Durbin <adurbin@google.com>, Mel Gorman <mel@csn.ul.ie>, ak@suse.de, discuss@x86-64.org, Paul Mackerras <paulus@samba.org>, Brian King <brking@us.ibm.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org

This email lists some known regressions in 2.6.19-rc5 compared to 2.6.18
with patches available.

If you find your name in the Cc header, you are either submitter of one 
of the bugs, maintainer of an affectected subsystem or driver, a patch 
of you caused a breakage or I'm considering you in any other way 
possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : x86_64: Fix partial page check to ensure unusable memory
                     is not being marked usable
References : http://lkml.org/lkml/2006/11/9/239
Submitter  : Aaron Durbin <adurbin@google.com>
Caused-By  : Mel Gorman <mel@csn.ul.ie>
             commit 5cb248abf5ab65ab543b2d5fc16c738b28031fc0
Patch      : http://lkml.org/lkml/2006/11/9/239
Status     : patch available


Subject    : libata must be initialized earlier
References : http://ozlabs.org/pipermail/linuxppc-dev/2006-November/027945.html
Submitter  : Paul Mackerras <paulus@samba.org>
Handled-By : Brian King <brking@us.ibm.com>
Patch      : http://marc.theaimsgroup.com/?l=linux-ide&m=116169938407596&w=2
Status     : patch available


