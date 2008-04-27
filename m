From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
Subject: Re: 2.6.25-mm1 (no disks with sata_nv)
Date: Sat, 26 Apr 2008 20:23:57 -0700
Message-ID: <29495f1d0804262023m34dd1769tef6a8ca0cee0290d@mail.gmail.com>
References: <29495f1d0804261912k584cb68p36f4b9e5401afbb8@mail.gmail.com>
	 <20080427025547.GC24710@havoc.gtf.org>
	 <29495f1d0804262003p6e24ef5cpfe21d7f9f1e4f75b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:26393 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbYD0DX7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Apr 2008 23:23:59 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4319713fgb.17
        for <linux-ide@vger.kernel.org>; Sat, 26 Apr 2008 20:23:57 -0700 (PDT)
In-Reply-To: <29495f1d0804262003p6e24ef5cpfe21d7f9f1e4f75b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 4/26/08, Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
> On 4/26/08, Jeff Garzik <jeff@garzik.org> wrote:
>  > On Sat, Apr 26, 2008 at 07:12:58PM -0700, Nish Aravamudan wrote:
>  >  >
>  >  > While trying to test the hugepage changes pending for -mm, I found
>  >  > that none of my 4 disks attached to
>  >  >
>  >  > nVidia Corporation CK804 Serial ATA Controller (rev f3)
>  >  >
>  >  > come up (and thus I am dropped to an initramfs shell). The driver is
>  >  > loading and indicates a link up on all 4 ports that are involved, but
>  >  > I see no sd/sdX messages like I do with 2.6.25 (which I'm using right
>  >  > now). I've started the bisection, but if Jeff or anyone has any ideas,
>  >  > I'd appreciate it. I don't have a serial console on this box, and no
>  >  > oops is produced. .configs from 2.6.25 and 2.6.25-mm1 attached.
>  >
>  >
>  > Should be fixed in upstream, so I presume it will appear when Andrew
>  >  next updates his kernel to the latest upstream.
>
>
> Ah great -- do you have a single patch I can apply that will fix it so
>  I can test? (FWIW, reverting the git-libata-all patch from -mm got me
>  booting). Should I assume it's a sata_nv only commit I can cherry-pick
>  over?

I'm guessing it's: a0b9f4bc1ec2ea25e47e7958e544fef0d122e012 ?

Thanks,
Nish
