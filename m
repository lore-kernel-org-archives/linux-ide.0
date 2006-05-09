From: Nicolas STRANSKY <Nico@stransky.cx>
Subject: Re: IRQ problem with sata_sil
Date: Tue, 09 May 2006 07:39:34 +0200
Message-ID: <e3p9um$nn8$1@sea.gmane.org>
References: <e3n4ru$ktd$1@sea.gmane.org> <dd43dcfb0605080319t59c8d152lc12f872917d9c8bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:41160 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751394AbWEIFjw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 May 2006 01:39:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FdKwi-00026B-HK
	for linux-ide@vger.kernel.org; Tue, 09 May 2006 07:39:44 +0200
Received: from fbx.stransky.cx ([82.67.244.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 09 May 2006 07:39:44 +0200
Received: from Nico by fbx.stransky.cx with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 09 May 2006 07:39:44 +0200
In-Reply-To: <dd43dcfb0605080319t59c8d152lc12f872917d9c8bf@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Le 05/08/2006 12:19 PM, Paul M. a =E9crit :
> I had a similar error with my system's on board SI controller while
> accessing a 3ware controller at high speeds. Personally I'm probably
> going to avoid the whole problem and try to boot from the 3ware array=
=2E

IMO the two problems are unrelated because here the error appears just
when inserting the module and because of an IRQ mess, not because of bi=
g
file transfers..

--=20
Nico
Le signe "oui" est d'un homme qui s'endort ;
au contraire, le r=E9veil secoue la t=EAte et dit non.
	-+- =C9mile Chartier, dit Alain (1868-1951) -+-

