From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [1/2] 2.6.22-rc1: known regressions
Date: Sun, 13 May 2007 20:52:04 +0200
Message-ID: <6bffcb0e0705131152y2c2035a1rf609ef818e847bb6@mail.gmail.com>
References: <46475595.4050105@googlemail.com>
	 <Pine.LNX.4.64.0705131118160.3212@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0705131118160.3212@alien.or.mcafeemobile.com>
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Antonino Ingargiola <tritemio@gmail.com>, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-fsdevel@vger.kernel.org, xfs-masters@oss.sgi.com, Jeremy Fitzhardinge <jeremy@goop.org>, David Chinner <dgc@sgi.com>, Charles Gagalac <charle97@yahoo.com>
List-Id: linux-ide@vger.kernel.org

On 13/05/07, Davide Libenzi <davidel@xmailserver.org> wrote:
> On Sun, 13 May 2007, Michal Piotrowski wrote:
>
> > Subject    : applications under wine freezes
> > References : http://bugzilla.kernel.org/show_bug.cgi?id=8462
> > Submitter  : Charles Gagalac <charle97@yahoo.com>
> > Caused-By  : Davide Libenzi <davidel@xmailserver.org>
> >              commit 6192bd536f96c6a0d969081bc71ae24f9319bfdc
> > Handled-By : Davide Libenzi <davidel@xmailserver.org>
> > Status     : problem is being debugged
>
> This has been fixed. Confirmed by myself and Charles Gagalac. Patches have
> been sent to Andrew.

Bugzilla is back. Did you mean this patch
http://bugzilla.kernel.org/show_bug.cgi?id=8462#c8 ?

Regards,
Michal

-- 
Michal K. K. Piotrowski
Kernel Monkeys
(http://kernel.wikidot.com/start)
