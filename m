From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ahci_softreset implementation
Date: Thu, 4 Oct 2007 21:47:39 +0100
Message-ID: <20071004214739.11a96189@the-village.bc.nu>
References: <op.tzorgqkomy2jnb@celina>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34543 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757535AbXJDUnx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 16:43:53 -0400
In-Reply-To: <op.tzorgqkomy2jnb@celina>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Jakub W. =?UTF-8?B?SsOzxbp3aWNraQ==?=" <jozwicki@aster.pl>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Thu, 04 Oct 2007 20:39:52 +0200
Jakub W. J=C3=B3=C5=BAwicki <jozwicki@aster.pl> wrote:

>=20
> Hello,
> Recently I have bought mainboard with AMD/ATI 690 + SB600.
> 2 Seagate 250GB SATA drives are connected. They work with Linux with
> AHCI without any problem, I have RAID1 on them.
> I've been trying to install Solaris on them, however when 2 drives
> are connected one is not visible to OS.
> Could you look at Solaris code and tell if I should fill them a bug-r=
eport?

If you are running Solaris and it doesn't work then yes I would file a
bug report - and mention the Linux one does as that'll help them work o=
ut
whats up.

Alan
--
My Git tree is full of regressions
My Git tree is full of bad C
My Git tree is full of regressions
Oh Git-clone my codebase and see
