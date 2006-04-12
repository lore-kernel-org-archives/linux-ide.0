From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: libata-pata works on ICH4-M
Date: Wed, 12 Apr 2006 12:58:30 -0400
Message-ID: <87f94c370604120958m7ff116a5h4090701cd4936b8@mail.gmail.com>
References: <443B9EBB.6010607@gmx.net>
	 <Pine.LNX.4.61.0604112044340.25940@yvahk01.tjqt.qr>
	 <1144832990.1952.20.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0604121153060.12544@yvahk01.tjqt.qr>
	 <1144852703.1952.36.camel@localhost.localdomain>
	 <20060412151930.GH4919@boogie.lpds.sztaki.hu>
	 <Pine.LNX.4.61.0604121730360.11511@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.175]:53324 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932211AbWDLQ6c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Apr 2006 12:58:32 -0400
Received: by uproxy.gmail.com with SMTP id m3so982751ugc
        for <linux-ide@vger.kernel.org>; Wed, 12 Apr 2006 09:58:30 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.0604121730360.11511@yvahk01.tjqt.qr>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Gabor Gombas <gombasg@sztaki.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 4/12/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >> Ask the hdparm maintainers. Its mostly obsoleted by blktool and the like
> >> which are generic
> >
> ># hdparm -M 128 /dev/sda
> >
> The 's' is a classical indicator for somehow use of scsi. If that can be
> changed, the world is fine :)
>
>
> Jan Engelhardt

IIRC to get hdparm to talk to sata drives via libata you have use:

hdparm -d ata /dev/sda

Greg
--
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
