From: Alan Cox <alan@redhat.com>
Subject: Re: ata-piix.c (and libata.ko) in RHEL5.1 (build 78 currently) - this kernel is 2.6.18 baqsed
Date: Fri, 22 Feb 2008 10:10:10 -0500
Message-ID: <20080222151010.GC30920@devserv.devel.redhat.com>
References: <6853F62BE9A693419863D51D4554A9E3012BE92B@EXNA.corp.stratus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:57299 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041AbYBVPYd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Feb 2008 10:24:33 -0500
Content-Disposition: inline
In-Reply-To: <6853F62BE9A693419863D51D4554A9E3012BE92B@EXNA.corp.stratus.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>
Cc: jgarzik@pobox.com, alan@redhat.com, "Petrakis, Peter" <Peter.Petrakis@stratus.com>, "Duval, Dan" <Dan.Duval@stratus.com>, "Dailey, Nate" <Nate.Dailey@stratus.com>, linux-ide@vger.kernel.org

On Fri, Feb 22, 2008 at 09:52:45AM -0500, Richardson, Charlotte wrote:
> There is a hack in its probe routine that disables this. I've disabled the hack and ran a long test of
> hotplugs yesterday (added and removed a DVD drive connected to the ESB2 IDE - this is Intel
> device 0x269E) for 26 cycles, and it all appears to function properly. There are other things that do

It ought to work fine for ICH4 or so and later (older ICH you can only warm
plug). Be sure to test the released RHEL as I know the dev tree has completely
broken all hot plug disk support and hangs a lot if you do. Jeff I assume
knows the status of fixing that.

