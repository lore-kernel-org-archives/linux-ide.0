From: "Klavs Klavsen" <kl@vsen.dk>
Subject: 2.6 kernel panic - when cf-card inserted
Date: Mon, 16 Aug 2004 08:25:12 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <32903.10.0.0.51.1092637512.squirrel@10.0.0.51>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 213.237.54.63.adsl.suoe.worldonline.dk ([213.237.54.63]:2757
	"EHLO www.vsen.dk") by vger.kernel.org with ESMTP id S267453AbUHPGZP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Aug 2004 02:25:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by www.vsen.dk (Postfix) with ESMTP id 6E789BCA7
	for <linux-ide@vger.kernel.org>; Mon, 16 Aug 2004 08:25:14 +0200 (CEST)
Received: from www.enableit.dk (localhost.localdomain [127.0.0.1])
	by www.vsen.dk (Postfix) with ESMTP id 13A44BC97
	for <linux-ide@vger.kernel.org>; Mon, 16 Aug 2004 08:25:12 +0200 (CEST)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi Guys,

posted my problem in the kernel bugzilla (
http://bugme.osdl.org/show_bug.cgi?id=3058 ) , but was told to go here.

My problem is as follows:
Distribution: Gentoo Linux
Hardware Environment: IBM Thinkpad X30
Software Environment: pcmcia-cs-3.2.7
Kernel-ver: 2.6.6 (with vserver-1.9.1) and 2.6.7-mm6
Problem Description:
When I insert my CF-card in my builtin CF-card reader - the kernel panics
immediately with the message:
Kernel panic: ide: default attach failed

I just compiled a 2.6.7-mm6 - and have exact same problem.

Steps to reproduce:
Insert CF-card in cf-reader.

You can see my Kernel-config (for both kernels - except for a make
oldconfig ran with default answer for all) here:
http://vsen.dk/files/tpx30-lnx26-kernel-config

Any ideas what is up here? I'd like to be able to use my cf-card :)
It works fine in 2.4 (the last time I checked atleast - don't have a 2.4
kernel on this machine at all).

-- 
Regards,
Klavs Klavsen, GSEC, klavs@EnableIT.dk, http://www.EnableIT.dk
Open Source Server, Security and Network Consulting
Phone: +45 3284 4372 Mobile: +45 2342 4372
PGP: 7E063C62/2873 188C 968E 600D D8F8  B8DA 3D3A 0B79 7E06 3C62

See our CMS Hosting Service at http://www.VirkPaaNettet.dk

"Open Source Software - Sometimes you get more than you paid for."

