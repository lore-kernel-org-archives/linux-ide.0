From: Jose Alberto Reguero <jareguero@telefonica.net>
Subject: Re: Problem with ahci and a external sata disk
Date: Fri, 7 Mar 2008 14:03:42 +0100
Message-ID: <200803071403.43113.jareguero@telefonica.net>
References: <200802191646.39277.jareguero@telefonica.net> <47CFA2E0.5030304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outmailhost.telefonica.net ([213.4.149.242]:42719 "EHLO
	ctsmtpout2.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757363AbYCGNDq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Mar 2008 08:03:46 -0500
In-Reply-To: <47CFA2E0.5030304@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

El Jueves, 6 de Marzo de 2008, Tejun Heo escribi=F3:
> Jose Alberto Reguero wrote:
> > When I try to make a ext3 fs in the disk I got a lot of erros:
>
> Can you please try 2.6.25-rc4 and see whether it behaves any
> differently.  The initial errors should be about the same but EH shou=
ld
> slow the PHY to 1.5Gbps quickly and that seems to solve many PHY rela=
ted
> problems on eSATA connectors.
>
> Thanks.

I try with kernel 2.6.25-rc4 but when the limiting speed to 1.5g the de=
vice=20
can't recover.
I try whith the option:
options libata force=3D4:1.5g
and works, but the speed is limited until:
ata4.00: limiting speed to UDMA/33:PIO4
and still have some errors.

Do you know what Transfer mode   I must try in  libata force to not hav=
e=20
erros?

Thanks.

Jose Alberto

hdparm -I

