From: Vlad <vladc6@yahoo.com>
Subject: Re: Freezes: ata1 is slow to respond, please be patient
Date: Wed, 9 Aug 2006 21:09:04 -0700 (PDT)
Message-ID: <20060810040904.72989.qmail@web54409.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web54409.mail.yahoo.com ([206.190.49.139]:22660 "HELO
	web54409.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030552AbWHJEJF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 00:09:05 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: chantra@debuntu.org, linux-ide@vger.kernel.org

chantra@debuntu.org said:
>By the way, lately I tried ubuntu edgy eft and debian edgy, both of
them
>use a 2.6.17 kernel.... the kernel did not even boot. I didn't get a
>kernel panic, the kernel simply hanged on "mounting root filesystem".

Try turning off DMA while it is booting but _before_ it attempts to
mount the CD:
    1) Switch to a console by pressing Esc and then Alt-F3.
    2) Type 'hdparm -d0 /dev/hdc'

This workaround allowed me to boot installation CDs in the absense of
a fix to the problem (see
http://bugzilla.kernel.org/show_bug.cgi?id=6710 )

Vlad

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
