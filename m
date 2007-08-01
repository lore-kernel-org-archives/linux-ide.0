From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Access beyond end of device
Date: Wed, 1 Aug 2007 17:03:57 +0100
Message-ID: <20070801170357.7fefb40a@the-village.bc.nu>
References: <20070731150414.0d73c22c@localhost>
	<20070731151546.77ef23d9@localhost>
	<20070801011226.2b2a7952@the-village.bc.nu>
	<20070801111734.2621fb46@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45708 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759872AbXHAP5n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 11:57:43 -0400
In-Reply-To: <20070801111734.2621fb46@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: linux-ide@vger.kernel.org

>  Ok, the disk has a host protected area and now I'm telling libata to
> disable it.
> 
>  The error messages has disappeared.
> 
>  But... Is it safe to do it? I've read somewhere that the BIOS and
> other softwares may use that area.

On some systems. Its also used for different things on others (rounding
off disk sizes nicely, clipping to avoid bios limits etc)


>  Also, I remember that with the IDE driver I wasn't seeing that
> messages, which means either: it was disabling it by default or
> was just ignoring it.

Old IDE disables it by default, libata is more conservative. Personally I
think libata should disable it by default too but thats an argument to
have with Jeff
