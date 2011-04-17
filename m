From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 3/4] ata: Add and use ata_print_version_once
Date: Sun, 17 Apr 2011 13:56:26 -0700
Message-ID: <1303073786.31723.14.camel@Joe-Laptop>
References: <cover.1302907496.git.joe@perches.com>
	 <440aa7f6bb99bec705b83796894f843bfc1b7bf9.1302907497.git.joe@perches.com>
	 <BANLkTikeV-jHXWSDyLmtTTc1d2S9L3eG0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.perches.com ([173.55.12.10]:4784 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838Ab1DQU42 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 17 Apr 2011 16:56:28 -0400
In-Reply-To: <BANLkTikeV-jHXWSDyLmtTTc1d2S9L3eG0Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org

On Sun, 2011-04-17 at 13:45 +0300, saeed bishara wrote: 
> On Sat, Apr 16, 2011 at 1:52 AM, Joe Perches <joe@perches.com> wrote:
> > Use a single mechanism to show driver version.
> > Reduces text a tiny bit too.
> > Remove uses of static int printed_version
> > Add and use ata_print_version(const struct device *, const char *ver)
> > and ata_print_version_once.
> any idea why we really need this driver version for in-kernel drivers?
> isn't the kernel version good enough?

Some think it useful to see what module
version is linked against the kernel.

