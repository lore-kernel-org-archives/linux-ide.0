From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/2] ide: add CONFIG_IDE_ARCH_OBSOLETE_DEFAULTS
Date: Thu, 14 Feb 2008 22:12:40 +0100
Message-ID: <20080214211240.GI21894@uranus.ravnborg.org>
References: <200802142155.50893.bzolnier@gmail.com> <20080214205500.GE21894@uranus.ravnborg.org> <200802142224.22621.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:52616 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934317AbYBNVMb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Feb 2008 16:12:31 -0500
Content-Disposition: inline
In-Reply-To: <200802142224.22621.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> 
> I agree but this option is meant to be only temporary to ease the cleanup
> process.  We can think about the proper solution after default IDE ports
> initialization gets moved to ide_generic host driver.

Makes sense and agreed. (I hoped so - which is why I said "borderline").

	Sam
