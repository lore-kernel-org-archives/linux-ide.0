From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Linux v2.6.9... (compile stats)
Date: Wed, 20 Oct 2004 22:37:10 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <417720D6.1030908@pobox.com>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> <1098196575.4320.0.camel@cherrybomb.pdx.osdl.net> <20041019161834.GA23821@one-eyed-alien.net> <1098310286.3381.5.camel@cherrybomb.pdx.osdl.net> <20041020224106.GM23987@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0410201710370.2317@ppc970.osdl.org> <41770307.5060304@pobox.com> <20041021015522.GH23987@parcelfarce.linux.theplanet.co.uk> <41771813.8090204@pobox.com> <20041021022442.GI23987@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S270332AbUJUCk1@vger.kernel.org>
In-Reply-To: <20041021022442.GI23987@parcelfarce.linux.theplanet.co.uk>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, John Cherry <cherry@osdl.org>, Matthew Dharm <mdharm-kernel@one-eyed-alien.net>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> IDGI.  Why do you insist on releasing these guys in library code?  Even

Because there are two distinct and separate models of port mapping/usage:

1) A bunch of separate IO address spaces (PIO).  The "mapping" is 
currently done in ata_pci_init_native_mode() and ata_pci_init_legacy_mode()

2) One single linear address space (MMIO).  The mapping is done in the 
low-level driver.

#1 is in the library because the logic is duplicated _precisely_, across 
multiple host controllers, according to a hardware specification.

Thus, if the mapping is done in the library core, so should the unmapping.

	Jeff
