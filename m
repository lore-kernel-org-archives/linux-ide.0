From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Wed, 31 Jan 2007 20:00:44 +0900
Message-ID: <45C076DC.4080204@gmail.com>
References: <200612111003.39928.kovid@theory.caltech.edu> <4588877D.1000400@gmail.com> <20061220032941.GA8903@us.ibm.com> <4588B3D5.4030406@gmail.com> <20061221171035.GC6171@us.ibm.com> <20070130015507.GA30069@us.ibm.com> <45BEF492.9000000@gmail.com> <20070130233735.GA7483@us.ibm.com> <45C0731B.2030608@gmail.com> <45C073B2.5000507@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:64009 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933011AbXAaLAu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 06:00:50 -0500
Received: by nz-out-0506.google.com with SMTP id s1so156616nze
        for <linux-ide@vger.kernel.org>; Wed, 31 Jan 2007 03:00:50 -0800 (PST)
In-Reply-To: <45C073B2.5000507@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Gary Hade <garyhade@us.ibm.com>, Kovid Goyal <kovid@theory.caltech.edu>, linux-ide@vger.kernel.org, lcm@us.ibm.com, konradr@us.ibm.com

Jeff Garzik wrote:
> Tejun Heo wrote:
>> I'm gonna work on parallel probing for libata.  I think we can easily
>> hide extra 2 secs of waiting with parallel probing.  It will take some
>> time but that seems to be the 'right' thing to do especially considering
>> the fact that 150ms sleep has been enough for gazillions of ATA devices
>> during last decade except for this GoVault drive.
> 
> 
> FWIW I don't mind polling for a /maximum/ of $N seconds, but I want to
> stress that any patch that blatantly adds stuff like
> 
>     if (status == 0xff)
>         mdelay(2000)
> 
> will be rejected.

Aye aye captain.  I wouldn't do that myself either.

-- 
tejun
