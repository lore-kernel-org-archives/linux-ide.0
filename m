From: Xiang Xu <xuxiang_ins@yahoo.com>
Subject: AHCI module conflict with kexec boot
Date: Fri, 28 Sep 2007 16:14:37 -0700 (PDT)
Message-ID: <498184.84089.qm@web32914.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web32914.mail.mud.yahoo.com ([209.191.69.114]:36592 "HELO
	web32914.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753638AbXI1XVT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2007 19:21:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: xuxiang_ins@yahoo.com

Hi Jeff,

Greetings.
=20
I am writing in regarding of an issue I encountered
for AHCI SATA support (drivers/scsi/ahci.c or
drivers/ata/ahci.c) with kexec. I am using kexec to do
chainboot, and kexec works fine with ata_piix driver.
But it hangs with AHCI driver. I tried linux kernel
version 2.6.14, 2.6.20, and 2.6.21 and got same
results. I also tried building AHCI in the kernel or
as a module (then insmod and rmmod), but still the
same result. The interesting thing is that kexec
chainboots fine before insmod AHCI and it hangs after
insmod, it also hangs after rmmod. This leads me to
think that maybe AHCI module left something behind
uncleaned even after rmmod, in other words, ahci
module left the system in a state that kexec boot
can=A1=AFt handle.

Then I took a look at the ahci.c code, what I found
out is that ahci_irq_clear function is not implemented
yet. Also, there is no .host_stop operation for AHCI
module. Could one of these be the reason that kexec
boot failed when AHCI module? Are there other factors
that might have caused the hang of the kexec boot?

Thank you so much in advance for your time and help in
this matter. Any pointer will be greatly appreciated.
I look forward to hearing back from you soon.

Thanks,
Janice Xu

