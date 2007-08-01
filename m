From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Access beyond end of device
Date: Wed, 1 Aug 2007 01:12:26 +0100
Message-ID: <20070801011226.2b2a7952@the-village.bc.nu>
References: <20070731150414.0d73c22c@localhost>
	<20070731151546.77ef23d9@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55912 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751610AbXHAAGM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jul 2007 20:06:12 -0400
In-Reply-To: <20070731151546.77ef23d9@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: linux-ide@vger.kernel.org

On Tue, 31 Jul 2007 15:15:46 -0300
"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:

> Em Tue, 31 Jul 2007 15:04:14 -0300
> "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> escreveu:
> 
> |  Since I've started using the pata_via driver in 2.6.22, I'm getting
> | zillions of these messages:
> | 
> | """
> | attempt to access beyond end of device
> | sda: rw=0, want=156367809, limit=156365903
> | printk: 22 messages suppressed
> | Buffer I/O error on device sda1, logical block 78183872

Does your disk have a host protected area set and if so are you telling
libata to disable it ?
