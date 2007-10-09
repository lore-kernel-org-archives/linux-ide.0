From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: sata_sis driver may be broken in openSUSE 10.3
Date: Tue, 09 Oct 2007 22:43:26 +0200
Message-ID: <470BE7EE.6050601@gmx.net>
References: <200710082128.00883.njdube@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:45065 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753347AbXJIUna (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Oct 2007 16:43:30 -0400
In-Reply-To: <200710082128.00883.njdube@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nathaniel Dube <njdube@gmail.com>
Cc: linux-ide@vger.kernel.org

I have checked the 32 Bit Version of openSuSE 10.3 with SiS965 chipset,
it works.

The sata_sis driver tries to load the pata_sis driver. but SuSE 10.3
tries to load the sis5513 before.
pata_sis and sis5513 are trying to serve the same hardware. may be this
affects a conflict.
please try boot option brokenmodules=sis5513

You can also try to boot with brokenmodules=sis5513,pata_sis,sata_sis

Then you must load later the modules pata_sis and sata_sis in this order.

regards
Uwe

Nathaniel Dube wrote:
> I found your contact information in the file..
>
> /usr/src/linux-2.6.18.8-0.5/drivers/ata/sata_sis.c
>
> And figured you might be the one to talk to.  I, as well as many others have 
> had issus with openSUSE 10.3 not detecting SATA hard drives.  I don't know if 
> the fault is with the kernel developers or openSUSE.  But I do know the issue 
> is with the sata_sis driver that's being provided with 10.3.
>
> I'm not a programer.  I wouldn't know where to begin to fix this issue.
>
> Here are some links of people having the same problem.
>
> This is one from the openSUSE mailing list.
> http://lists.opensuse.org/opensuse/2007-10/msg00496.html
>
> This is one of the web forums.
> http://www.suseforums.net/index.php?showtopic=39625
>
> And here's some from Newsgroups.  To many to post here.  You could look for 
> them here.
>
> news://support-forums.novell.com/opensuse.org.suse-linux.support.install-configure-administration
> news://support-forums.novell.com/opensuse.org.suse-linux.support.general-applications
> Or on Usenet.
> news:alt.os.linux.suse
>
> Search for "sata".
>
> There's also a Novell bug report here.
> https://bugzilla.novell.com/show_bug.cgi?id=331610
>   

