From: Tyler Montbriand <tsm@accesscomm.ca>
Subject: sata_sil on amd64
Date: Sat, 22 Jan 2005 19:19:35 -0600
Message-ID: <200501221919.35710.tsm@accesscomm.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.accesscomm.ca ([204.83.142.27]:21147 "EHLO
	mailout1.accesscomm.ca") by vger.kernel.org with ESMTP
	id S261173AbVAWBUd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Jan 2005 20:20:33 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

I have been stuck using kernel 2.6.4 for the last year or so for various 
reasons, and now I'm in a vicious catch-22.  If I don't upgrade, I can't use 
NPTL, therefore my system will continue to be susceptible to the 
sigqueue-overflow flaw in linuxthreads.  But if I do upgrade, problems in 
>0.53 sata_sil implementations halt my system in a matter of minutes with 
dmesg entries about imaginary bad blocks.

0.53 probably has it's own flaws, but it's been rock-solid running a single 
drive on my computer for a year.  How feasible would it be to forward-port 
this version to a newer kernel, say 2.6.10?  If I fix the header problems 
could it work, or is .10 too structurally different from .4?
