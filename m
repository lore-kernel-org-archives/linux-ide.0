From: Craig Wilfred Pearce <S2007823@student.rmit.edu.au>
Subject: ide.c problem in 2.6.0
Date: Mon, 29 Dec 2003 12:41:24 +1100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031229014124.GA12405@cs.rmit.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from voga.its.rmit.edu.au ([131.170.2.8]:20382 "EHLO
	voga.its.rmit.edu.au") by vger.kernel.org with ESMTP
	id S262324AbTL2Blf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Dec 2003 20:41:35 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

Hi there,

Am trying to boot Linux kernel 2.6.0 under Debian testing/unstable with an
Intel Pentium II BX chipset (no CD-ROM).

Upon bootup I get several meessages saying:
hda: dma_intr: status=0x51 { DriveReady SeekComplete error }
hda: dam_intr: error=0x84 { DriveStatusError Bad CRC }

In the past on Linux 2.4.x it would then say 'ide0: reset success'
however 2.6.0 just comes to a halt. How can I make the kernel do an ide0 reset so I can continue
to operate?

Kind regards,

Craig

-- 
Craig Pearce                                                 .---.
                                                            /     \
http://yallara.cs.rmit.edu.au/~crpearce                     \.@-@./
crpearce@cs.rmit.edu.au                                     /`\_/`\
RMIT, City Campus   Melbourne, Aus.                        //  _  \\
 GPG Public Key ID: 29811D6E                              | \     )|_
                                             Powered by  /`\_`>  <_/ \
                                                 Debian  \__/'---'\__/
