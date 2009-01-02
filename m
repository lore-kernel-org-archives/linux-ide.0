From: Tejun Heo <tj@kernel.org>
Subject: Re: AHCI problem with hotplug
Date: Fri, 02 Jan 2009 12:12:06 +0900
Message-ID: <495D8606.5070807@kernel.org>
References: <494178E3.6030305@cybernetics.com> <49588784.4020808@kernel.org> <4958E3DC.7080009@cybernetics.com> <49591710.7040102@shaw.ca> <49596D9E.3040904@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35875 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702AbZABDMV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Jan 2009 22:12:21 -0500
In-Reply-To: <49596D9E.3040904@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Tony Battersby <tonyb@cybernetics.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

Tejun Heo wrote:
> This is consistent with the BIOS tristating those ports.  I don't
> remember the name of the register.  I'll look it up later.

Yeah, the PCS register.  From ICH8 datasheet (ICH7 datasheet doesn't
have the following paragraph but it's what the BIOS is supposed to do
all the same).

  If an AHCI-aware or RAID enabled operating system is being booted
  then system BIOS shall insure that all supported SATA ports are
  enabled prior to passing control to the OS. Once the AHCI aware OS
  is booted it becomes the enabling/disabling policy owner for the
  individual SATA ports. This is accomplished by manipulating a port=E2=
=80=99s
  PxSCTL and PxCMD fields. Because an AHCI or RAID aware OS will
  typically not have knowledge of the PxE bits and because the PxE
  bits act as master on/off switches for the ports, pre- boot software
  must insure that these bits are set to =E2=80=981=E2=80=99 prior to b=
ooting the OS,
  regardless as to whether or not a device is currently on the port.

Can you please post the output of "lpsci -nnvvvxxx"?

--=20
tejun
