From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: SATA II NCQ and multi-port support for ICH7
Date: Fri, 24 Jul 2009 15:16:48 +0200
Message-ID: <87prbqdxvj.fsf@nemi.mork.no>
References: <0KN6003ZATOVGH70@vms173017.mailsrvcs.net>
	<4A674306.9040305@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:36186 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752886AbZGXNUG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Jul 2009 09:20:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MUKgt-0007yN-0K
	for linux-ide@vger.kernel.org; Fri, 24 Jul 2009 13:20:03 +0000
Received: from ti521110a080-0785.bb.online.no ([80.213.51.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 24 Jul 2009 13:20:02 +0000
Received: from bjorn by ti521110a080-0785.bb.online.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 24 Jul 2009 13:20:02 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> ICH7 chip usually supports both legacy IDE and native AHCI modes.

No.  Only the ICH7DH, ICH7R and ICH7-M variants support AHCI.  See
http://www.intel.com/design/chipsets/datashts/307013.htm

http://www.intel.com/support/chipsets/imst/sb/cs-012304.htm lists the
Intel controller hubs with AHCI support.  Please note that this list do=
es
*not* include ICH7, ICH8, ICH9 or ICH10 (i.e. the "plain" desktop
variants).

This has been discussed here a number of times before.  See e.g.
http://www.mail-archive.com/linux-ide@vger.kernel.org/msg02213.html

Note that you may be lucky and able to work around the problem.  It
seems that this is mostly a license restriction, preventing the
motherboard manufacturers from providing an AHCI mode in the BIOS
setup.=20

Matthew Garret has made an AHCI force quirking patch for those lacking
an AHCI option: http://mjg59.livejournal.com/85504.html
I don't know if this will work with a plain ICH7.

Another option is fixing the BIOS.  I'm successfully running an ICH9 in
AHCI mode by using a BIOS meant for an identical motherboard with an
ICH9R (The motherboards in question are Asus P5K and P5KR).  But that
sort of flashing experiments are of course risky and not recommended...
It's probably better to buy a new motherboard without destroying the ol=
d
one first :-)

Just remember to pay the extra 10 dollars for the "R".


Bj=C3=B8rn

