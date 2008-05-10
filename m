From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: How to mount a CD created on Vista?
Date: Sat, 10 May 2008 17:35:39 +0200
Message-ID: <4825C0CB.3010109@gmail.com>
References: <482598B7.9020402@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:50622 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453AbYEJPft (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 May 2008 11:35:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jur6y-0005Ht-1B
	for linux-ide@vger.kernel.org; Sat, 10 May 2008 15:35:48 +0000
Received: from d83-183-214-201.cust.tele2.se ([83.183.214.201])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 10 May 2008 15:35:48 +0000
Received: from lasse.makholm by d83-183-214-201.cust.tele2.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 10 May 2008 15:35:48 +0000
In-Reply-To: <482598B7.9020402@superbug.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

James Courtier-Dutton wrote:
> Hi,
> 
> I have places a sample CD image at the following URL.
> It just has test files on it so anyone can copy it to test.
> I would like linux to be able to mount these types of CDs.
> 
> http://james.dutton.googlepages.com/vista-cd-test.iso
> 
> Can anyone help

It's probably a UDF 2.5 image...

See this post:
http://www.linuxquestions.org/questions/linux-general-1/reading-dvd-burnt-with-vista-614956/#post3061599

There are patches available:
http://sourceforge.net/tracker/?group_id=295&atid=300295

Whether or not that'll do the trick, I don't know...

/Lasse

