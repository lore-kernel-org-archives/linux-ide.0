From: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [FIX] Re: 2.5.70-bk[56] breaks disk partitioning with multiple
 IDE disks
Date: Sun, 1 Jun 2003 18:49:41 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0306011849050.16521-100000@home.transmeta.com>
References: <20030601235333.GN9502@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:516 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264781AbTFBBgo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Jun 2003 21:36:44 -0400
In-Reply-To: <20030601235333.GN9502@parcelfarce.linux.theplanet.co.uk>
List-Id: linux-ide@vger.kernel.org
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Adam J. Richter" <adam@yggdrasil.com>


On Mon, 2 Jun 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> vi drivers/ide/ide.c -c'/drive->list.*driver->drives/s/list_add/&_tail/|x'

Mind sending me a patch? There's only so much I like doing with vi 
scripts, and this went over my threshold.

		Linus

