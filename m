From: Craig Block <chblock3@yahoo.com>
Subject: Re: 40-wire/80-wire detection
Date: Fri, 13 Jul 2007 10:58:24 -0700 (PDT)
Message-ID: <166657.81677.qm@web58101.mail.re3.yahoo.com>
References: <46976A53.7060503@seclark.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web58101.mail.re3.yahoo.com ([68.142.236.124]:43114 "HELO
	web58101.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754818AbXGMR62 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 13:58:28 -0400
In-Reply-To: <46976A53.7060503@seclark.us>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen.Clark@seclark.us, Jeff Garzik <jeff@garzik.org>, Matt Sealey <matt@genesi-usa.com>
Cc: linux-ide@vger.kernel.org

> >>Craig Block wrote:
> >>
> >>I'm having a problem with the 80-wire/40-wire cable detection

> Jeff Garzik wrote:
> >
> >If you signal a 40-wire cable too fast, you get trouble with a
> >capital T.

Thanks everyone for graciously replying to my negative email.  I was
pretty irritated when I found I could not disable the downgrade.  

That's fine if the driver nags about the cable, but it should up to the
user to deal with it.  And, like any nag, it should be possible to shut
if off.

As it stands, I will have to run these drives at ATA33.  My only
recourse is to hack the driver and disable the check.  With *me*
hacking on the code, I really run the risk of damaging my data.

Patches anyone?




       
____________________________________________________________________________________Ready for the edge of your seat? 
Check out tonight's top picks on Yahoo! TV. 
http://tv.yahoo.com/
