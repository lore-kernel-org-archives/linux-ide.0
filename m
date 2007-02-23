From: Tejun Heo <htejun@gmail.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Fri, 23 Feb 2007 13:59:54 +0900
Message-ID: <45DE74CA.2010603@gmail.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>	 <8d158e1f0702160148v366ce96bm8e3ff3e7c64a7198@mail.gmail.com>	 <45D58270.4080909@tw.ibm.com>	 <8d158e1f0702170236h51756aadh6539f5d782774764@mail.gmail.com>	 <45DAD8DA.4000108@gmail.com>	 <8d158e1f0702200405w6a0e817bx3d809540d28b843d@mail.gmail.com>	 <8d158e1f0702201400w622bbcb2lc7711b5c8974bfcd@mail.gmail.com>	 <45DBEB63.3010905@gmail.com>	 <8d158e1f0702210447q4ee8526cke05a76f895ad824c@mail.gmail.com>	 <45DC46DF.8030704@gmail.com> <8d158e1f0702211030p542a8332w5b20318ca6b922e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:40871 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbXBWE75 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Feb 2007 23:59:57 -0500
Received: by py-out-1112.google.com with SMTP id a29so191483pyi
        for <linux-ide@vger.kernel.org>; Thu, 22 Feb 2007 20:59:57 -0800 (PST)
In-Reply-To: <8d158e1f0702211030p542a8332w5b20318ca6b922e9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patrick Ale <patrick.ale@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Hello, Patrick Ale.

Patrick Ale wrote:
> I am going to do a last ressort attempt.
> I am going to switch cables with a set of harddrives that are working
> properly and see if that works.

I don't think cables or the drives are the problems here but please keep
me posted about your test result.

> I changed cables allready, but with my luck the cables I changed them
> for are faulty.
> Jumpers and all look ok, I changed the jumpers, on advice from Greg
> and this didnt solve the problem.
> 
> Eric's comment about master slave collision made me think about a
> probable cable problem, which I am going to test now.
> 
> Stays weird that the legacy ide drivers do find the drives tho.

libata and ide use different methods to discover devices.  libata
depends on reset to work.  After reset, devices are supposed to send
diagnostic and the classfication code via TF registers.  OTOH, ide just
issues IDENTIFY and then IDENTIFY PACKET to each device slot without
resetting the channel.  Maybe we're doing something wrong in the pdc
driver or the controller just doesn't like libata's probing method.

Summoning (P)ATA gurus.  Hi! Here's the bullet.

The whole thread can be viewed at the following page.

  http://thread.gmane.org/gmane.linux.kernel/493605

It seems we can't read TF containing reset result reliable iff both
master and slave are present.  Please take a look at the following message.

  http://article.gmane.org/gmane.linux.ide/16216

  ata8: CLASSIFY: device 0 50:00 aa:fe:3f
  ata8: CLASSIFY: device 1 50:00 aa:10:00

Dumped TF regs are "status:error lbal:lbam:lbah".  Leaving only one
device on the channel, be it master or slave, works.

  http://article.gmane.org/gmane.linux.ide/16219

  ata8: CLASSIFY: device 0 20:20 20:20:20
  ata8: CLASSIFY: device 1 50:01 01:00:00

  or

  ata4: CLASSIFY: device 0 50:01 01:00:00
  ata4: CLASSIFY: device 1 00:01 01:00:00

Could it be timing issue like not using compatible pio timing during
reset?  Please keep in mind that we also have bug reports about solitary
slave device doesn't get detected in some cases.

Thanks.

-- 
tejun
