From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: Access beyond end of device
Date: Wed, 1 Aug 2007 11:17:34 -0300
Message-ID: <20070801111734.2621fb46@localhost>
References: <20070731150414.0d73c22c@localhost>
	<20070731151546.77ef23d9@localhost>
	<20070801011226.2b2a7952@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:45619 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473AbXHAORo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 10:17:44 -0400
In-Reply-To: <20070801011226.2b2a7952@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Em Wed, 1 Aug 2007 01:12:26 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> escreveu:

| On Tue, 31 Jul 2007 15:15:46 -0300
| "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:
| 
| > Em Tue, 31 Jul 2007 15:04:14 -0300
| > "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> escreveu:
| > 
| > |  Since I've started using the pata_via driver in 2.6.22, I'm getting
| > | zillions of these messages:
| > | 
| > | """
| > | attempt to access beyond end of device
| > | sda: rw=0, want=156367809, limit=156365903
| > | printk: 22 messages suppressed
| > | Buffer I/O error on device sda1, logical block 78183872
| 
| Does your disk have a host protected area set and if so are you telling
| libata to disable it ?

 Ok, the disk has a host protected area and now I'm telling libata to
disable it.

 The error messages has disappeared.

 But... Is it safe to do it? I've read somewhere that the BIOS and
other softwares may use that area.

 Also, I remember that with the IDE driver I wasn't seeing that
messages, which means either: it was disabling it by default or
was just ignoring it.

-- 
Luiz Fernando N. Capitulino
