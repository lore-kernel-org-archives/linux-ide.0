From: Sander <sander@humilis.net>
Subject: Re: Drives missing at boot
Date: Tue, 6 Jul 2010 13:26:50 +0200
Message-ID: <20100706112650.GA28794@attic.humilis.net>
References: <AANLkTinBn35687znO2_IxI3s1opkXrG2HpCRgsejNbMq@mail.gmail.com>
 <4C2F87C1.8000701@hardwarefreak.com>
 <AANLkTimVJEO-yF3GZ2ghX6DNPuAu-A-MNNO9x8Q1EpRc@mail.gmail.com>
 <4C2F9292.708@hardwarefreak.com>
 <AANLkTikPsRvvpSZirSygnZqyGKcS-Bz0eVeASZZqvZwH@mail.gmail.com>
 <AANLkTintf2mwgBVuk_4GmfHTzyJebP2kyfcNGij_epy-@mail.gmail.com>
 <4C31796C.8050209@kernel.org>
 <AANLkTinvNGha7SfaAWYIjUJwR9ZelCbHAWK0qvvllF9S@mail.gmail.com>
 <4C3271FF.9080308@gmail.com>
 <AANLkTilAvJUthkXM7KL9BhLwEv9kJn31Rs8wDTAe4PlY@mail.gmail.com>
Reply-To: sander@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www.humilis.net ([82.95.169.224]:57002 "EHLO attic.humilis.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794Ab0GFLg3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jul 2010 07:36:29 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTilAvJUthkXM7KL9BhLwEv9kJn31Rs8wDTAe4PlY@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Knecht <markknecht@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Tejun Heo <tj@kernel.org>, Stan Hoeppner <stan@hardwarefreak.com>, Linux Kernel List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Mark Knecht wrote (ao):
> On Mon, Jul 5, 2010 at 4:59 PM, Robert Hancock <hancockrwd@gmail.com> wrote:
> > On some machines changing from IDE to AHCI messes up the boot order
> > selection in the BIOS - you may have to switch to AHCI, save settings,
> > reboot, go back into the BIOS and then make sure the disk boot order
> > settings are correct (whatever drive grub is installed on needs to be
> > first).
> 
> That's a very interesting idea Robert. Thanks.
> 
> I'll have to be careful. I have 5 identical drives in the machine so
> figuring out which is which when I'm in BIOS might be a bit of a
> trick.
> 
> I'll give it a go and report back.

You can install grub on the mbr of all disks and not worry about the
order. Especially if you work with UUIDs.

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
