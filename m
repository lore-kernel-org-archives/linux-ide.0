From: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: header updates for IDE changes
Date: Mon, 16 Aug 2004 11:26:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040816152657.GB10279@devserv.devel.redhat.com>
References: <20040815145515.GA9993@devserv.devel.redhat.com> <200408161708.04376.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267725AbUHPP2S@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200408161708.04376.bzolnier@elka.pw.edu.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
List-Id: linux-ide@vger.kernel.org

On Mon, Aug 16, 2004 at 05:08:04PM +0200, Bartlomiej Zolnierkiewicz wrote:
> These changes belong to the patches making actual use of them...

They just don't split along those lines and compile sanely. I did the entire
thing as one operation because for a lot of it there are no middle grounds.

> BTW What is the ordering in which your patches should be applied?

Time order of message sending. I guess I should have added a PATCH n of m
to it but didn't realise in time. While I've split them up for ease of
understanding its likely a few steps along the way don't yield working
IDE because of the interdependancies.

Alan
