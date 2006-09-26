From: Andrew Morton <akpm@osdl.org>
Subject: Re: enable-cdrom-dma-access-with-pdc20265_old.patch
Date: Tue, 26 Sep 2006 13:05:30 -0700
Message-ID: <20060926130530.5ac89c91.akpm@osdl.org>
References: <BAY105-F11E6F724B96A5A607106EAA3260@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932263AbWIZUFz@vger.kernel.org>
In-Reply-To: <BAY105-F11E6F724B96A5A607106EAA3260@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
To: Tobias Oed <tobiasoed@hotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, alan@lxorguk.ukuu.org.uk, sshtylyov@ru.mvista.com
List-Id: linux-ide@vger.kernel.org

On Sat, 23 Sep 2006 10:43:57 -0400
"Tobias Oed" <tobiasoed@hotmail.com> wrote:

> If it makes things easier my patch labeled
> enable-cdrom-dma-access-with-pdc20265_old.patch in -mm
> could be dropped in favour of what follows (against 2.6.18),
> making the feature an EXPERIMENTAL config option.

eh, we'll just merge it as-is, see what happens, I think.

I'll assume that this new patch contained no other changes (ie: the patch
in -mm is ok-to-merge).
