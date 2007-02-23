From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Fri, 23 Feb 2007 04:38:08 -0500
Message-ID: <45DEB600.8060109@garzik.org>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>	 <8d158e1f0702170236h51756aadh6539f5d782774764@mail.gmail.com>	 <45DAD8DA.4000108@gmail.com>	 <8d158e1f0702200405w6a0e817bx3d809540d28b843d@mail.gmail.com>	 <8d158e1f0702201400w622bbcb2lc7711b5c8974bfcd@mail.gmail.com>	 <45DBEB63.3010905@gmail.com>	 <8d158e1f0702210447q4ee8526cke05a76f895ad824c@mail.gmail.com>	 <45DC46DF.8030704@gmail.com>	 <8d158e1f0702211030p542a8332w5b20318ca6b922e9@mail.gmail.com>	 <45DE74CA.2010603@gmail.com> <8d158e1f0702230041i7d3c28a4r202d9f8f628120f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44582 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158AbXBWJiQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Feb 2007 04:38:16 -0500
In-Reply-To: <8d158e1f0702230041i7d3c28a4r202d9f8f628120f4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patrick Ale <patrick.ale@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, albertl@mail.com, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Is this detection problem limited to Promise controllers?

It's possible we might be programming the Promise controllers in "dual 
master" mode, and then accidentally missing the second channel somehow.

	Jeff



