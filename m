From: Timur Tabi <timur@freescale.com>
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
Date: Tue, 7 Apr 2009 19:36:23 -0500
Message-ID: <ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>
References: <49DB6914.1030107@freescale.com> <49DBE858.9040004@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:61353 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759983AbZDHAgZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2009 20:36:25 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3308993qwh.37
        for <linux-ide@vger.kernel.org>; Tue, 07 Apr 2009 17:36:24 -0700 (PDT)
In-Reply-To: <49DBE858.9040004@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Linux PPC Development <linuxppc-dev@ozlabs.org>

On Tue, Apr 7, 2009 at 6:57 PM, Tejun Heo <tj@kernel.org> wrote:

> Hmmm... that means intx isn't set by default. =A0I'm not sure what is
> the right thing to do here. =A0I think it's something which should be
> handled by the PCI layer. =A0Oh well, maybe we should just revert the
> change and keep setting intx?

cc'ing linuxppc-dev

I really don't know what should be done.  It seems to make sense to
have the PCI layer enable interrupts.

This seems to be a powerpc-specific bug, but I don't know enough of
the PCI subsystem.

--=20
Timur Tabi
Linux kernel developer at Freescale
