From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH] [resend] Resume from hibernation fails with pata_it821x RAID volume
Date: Sat, 7 Feb 2009 13:29:58 +0100
Message-ID: <200902071330.00779.linux@rainbow-software.org>
References: <200902061412.09839.linux@rainbow-software.org> <498C778B.7020309@ru.mvista.com> <20090206175635.5344ce37@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.atlantis.sk ([80.94.52.35]:46290 "EHLO mail.atlantis.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbZBGMaI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Feb 2009 07:30:08 -0500
In-Reply-To: <20090206175635.5344ce37@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 06 February 2009 18:56:35 Alan Cox wrote:
> >     See CodingStyle chapter 8 for the preferred multiline comment style.
> >
> > > +		memset(&id[ATA_ID_SERNO], 0x20, ATA_ID_SERNO_LEN);
> >
> >     Why not ' '?
> >
> > MBR, Sergei
>
> Digging into the docs the RAID serial number (and what that means isn't
> defined anywhere I can see) is byte offset 54-73 in each of the 4 128
> byte blocks returned by the chip status query we do at boot
> (it821x_probe_firmware).

Yes, found it there. But it seems to be the same number as present in the 
IDENTIFY data. It contains date and time of boot (matches RAID_SERIAL_NUMBER 
structure found in iteraid.h in driver source from ITE) instead of date and 
time of RAID creation.

-- 
Ondrej Zary
