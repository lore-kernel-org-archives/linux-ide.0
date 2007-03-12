From: "Paul Rolland" <rol@as2917.net>
Subject: RE: [git patches] libata fixes
Date: Mon, 12 Mar 2007 10:58:31 +0100
Message-ID: <008d01c7648d$0108d1b0$4b00a8c0@donald>
References: <45F509A7.8030705@gmail.com>
Reply-To: <rol@as2917.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965472AbXCLJ7v@vger.kernel.org>
In-Reply-To: <45F509A7.8030705@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>
Cc: 'Linus Torvalds' <torvalds@linux-foundation.org>, 'Jeff Garzik' <jeff@garzik.org>, 'Alan Cox' <alan@redhat.com>, 'Andrew Morton' <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, "'Eric D. Mudama'" <edmudama@gmail.com>
List-Id: linux-ide@vger.kernel.org

Hello,

> > That sounds a quite expensive solution ;)
> 
> You should be able to just move the drive attached at ata1 to ata2.
> Please report whether that works.

I'll try to find an unused disk... As I said, these ports are part of
Asus EZRaid solution, and i'd prefer this piece of code not to try to
write anything on the disk ;)

... but I should find a disk without too much problem.

Paul
