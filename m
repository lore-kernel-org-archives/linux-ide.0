From: "David S. Miller" <davem@redhat.com>
Subject: IDE corruption datapoint
Date: Wed, 16 Jul 2003 04:20:20 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20030716042020.780126b9.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pizda.ninka.net ([216.101.162.242]:5851 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270702AbTGPMIq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jul 2003 08:08:46 -0400
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: alan@redhat.com, linux-ide@vger.kernel.org, bcollins@debian.org


FWIW, just like my alim5x3 based Sparcs, I have to boot with ide=nodma
on my VAIO laptop which uses PIIX chipsets, otherwise I get data
corruptions.

On the VAIO it shows up as corrupted kernel builds.  The build
is successful but the images won't boot properly, rebuilding
the same kernel tree with ide=nodma results in a working image.
This shows up with both 2.4.21 and 2.4.22-current.

I don't know what the situation is wrt. 2.4.20 (ie. before the IDE
huge merge from -ac), but I can check that out.

With 2.6.0-test1 both cases (alim5x3 based Sparcs and the VAIO)
seem perfectly fine with DMA enabled.

This suggests, at least to me, that it's something generic in
the IDE layer of 2.4.x vanilla vs. 2.6.0-test1 that's causing
the problems, rather than a chipset specific issue.

Just FYI...

