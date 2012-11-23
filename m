From: Joachim Foerster <joachim.foerster@missinglinkelectronics.com>
Subject: AHCI performance and IRQ load
Date: Fri, 23 Nov 2012 17:02:23 +0100
Message-ID: <50AF9E0F.8030300@missinglinkelectronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from static.204.45.9.5.clients.your-server.de ([5.9.45.204]:48975
	"EHLO smtp.missinglinkelectronics.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755145Ab2KWQIa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Nov 2012 11:08:30 -0500
Received: from localhost (code.missinglinkelectronics.com [127.0.0.1])
	by smtp.missinglinkelectronics.com (Postfix) with ESMTP id 6847B79203D
	for <linux-ide@vger.kernel.org>; Fri, 23 Nov 2012 17:02:29 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Lorenz Kolb <lorenz.kolb@missinglinkelectronics.com>

Hi all,

we are currently working on a high performance storage test solution=20
using SATA/AHCI. Due to having performance issues with small block size=
s=20
(high interrupt load), we did some research and came across a FAST12=20
paper by Intel: "When Poll is Better than Interrupt".
The authors do suggest a synchronous completion model or even a hybrid=20
mode with support for async and sync completion - for future SSDs.

Does anybody know, if there already is work going on to incorporate suc=
h=20
functionality into the block layer & backends (meaning, among others:=20
libata/ahci)?

Another thing, which seemed promising was AHCI's=20
CommandCompletionCoalescing (CCC) feature. However most AHCI controller=
s=20
don't seem to support this feature.
Anybody aware of AHCI controllers having CCC support?

There seemed to be a discussion about CCC support for the ahci driver=20
some years ago http://www.spinics.net/lists/linux-ide/msg02994.html, bu=
t=20
obviously no code came out of it - or is there a known patchset?

Thanks,
--=20
Joachim F=F6rster
Direct DE: +49 (731) 141-149-42

Missing Link Electronics
http://www.missinglinkelectronics.com
Office DE: +49 (731) 141-149-0
Office US: +1  (408) 457-0700
