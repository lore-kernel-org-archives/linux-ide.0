From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: PATCH: (Test) it8212 driver for 2.6.9rc3
Date: Thu, 30 Sep 2004 22:45:18 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200409302245.18866.bzolnier@elka.pw.edu.pl>
References: <20040930184535.GA31197@devserv.devel.redhat.com> <200409302218.48115.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:31685 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269498AbUI3UpW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Sep 2004 16:45:22 -0400
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:48812 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S30490AbUI3UpV (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Thu, 30 Sep 2004 22:45:21 +0200
Received: from chello084010012196.chello.pl ([84.10.12.196]:63913 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S72757AbUI3UnU (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 2 others);
	Thu, 30 Sep 2004 22:43:20 +0200
In-Reply-To: <200409302218.48115.bzolnier@elka.pw.edu.pl>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


[ I was so shocked that I forgot about it ]

Please

- merge+describe needed IDE core changes
- fix coding style and whitespace damage
- kill useless DECLARE_ITE_DEV macro
- add __init to it8212_ide_init()

and I will _happily_ merge this driver into ide-dev-2.6.

Thanks,
Bartlomiej
