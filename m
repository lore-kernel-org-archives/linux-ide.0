From: Michal Piotrowski <michal.k.k.piotrowski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [2/3] 2.6.22-rc3: known regressions with patches
Date: Tue, 29 May 2007 14:53:39 +0200
Message-ID: <465C2253.4070307__156.865656799887$1180443324$gmane$org@googlemail.com>
References: <465C203A.1020200@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <465C203A.1020200-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Collins <bcollins-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org>, yoshfuji-VfPWfsRibaP+Ru+s062T9g@public.gmane.org, Maximilian Engelhardt <maxi-OwNUvPV92VfddJNmlsFzeA@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, developers-wuQACbhaE+jYtjvyW6yDsg@public.gmane.org, =?ISO-8859-2?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink-Mmb7MZpHnFY@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Tejun Heo <htejun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jeff Garzik <jeff-o2qLIJkoznsdnm+yROfE0A@public.gmane.org>, Francis Russell <francisrussell-LfUFBbCNao6Ide+eSLyLAQ@public.gmane.org>, Alan Cox <alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, "Horst H. von Brand" <vonbrand-0F290kgVbvxip2iK3AC5Mw@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hi all,

Here is a list of some known regressions in 2.6.22-rc3
with patches available.

=46eel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



Networking

Subject    : Oops with prism54 in 2.6.22-rc3
References : http://lkml.org/lkml/2007/5/26/54
Submitter  : Maximilian Engelhardt <maxi-OwNUvPV92VfddJNmlsFzeA@public.gmane.org>
Handled-By : Bj=F6rn Steinbrink <B.Steinbrink-Mmb7MZpHnFY@public.gmane.org>=20
Patch      : http://lkml.org/lkml/2007/5/27/182
Status     : patch available


Subject    : OOPS triggered by ip(8) deconfiguring a network interface
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8491
Submitter  : Ben Collins <bcollins-GeWIH/nMZzLQT0dZR+AlfA@public.gmane.org>
Patch      : http://marc.info/?l=3Dlinux-netdev&m=3D117915849224816&w=3D=
2
             commit 5632c5152aa621885d87ea0b8fdd5a6bb9f69c6f
Status     : bug probably fixed

SATA/PATA

Subject    : pata_via appears to incorrectly detects 40-pin cable
References : http://lkml.org/lkml/2007/5/17/273
Submitter  : Francis Russell <francisrussell-LfUFBbCNao6Ide+eSLyLAQ@public.gmane.org>
Status     : Not really a regression. Alan seems to have a general fix.
             (Tejun Heo)

Subject    : libata reset-seq merge broke sata_sil on sh
References : http://lkml.org/lkml/2007/5/10/63
Submitter  : Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Handled-By : Tejun Heo <htejun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Caused-By  : commit 4750def52cb2c21732dda9aa1d43a07db37b0186
Patch      : http://lkml.org/lkml/2007/5/19/161
Status     : patch available



Sparc64

Subject    : arch/sparc64/time.c doesn't compile on Ultra 1 (no PCI)
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8540
Submitter  : Horst H. von Brand <vonbrand-0F290kgVbvxip2iK3AC5Mw@public.gmane.org>
Status     : patch available



Regards,
Michal

--
"Najbardziej brakowa=B3o mi twojego milczenia."
-- Andrzej Sapkowski "Co=B6 wi=EAcej"
