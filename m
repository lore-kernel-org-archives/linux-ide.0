From: "Maxim Gorbachyov" <maxim.gorbachyov@gmail.com>
Subject: Re: SATA DVD drive problem on ICH8M
Date: Fri, 21 Nov 2008 15:58:42 +0300
Message-ID: <291f35090811210458o38f45036s9063328bdaeea89b@mail.gmail.com>
References: <291f35090811140246y674de2b1p23a9a650f8c7ef3a@mail.gmail.com>
	 <491FE21C.7020904@kernel.org>
	 <291f35090811170047w7cade8aci2676a878168835df@mail.gmail.com>
	 <4926734A.5050707@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.228]:47310 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756216AbYKUM6o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Nov 2008 07:58:44 -0500
Received: by qb-out-0506.google.com with SMTP id f11so1033571qba.17
        for <linux-ide@vger.kernel.org>; Fri, 21 Nov 2008 04:58:43 -0800 (PST)
In-Reply-To: <4926734A.5050707@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Fri, Nov 21, 2008 at 11:37 AM, Tejun Heo <tj@kernel.org> wrote:

> Ehhh... I really don't have much idea at this point.  Does
> "libata.force=udma4" make any difference?  If not, how about
> "libata.force=pio4"?  Note that depending on your distro, you need to do
> different things to pass parameters to modules loaded from initrd.  If
> ahci is built into the kernel, simple libata.force=xxx on kernel boot
> prompt will do.
>
> Does the drive work in other environments (ie. windows)?

Well, something is clarified now.. I've just tried OpenBSD 4.4. It
started from that drive, but after ~1 minute of copying files from cd
kernel printed a complaint about the device and rebooted. So it seems
I have to update the drive firmware or the drive.. Thank you for
advice.
