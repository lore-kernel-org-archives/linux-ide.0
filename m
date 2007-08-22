From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Problems with IDE on linux 2.6.22.X
Date: Wed, 22 Aug 2007 18:54:07 +0200
Message-ID: <46CC6A2F.5000406@gmail.com>
References: <200708212149.12912.jopan@alumni.uv.es> <46CB626F.8020801@gmail.com> <200708220339.45138.jopan@alumni.uv.es> <46CBA0F0.70503@gmail.com> <20070822122359.7ce8ddaa@the-village.bc.nu> <46CC5AE4.1090600@gmail.com> <20070822162312.GG9412@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:59973 "EHLO
	smtpq2.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760634AbXHVQ7C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 12:59:02 -0400
In-Reply-To: <20070822162312.GG9412@csclub.uwaterloo.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jos? Luis Pati?o Andr?s <jopan@alumni.uv.es>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On 08/22/2007 06:23 PM, Lennart Sorensen wrote:

> On Wed, Aug 22, 2007 at 05:48:52PM +0200, Rene Herman wrote:

>> He has a SATA harddrive and an IDE DVD drive. When he compiles with=20
>> CONFIG_ATA_PIIX (a driver which advertises both SATA and PATA in its=
=20
>> description) his drive works, his DVD does not. Is that not the corr=
ect=20
>> driver? Does he need something else? How does he get his DVD to work=
?
>=20
> Well of course the DVD should show up as /dev/sr0 or scd0 with the ne=
w
> driver, not the /dev/hd? name.  And scsi cdrom support is required to=
o.

Obviously. Looking back through the report, him having SCSI CD-ROM supp=
ort=20
wasn't actually explicit so that might in fact be the problem but his=20
self-compiled 2.6.20.15 worked and a 2.6.22 based Open SuSE Live CD doe=
s not=20
(and he does have SCSI disk support, which suggests he will've likely a=
lso=20
have thought of SCSI CD-ROM support) so it does not seem to be.

Jos=E9: do you have SCSI CD-ROM support compiled in? What are the ATA/S=
CSI=20
related messages in the output of "dmesg" when you compile with the=20
CONFIG_ATA_PIIX driver, SCSI disk and SCSI CD-ROM support (and nothing =
from=20
the old IDE menu)?

Rene.

