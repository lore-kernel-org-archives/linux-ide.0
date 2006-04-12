From: Gabor Gombas <gombasg@sztaki.hu>
Subject: Re: libata-pata works on ICH4-M
Date: Wed, 12 Apr 2006 19:33:20 +0200
Message-ID: <20060412173320.GI4919@boogie.lpds.sztaki.hu>
References: <443B9EBB.6010607@gmx.net> <Pine.LNX.4.61.0604112044340.25940@yvahk01.tjqt.qr> <1144832990.1952.20.camel@localhost.localdomain> <Pine.LNX.4.61.0604121153060.12544@yvahk01.tjqt.qr> <1144852703.1952.36.camel@localhost.localdomain> <20060412151930.GH4919@boogie.lpds.sztaki.hu> <Pine.LNX.4.61.0604121730360.11511@yvahk01.tjqt.qr> <87f94c370604120958m7ff116a5h4090701cd4936b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from boogie.lpds.sztaki.hu ([193.225.12.226]:7847 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S932279AbWDLRdV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Apr 2006 13:33:21 -0400
Content-Disposition: inline
In-Reply-To: <87f94c370604120958m7ff116a5h4090701cd4936b8@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Apr 12, 2006 at 12:58:30PM -0400, Greg Freemyer wrote:

> IIRC to get hdparm to talk to sata drives via libata you have use:
> 
> hdparm -d ata /dev/sda

No, that's smartctl. -d for hdparm means something entirely different.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
