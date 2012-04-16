From: Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH 0/2] Hyper-V disk support V3
Date: Mon, 16 Apr 2012 19:29:27 +0100
Message-ID: <20120416182927.GB3346@shadowen.org>
References: <20120414170223.24f6ea31@pyramind.ukuu.org.uk>
 <1334575229-7493-1-git-send-email-apw@canonical.com>
 <20120416122634.7d1357e1@ultron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40628 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861Ab2DPS3f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Apr 2012 14:29:35 -0400
Content-Disposition: inline
In-Reply-To: <20120416122634.7d1357e1@ultron>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, Mike Sterling <Mike.Sterling@microsoft.com>

On Mon, Apr 16, 2012 at 12:26:34PM +0100, Alan Cox wrote:
> On Mon, 16 Apr 2012 12:20:27 +0100
> Andy Whitcroft <apw@canonical.com> wrote:
> 
> > Add support for ignoring disks devices on specific host controllers to
> > libata.  Use this support to trigger us to ignore Hyper-V disk devices
> > on the emulated SATA device based on the system DMI information.
> > 
> > Jeff, I believe the first patch is what you had in mind in your comments.
> > Alan, the piix sadly has no subvendor/subdevice identifiers at all
> 
> So its 0x0000,0x0000 ?
> 
> > though we are able to detect the platform from the DMI information,
> > this any better?
> 
> What happens if you have a PIIX device which is being passed through from
> the underlying hardware or will hyper-v never support pass through ?

A good question indeed.  KY perhaps you can comment.

-apw
