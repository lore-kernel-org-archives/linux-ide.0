From: Jim Paris <jim@jtan.com>
Subject: Re: Silicon Image 3124 problems with Norco DS-1220 (Sil3726 port multipliers?)
Date: Tue, 27 Feb 2007 23:26:47 -0500
Message-ID: <20070228042647.GA30930@jim.sh>
References: <200702272343.l1RNh7tY018807@tenet.verdasys.com> <A5F9EDF3C51A884B8732C10154F10209010467F3@ilsaw03.corp.incentivelogic.com> <45DE756B.2050201@gmail.com> <A5F9EDF3C51A884B8732C10154F10209060401@ilsaw03.corp.incentivelogic.com> <A5F9EDF3C51A884B8732C10154F10209060409@ilsaw03.corp.incentivelogic.com> <45E3A632.20204@gmail.com> <A5F9EDF3C51A884B8732C10154F1020906040B@ilsaw03.corp.incentivelogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:36791 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544AbXB1E13 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Feb 2007 23:27:29 -0500
Content-Disposition: inline
In-Reply-To: <200702272343.l1RNh7tY018807@tenet.verdasys.com> <A5F9EDF3C51A884B8732C10154F1020906040B@ilsaw03.corp.incentivelogic.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gregory Youngblood <gyoungblood@incentivelogic.com>, Marc Bejarano <list.linux-ide@beej.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Gregory Youngblood wrote:
> I'm seeing several problems with a Silicon Image 3124 and Norco
> DS-1220 external sata shelf with two Silicon Image 3726 port
> multipliers and 8 500gb 7200.10 Seagate sata hard drives. The
> hardware is known to be good. Or at least the Dell server is. The
> only new hardware added to this server is the Norco DS-1220, Norco
> 4618 (Sil3124) controller, and the 8 drives. These problems are
> causing file operations with remote servers (via Samba) to fail
> intermittently.

Marc Bejarano wrote:
> otherwise, find someone who wants to beat tejun's existing 
> PMP-enabled driver into submission.  i'll buy you a beer if you 
> succeed in that :D  like you, i've had little luck with it in it's 
> current state.

I'm using libata-tj-2.6.17.4-20060710 with a SiI3124+DS-1220+SiI3726
with great success.  I haven't tried newer kernels.  You might try
going back to that one to see if it helps.

Mine is full of 300gb 7200.9 Seagate disks (ST3300822AS).  I'll be
getting some 500gb 7200.9 Seagate disks (ST3500641AS) soon and can let
you know if I see any different results.

-jim
