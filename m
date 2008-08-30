From: "xerces8" <xerces8@butn.net>
Subject: Re: GA-MA790FX-DS5 SATA ahci NCQ erros on Jmicron 20360/20363
		(JMB363) kernel 2.6.25-2 Debian/Lenny
Date: Sat, 30 Aug 2008 20:13:36 +0200
Message-ID: <WorldClient-F200808302013.AA13360018@butn.net>
References: <g8p6po$nm$1@ger.gmane.org> <48B0916C.4080805@garzik.org> <g8q9mg$v2p$1@ger.gmane.org> <WorldClient-F200808241844.AA44240046@butn.net> <48B92846.7050004@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ikar.perftech.si ([195.246.0.20]:1371 "EHLO ikar.perftech.si"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107AbYH3SNn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Aug 2008 14:13:43 -0400
In-Reply-To: <48B92846.7050004@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sergey Spiridonov <sena@hurd.homeunix.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Tejun Heo wrote:

> xerces8 wrote:
> > My WD MyBook Studio Edition 500 GB external eSATA drive does not
> > work on the JMB363 correctly no matter what I try. Both
> > under linux and windows. I think the best was 30 minutes of
> > (apparent) error free operation under windows.
>=20
> This one is being discussed both with JMB and WD.  It seems the bridg=
e
> chip used in the WD external drives is somehow incompatible with the
> JMB ahci's.  Don't know whose fault it is or how it can be worked
> around yet.  The issue is being tracked in the following bugzilla.
>=20
>   http://bugzilla.kernel.org/show_bug.cgi?id=3D9913

I know, I'm David Bala=C5=BEic (the last commenter on bug, besides you)=
 ;-)

Regards,
David


