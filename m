From: Tejun Heo <htejun@gmail.com>
Subject: Re: Fixing halt/shutdown for libata spindown handling
Date: Tue, 15 May 2007 10:20:23 +0200
Message-ID: <46496D47.9010504@gmail.com>
References: <46492931.4080700@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:42621 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756184AbXEOIU4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2007 04:20:56 -0400
Received: by nz-out-0506.google.com with SMTP id r28so52599nza
        for <linux-ide@vger.kernel.org>; Tue, 15 May 2007 01:20:56 -0700 (PDT)
In-Reply-To: <46492931.4080700@gentoo.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-ide@vger.kernel.org

Hello, Daniel.

Daniel Drake wrote:
> I was surprised to find that the /sbin/halt spin down implementation is
> very limited, it only works for IDE disks (by working through
> /proc/ide). This doesn't make sense to me, the libata commits state that
> userspace shutdown is spinning down libata disks.
> 
> So, this means that other distro's do it differently? I'd appreciate
> some pointers to what happens elsewhere.

Debian (and thus probably ubuntu) issues STADNBYNOW without FLUSH.
Opensuse doesn't seem to do anything and there's another distro which
does both, not sure which tho.  Hmm... If the upstream sysvinit code
doesn't contain spindown code, it's more likely we have more distros
which don't do anything.  If that's the case, it will be worthwhile to
detect that STANDBYNOW isn't issued and skip compat checking and just do
it.  I'll come up with a patch, please wait a bit before releasing the
update.

[--snip--]
> If I'm right and Gentoo is currently not spinning down SCSI/libata
> disks, the only /sbin/halt modification required is to write 0 into
> /sys/modules/libata/parameters/spindown_compat right?

Yes, that will make all kernels from now on behave correctly, but doing
FLUSH CACHE followed by STANDBYNOW on older kernels (kernels without
manage_start_stop) would help.

> Final question: should spindown_compat be set to 0 for both shutdown and
> reboot, or just shutdown?

It doesn't really matter.  It just needs to be set while powering down.
 You can set it anywhere, during boot, in shutdown.

Thanks.

-- 
tejun
