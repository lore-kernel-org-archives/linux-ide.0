From: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: switch ide-proc to use the ide_key functionality
Date: Mon, 16 Aug 2004 11:30:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040816153011.GE10279@devserv.devel.redhat.com>
References: <20040815150414.GA12181@devserv.devel.redhat.com> <200408161724.09880.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267768AbUHPPcE@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200408161724.09880.bzolnier@elka.pw.edu.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
List-Id: linux-ide@vger.kernel.org

On Mon, Aug 16, 2004 at 05:24:09PM +0200, Bartlomiej Zolnierkiewicz wrote:
> This patch removes write access to /proc/ide/hd?/driver without even
> mentioning this - IMHO we should deprecate it first.  Such changes should
> be described (with rationale for them) at least in the changelog
> (or even better in Documentation/ide.txt).

I thought we discussed this earlier - its essentially unfixable. You can
either have trivial /proc crashes, deadlocks on writing this file or lose
the feature (which nobody on the planet even knew about). 

If you've got any ideas how to fix it then let me know.

Agreed about adding it to Documentation/ide.txt
