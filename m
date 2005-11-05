From: Bruno Harbulot <bruno_harbulot@yahoo.co.uk>
Subject: Re: ATIIXP and libata
Date: Sat, 5 Nov 2005 15:32:38 +0000 (GMT)
Message-ID: <20051105153238.99727.qmail@web86806.mail.ukl.yahoo.com>
References: <436B2709.1080803@seanodes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web86806.mail.ukl.yahoo.com ([217.12.13.48]:54155 "HELO
	web86806.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932081AbVKEPcj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Nov 2005 10:32:39 -0500
In-Reply-To: <436B2709.1080803@seanodes.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Velu Erwan <erwan@seanodes.com>
Cc: linux-ide@vger.kernel.org


--- Velu Erwan <erwan@seanodes.com> wrote:
> >
> > I am trying to make a SATA drive work (fast) on an Asus Pundit-R 
> > (P4R8L motherboard).
[...]
> >
> > I have also got another similar problem with this controller, which
> 
> > may or may not be related. This problem is more or less point
> number 3 
> > of:
> > <http://www.debian.org/devel/debian-installer/errata>
> > ("SATA driver can block access to CD drive in installations from
> CD").
> > When installing this machine, the hard drive and the DVD drive were
> > "conflicting", so I had to load a much as I could from the install
> CD
> 
> [...]
> 
> Could you please try putting your dvd drive as slave by setting up
> the 
> jumper on it ? It will be then detected has hdb (my configuration)
> and 
> should works.


Indeed, when the DVD drive is configured as slave, it works fine.
Cheers!

Bruno.


		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com
