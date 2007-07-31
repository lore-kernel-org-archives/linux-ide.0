From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: Access beyond end of device
Date: Tue, 31 Jul 2007 15:15:46 -0300
Message-ID: <20070731151546.77ef23d9@localhost>
References: <20070731150414.0d73c22c@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:35817 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761451AbXGaSPz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jul 2007 14:15:55 -0400
In-Reply-To: <20070731150414.0d73c22c@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

Em Tue, 31 Jul 2007 15:04:14 -0300
"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> escreveu:

|  Since I've started using the pata_via driver in 2.6.22, I'm getting
| zillions of these messages:
| 
| """
| attempt to access beyond end of device
| sda: rw=0, want=156367809, limit=156365903
| printk: 22 messages suppressed
| Buffer I/O error on device sda1, logical block 78183872
| ...
| """
| 
|  It also does happen with 2.6.23-rc3.

 Heh, I'm pretty advanced, I meant 2.6.23-rc1.

-- 
Luiz Fernando N. Capitulino
