From: "Oliver.Korpilla@gmx.de" <Oliver.Korpilla@gmx.de>
Subject: Re: [SATA] SATA_SIL and ATI SB400 chipset
Date: Tue, 08 Mar 2005 12:22:25 +0100
Message-ID: <422D8AF1.6040107@gmx.de>
References: <Pine.LNX.4.44.0503071842240.4791-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from mail.gmx.de ([213.165.64.20]:52378 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262004AbVCHLWh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Mar 2005 06:22:37 -0500
In-Reply-To: <Pine.LNX.4.44.0503071842240.4791-100000@coffee.psychology.mcmaster.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-ide@vger.kernel.org

Mark Hahn wrote:
>>Problem is, I want to do an install from the Sarge netinstall media to get a
>>full AMD64-compatible install. If I load the SATA_SIL module there, no
> 
> so you should get the debian people to fix their bug - 
> amd64 doesn't use a different sata_sil driver than ia32, of course!

I wasn't implying that - I thought there could be the possibility to 
override the module probe parameters.

>>being loaded correctly, with the same parameters it recognizes the hardware
>>when booted with kernel 2.6.11.
> 
> to me it sounds like your random debian kernel is just broken.
> in general, no module parameters should ever be needed.
> 

That seems to be correct - I did help me out with an PATA drive, made an 
install, fixed a vanilla 2.6.11 onto it, and all runs perfectly well, 
except it only seems to scans two of my four SATA ports. But it boots 
and runs smoothly, so that's nice enough.

So if needed I will produce my own boot disk, that's fine enough! :)

Do you think my controller is limited to doing a mode of UDMA/100 when 
the drive reports as UDMA/133 capable, but then is reported with less. 
Or is this inherent to the SATA_SIL driver?

I guess it's not a bad thing to archive into a Linux list that the 
RS480M2-IL motherboard's SATA controller works with SATA_SIL driver, as 
it uses the ATI SB400 Chipset. ;) :)

Thanks and with kind regards,
Oliver Korpilla
