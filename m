From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/2] Hyper-V disk support V3
Date: Mon, 16 Apr 2012 12:26:34 +0100
Message-ID: <20120416122634.7d1357e1@ultron>
References: <20120414170223.24f6ea31@pyramind.ukuu.org.uk>
	<1334575229-7493-1-git-send-email-apw@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:46902 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213Ab2DPL1T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Apr 2012 07:27:19 -0400
In-Reply-To: <1334575229-7493-1-git-send-email-apw@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Whitcroft <apw@canonical.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, Mike Sterling <Mike.Sterling@microsoft.com>

On Mon, 16 Apr 2012 12:20:27 +0100
Andy Whitcroft <apw@canonical.com> wrote:

> Add support for ignoring disks devices on specific host controllers to
> libata.  Use this support to trigger us to ignore Hyper-V disk devices
> on the emulated SATA device based on the system DMI information.
> 
> Jeff, I believe the first patch is what you had in mind in your comments.
> Alan, the piix sadly has no subvendor/subdevice identifiers at all

So its 0x0000,0x0000 ?

> though we are able to detect the platform from the DMI information,
> this any better?

What happens if you have a PIIX device which is being passed through from
the underlying hardware or will hyper-v never support pass through ?

Alan
