From: msundius@u1.netgate.com
Subject: AHCI: using bios after linux
Date: Fri, 12 Oct 2007 15:40:58 +0000 (GMT)
Message-ID: <20071012154058.BEDDF47008A@web2mail.com>
Reply-To: msundius@u1.netgate.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from texas4.legendum.com ([67.15.197.40]:35659 "EHLO web2mail.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1761275AbXJLQNm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Oct 2007 12:13:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: msundius@sundius.com

--------------------------------------------------
Here is a message for you from http://web2mail.com
The easy way to read and send POP email on the web
--------------------------------------------------

My employer is using Linux as a boot-loader of sorts which eventually b=
oots=0D
another OS. We have some proprietary code which runs in real mode betwe=
en the=0D
time Linux runs and the next operating system is chain-booted (we use k=
exec=0D
return to real mode after Linux). This proprietary code makes use of th=
e BIOS=0D
disk calls via int13. In short we need to the BIOS Int13 after Linux.=0D
=0D
Our system seems to work well on most machines, however it does not wor=
k on any=0D
machine that make use of AHCI. As soon as we make the first Int13 call =
after the =0D
Linux AHCI driver has been initialized, the machine goes off into the w=
eeds. =0D
=0D
I been looking though your archives and reading the AHCI spec. It seems=
 clear=0D
that the hardware has at least some state contained within it; I'm wond=
ering if=0D
there is any hope of putting the chip back to a known state that the BI=
OS will=0D
be able to handle. =0D
=0D
1)In reading the AHCI spec, I notice in chapter 10.6 they talk about a =
bit that=0D
when set by the OS driver, control of the AHCI hardware is irrevocably =
passed to=0D
the OS, your driver does not seem to touch that bit so I'm hoping that =
it is=0D
reasonable to pass back control to the BIOS by either resetting the chi=
p or=0D
simply placing it into a quiescent state.=0D
2)I also have noticed that you do not do anything special when the AHCI=
 module=0D
is removed. That is, you simply use the ata_pci_remove_one() function i=
nstead of=0D
one particular to the AHCI chip. =0D
=0D
Could anyone lend some guidance as to what has to be done to put the ha=
rdware=0D
back into a sane state for BIOS, or if there is a good reason that this=
 is not=0D
achievable. =0D
=0D
Any prior work or manuals that I should =93rtfm=94 or other wisdom woul=
d be greatly=0D
appreciated.=0D
=0D
Thank you.=0D
=0D
Mike
