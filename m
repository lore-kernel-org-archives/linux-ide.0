From: ld puri <neoequal@gmail.com>
Subject: State of outstanding command executing driver code during suspend()/resume().
Date: Tue, 7 Sep 2010 10:30:28 -0600
Message-ID: <AANLkTi=GiP+QZ-ZYvOLsq+J2Fi9E42R8ziOKgEDkeyoc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57507 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756296Ab0IGQa3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Sep 2010 12:30:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-newbie@vger.kernel.org, linux-pci@vger.kernl.org

Hi All,

While browsing through current Linux Power management implementation
wrt AHCI drivers, I stumbled upon following doubts.

I assume=A0whenever=A0system wide=A0suspend (STR/hibernate) occurs, all=
 the
process is=A0freeze=A0by the Kernel's PM=A0subsystem and it ensures the=
re
are no additional command can be issued to AHCI driver.=A0But it can be
very much possible some commands are being executed within the AHCI
driver.

If my understanding is correct suspend() will be called anytime for
the AHCI driver. In other words, the invocation
ahci_pci_device_suspend() from PCI=A0subsystem=A0won't wait for ahci
driver to complete its outstanding command.
The invocation of suspend(), resume() & remove() call backs from PCI
subsystem are not=A0synchronized=A0with that driver's IO path is this
correct ?

Does these outstanding command currently executed by driver will be los=
t ?

Moreover in resume() routine of AHCI driver, the controller is
reinitialized (ahci_init_controller), then how system can restart the
commands that are stopped during previous suspend() call.

Thanks
Das
