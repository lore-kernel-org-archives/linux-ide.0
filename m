From: Balazs Ree <ree@ree.hu>
Subject: Re: unable to set udma >= 3 on ich5 on 2.6.11
Date: Tue, 21 Jun 2005 19:50:48 +0200
Message-ID: <pan.2005.06.21.17.50.40.495619@ree.hu>
References: <564d96fb05062005064283caaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:57507 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262222AbVFUSCj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jun 2005 14:02:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Dkmy4-00076U-2R
	for linux-ide@vger.kernel.org; Tue, 21 Jun 2005 19:55:26 +0200
Received: from 3e44bdc0.adsl.enternet.hu ([62.68.189.192])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 21 Jun 2005 19:55:24 +0200
Received: from ree by 3e44bdc0.adsl.enternet.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 21 Jun 2005 19:55:24 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Mon, 20 Jun 2005 09:06:06 -0300  Rafael Esp=EDndola wrote:

> Does someone has a suggestion before I start adding prinks to piix.c?=
  :)

Just a blind guess... you might
want to try to set the kernel parameter CONFIG_IDEDMA_IVB (IGNORE
word93 Validation BITS). I had this problem recently and this was
the one that solved it. But I am not an expert so pardon me if I said
something stupid.

--=20
Bala'zs REE' jabber + email: ree@ree.hu
             ICQ: 75955071   AIM + skype: reebalazs


