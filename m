From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Kernel Bug in ATA or SMART area
Date: Sat, 20 Feb 2010 13:10:49 +0100
Message-ID: <19327.53577.55472.205452@pilspetsen.it.uu.se>
References: <4B72941A.7060704@gmx.de>
	<4B74BDCF.1010805@kernel.org>
	<4B74F263.1060709@gmx.de>
	<4B7505CA.60409@kernel.org>
	<4B75154B.8030507@gmx.de>
	<4B7B548B.4040606@kernel.org>
	<4B7C5696.7030609@gmx.de>
	<19325.7006.892019.748974@pilspetsen.it.uu.se>
	<4B7EDE2F.8030107@gmx.de>
	<19326.64703.561400.379749@pilspetsen.it.uu.se>
	<4B7FA14B.2090809@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:57124 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753697Ab0BTMKz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Feb 2010 07:10:55 -0500
In-Reply-To: <4B7FA14B.2090809@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Axel Uhl <axel.uhl@gmx.de>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

(Please don't top-post on Linux mailing lists.)

Axel Uhl writes:
 > Hi Mikael,
 > 
 > BTW, how do you know that all my PATA controllers are driven by libata? 

Because you wrote:

 > >  > I also enabled 
 > >  >   pata_via but was unsure which IDE driver to disable.

and pata_via is libata's replacement for IDE's via82cxx.

Since you kept both drivers enabled, it seems that IDE's via82cxx won the
race to claim the hardware. Bummer.

Just disable CONFIG_IDE.
