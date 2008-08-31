From: Tejun Heo <tj@kernel.org>
Subject: Re: GA-MA790FX-DS5 SATA ahci NCQ erros on Jmicron 20360/20363		(JMB363)
 kernel 2.6.25-2 Debian/Lenny
Date: Sun, 31 Aug 2008 11:33:52 +0200
Message-ID: <48BA6580.8070206@kernel.org>
References: <g8p6po$nm$1@ger.gmane.org> <48B0916C.4080805@garzik.org> <g8q9mg$v2p$1@ger.gmane.org> <WorldClient-F200808241844.AA44240046@butn.net> <48B92846.7050004@kernel.org> <WorldClient-F200808302013.AA13360018@butn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49959 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905AbYHaJfI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 31 Aug 2008 05:35:08 -0400
In-Reply-To: <WorldClient-F200808302013.AA13360018@butn.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: xerces8 <xerces8@butn.net>
Cc: Sergey Spiridonov <sena@hurd.homeunix.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

xerces8 wrote:
> Tejun Heo wrote:
>=20
>> xerces8 wrote:
>>> My WD MyBook Studio Edition 500 GB external eSATA drive does not
>>> work on the JMB363 correctly no matter what I try. Both
>>> under linux and windows. I think the best was 30 minutes of
>>> (apparent) error free operation under windows.
>> This one is being discussed both with JMB and WD.  It seems the brid=
ge
>> chip used in the WD external drives is somehow incompatible with the
>> JMB ahci's.  Don't know whose fault it is or how it can be worked
>> around yet.  The issue is being tracked in the following bugzilla.
>>
>>   http://bugzilla.kernel.org/show_bug.cgi?id=3D9913
>=20
> I know, I'm David Bala=C5=BEic (the last commenter on bug, besides yo=
u) ;-)

Somehow I've been confusing people a lot lately.  I asked my AMD contac=
t
 a few times about sata_nv problems somehow thinking AMD acquired NVidi=
a
instead of ATI.  :-)

--=20
tejun
