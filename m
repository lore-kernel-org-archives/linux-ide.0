From: "Conke Hu" <conke.hu@amd.com>
Subject: RE: AHCI should try to claim all AHCI controllers
Date: Wed, 1 Nov 2006 21:39:23 +0800
Message-ID: <FFECF24D2A7F6D418B9511AF6F358602F2D2C0@shacnexch2.atitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:38748 "EHLO
	outbound2-blu-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1946846AbWKANji convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Nov 2006 08:39:38 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Thank you, Jeff.
But who should be the "Signed-off-by" man when I create a patch and rea=
dy for sending it to kernel org?

Best regards,
Conke @ AMD, Inc.



-----Original Message-----
=46rom: Jeff Garzik [mailto:jgarzik@pobox.com]=20
Sent: 2006=C4=EA11=D4=C21=C8=D5 13:11
To: Conke Hu
Cc: torvalds@osdl.org; linux-kernel@vger.kernel.org; linux-ide@vger.ker=
nel.org
Subject: Re: AHCI should try to claim all AHCI controllers

Conke Hu wrote:
> Hi all,
> 	According to PCI 3.0 spec, ACHI's PCI class code is 0x010601,
> and I suggest the ahci driver had better try to claim all ahci
> controllers, pls see the following patch:

BTW, make sure to always include a Signed-off-by: line in every patch.

See http://linux.yyz.us/patch-format.html and=20
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt and=20
Documentation/SubmittingPatches (in the kernel source tree).

	Jeff





