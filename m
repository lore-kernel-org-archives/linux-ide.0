From: Lionel Bouton <Lionel.Bouton@inet6.fr>
Subject: Re: [PATCH] sis5513 fix for SiS962 chipset
Date: Fri, 10 Sep 2004 16:53:19 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4141BFDF.1050200@inet6.fr>
References: <1094826555.7868.186.camel@thomas.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www02.ies.inet6.fr ([62.210.153.202]:25749 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S267445AbUIJOxX
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Sep 2004 10:53:23 -0400
In-Reply-To: <1094826555.7868.186.camel@thomas.tec.linutronix.de>
List-Id: linux-ide@vger.kernel.org
To: tglx@linutronix.de
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

Thomas Gleixner wrote the following on 09/10/2004 04:29 PM :

>Hi,
>
>1. If the fake 5513 id bit is not set by the BIOS we must have the 5518
>id in the device table.
>
>2. If the register remapping is not set by the BIOS then the enable bit
>check in ide_pci_setup_ports will fail. It's safe to switch to the
>remapping mode here. Keeping the not remapped mode would need quite big
>changes AFAICS.
>  
>

I was worried about these when 5518 was introduced but couldn't test on 
the hardware I had at hand and nobody reported hitting this so it went 
under the carpet. What hardware did you use to test ?

-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
   o              Siege social: 51, rue de Verdun - 92158 Suresnes
  /      _ __ _   Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
 / /\  /_  / /_   France
 \/  \/_  / /_/   Tel. +33 (0) 1 41 44 85 36
  Inetsys S.A.    Fax  +33 (0) 1 46 97 20 10
 

