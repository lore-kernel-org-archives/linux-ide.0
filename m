From: Barry Scott <barry.scott@onelan.co.uk>
Subject: Re: 2.6.16.20 fails to boot on SATA system but works on IDE
Date: Tue, 20 Jun 2006 14:44:22 +0100
Message-ID: <4497FBB6.6060504@onelan.co.uk>
References: <4492DDFF.6010303@onelan.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:59921 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750943AbWFTNo0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jun 2006 09:44:26 -0400
Received: from onelanbroadband.demon.co.uk ([80.177.165.253] helo=[192.168.1.23])
	by anchor-post-34.mail.demon.net with esmtp (Exim 4.42)
	id 1FsgWk-0008gQ-Fb
	for linux-ide@vger.kernel.org; Tue, 20 Jun 2006 13:44:24 +0000
In-Reply-To: <4492DDFF.6010303@onelan.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org

Barry Scott wrote:
> I originally post to linux kernel dev list. But guess that this is a
> more appropriate list to ask for help on.
>
> After failing to get 2.6.17-rc6 working on a HP dc7600U I went back
> to 2.6.16.20. It also fails to find any volume group during boot.
>
> I think this might be problem with SATA as I can boot the same build on
> two other systems that have IDE disks.
>
> I get success on VIA Epia M10000 and a P4 Shuttle systems that use
> IDE disks but fail on the HP dc7600U that uses a SATA disk. All three
> systems use LVM2.
>
> The Fedora build of 2.6.16 works on all three systems.
>
> I'm going to see if there are debug messages I can turn on it libata
> and md that might give more information.
>
> Any suggestions as to what I can do to track down this problem?
>
> Barry
If this is the wrong list to ask about this problem can anyone suggest the
right place to ask?

Barry

