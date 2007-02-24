From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Sat, 24 Feb 2007 15:56:18 +0100
Message-ID: <200702241556.19089.bzolnier@gmail.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com> <45E0381C.3030706@gmail.com> <8d158e1f0702240556s52a79202g974ad8208ee7e306@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:60901 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932750AbXBXOuG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Feb 2007 09:50:06 -0500
Received: by ug-out-1314.google.com with SMTP id 44so550348uga
        for <linux-ide@vger.kernel.org>; Sat, 24 Feb 2007 06:50:05 -0800 (PST)
In-Reply-To: <8d158e1f0702240556s52a79202g974ad8208ee7e306@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patrick Ale <patrick.ale@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, albertl@mail.com, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <mlord@pobox.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>


On Saturday 24 February 2007, Patrick Ale wrote:
> On 2/24/07, Tejun Heo <htejun@gmail.com> wrote:
> > Patrick Ale wrote:
> 
> 
> >
> > The upper one is 40c while the other one is 80c.
> 
> No, they are all 80 , two of them came with the mainboard, the so
> called "green" connectors as gigabyte calls them, the other one was an
> 80c with blue connector.
> 
> I dunno, I guess I should review my "spare" parts and see what's
> really useable from this pile of hardware I have here.
> 
> But hey, one thing is for sure, and I think it's a positive thing.
> If libata sees problems or seems to have problems, you can be 99% sure
> there IS a problem, where the legacy drivers just act all happy and
> keep you thinking everything is peachy and all.

I'm really sorry that legacy drivers just work.  I will try harder. ;-)

The real problem is that while legacy drivers contain a ton of workarounds
and fixes for problems like that they often lacks the documentation about it.

> So again, thumbs up for libata.
> 
> Patrick
