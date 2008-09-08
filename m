From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_inic162x  LED enable request
Date: Mon, 08 Sep 2008 21:09:01 +0200
Message-ID: <48C5784D.5020206@kernel.org>
References: <885420.46850.qm@web902.biz.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56532 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755005AbYIHTKd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Sep 2008 15:10:33 -0400
In-Reply-To: <885420.46850.qm@web902.biz.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Stewart <bob@evoria.net>
Cc: echo6 <echo6_uk@yahoo.com>, linux-ide@vger.kernel.org

Bob Stewart wrote:
> --- Tejun Heo <tj@kernel.org> wrote:
>> Hmm... I have two - INIC-1622 V1.0 Septermber, 2003 and the one you
>> have.  Till now, I haven't found any noticeable difference.
>> Apparently, the meaning of the bit has changed.
>>
>>> Which book are you using and are all these bits in the Global
>>> Control register, which we call HOST_CTL?  Did I get an old book?
>> Yes, that's GCTRL.  Can you please do the '+' -> '|' change and resend
>> the patch?
> 
> Sure; was just waiting to hear about the book versions in case they
> had issued still another version.

Can you please format the message like the following with
Signed-off-by and cc jeff@garzik.org?

  http://article.gmane.org/gmane.linux.ide/34108

Thanks.

-- 
tejun
