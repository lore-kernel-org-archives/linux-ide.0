From: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Subject: Re: Via SATA not working here
Date: Sun, 6 Feb 2005 00:41:38 +0100
Message-ID: <20050205234138.GN588@uvt316-2.ruk.cuni.cz>
References: <20040912191542.GO21202@uvt316-2.ruk.cuni.cz> <414520BB.3080306@wasp.net.au> <20040914094336.GG18257@uvt316-2.ruk.cuni.cz> <311601c90409140803aaa4d31@mail.gmail.com> <20040914175448.GK18257@uvt316-2.ruk.cuni.cz> <4147331A.8040907@pobox.com> <41474D2F.6060201@wasp.net.au> <20050205150349.GB17295@uvt316-2.ruk.cuni.cz> <4204E749.2070602@stesmi.com>
Reply-To: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from dec59.ruk.cuni.cz ([195.113.2.17]:28170 "HELO dec59.ruk.cuni.cz")
	by vger.kernel.org with SMTP id S271478AbVBEXqM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Feb 2005 18:46:12 -0500
Content-Disposition: inline
In-Reply-To: <4204E749.2070602@stesmi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: linux-ide@vger.kernel.org

On Sat, Feb 05, 2005 at 04:33:29PM +0100, Stefan Smietanowski wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> It is not using scsi emulation. It is using the scsi subsystem in
> the linux kernel instead of the ide subsystem. More and more
> drivers are being written for "libata". And less and less in this
> is actually SATA specific anymore. That is why we are starting
> to see drivers that drive both sata and pata (promise for instance
> in the libata-dev tree). Also note that if I understand correctly
> libata will ultimately not use the scsi subsystem but the block
> subsystem (that doesn't really exist yet). The way I see it
Thanks for explanation. Hopefully it will happen soon :)

> libata is the new way to do it right, and in which you can fit
> any pata and/or sata driver. My personal goal is when we can
> have one name-space between scsi and [sp]ata but that's not
> here yet with many drivers only existing for the old/normal
> ide susbystem, but that might/will change.
> 
That would be a good thing. Especially if cdrecord/smartctl/hdparm was
ported to it so that it could use all features of the drive
independently of the bus to which it is connected.

Thanks

Michal Suchanek
