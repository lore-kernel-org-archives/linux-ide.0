From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Status of NCQ for the Promise SATA 300 TX2Plus?
Date: Tue, 29 Apr 2008 17:24:53 +0200
Message-ID: <18455.15813.232563.282304@alkaid.it.uu.se>
References: <235005.30535.qm@web50608.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:59157 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756978AbYD2Pcy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Apr 2008 11:32:54 -0400
In-Reply-To: <235005.30535.qm@web50608.mail.re2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: misassistant@yahoo.com
Cc: jgarzik@pobox.com, mikpe@it.uu.se, linux-ide@vger.kernel.org

Scott A. Conway writes:
 > First, I want to thank you for producing working drivers for my card that not even Promise themselves could figure out how to make.
 > I tried several times to build their drivers from source, and they always fail with stupid errors.
 > I just wondered if an when you will build in Native Command Queue support, as the TX2Plus and my Maxtor SATA 300 500GB drive both support it in hardware.

No time plan, but hopefully within the next couple of months.

 > I realize that NCQ is not the be-all end-all in enhancements, but it puzzles me that a three old driver still (apparently, unless I am leaving out a compile time parameter or kernel command line parameter) does not support it.

1) the driver didn't have any NCQ support when I started working on it
2) documentation on the Promise HW is limited; the real documentation
   is their reference driver which isn't always easy to decipher
3) I'd need to set aside several days and focus fully on this one task,
   but so far I haven't had time to do that

 > Oh, and if there is supposed to be a site or mailing list that I should be using instead of e-mailing here, I apologize, but it is nearly impossible to find a definitive site for the LIBATA/SATA development team.

You got the right mailing list (linux-ide).

/Mikael
