From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: libata interface fatal error
Date: Thu, 24 May 2007 10:55:35 -0400
Message-ID: <87f94c370705240755t1040e5c8jaeb1882a2a393ac1@mail.gmail.com>
References: <4655923E.5000409@effenberger.org> <46559713.9070201@gmail.com>
	 <46559C62.2040509@effenberger.org> <46559F5B.4090700@gmail.com>
	 <4655A588.40500@effenberger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:58590 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbXEXOzk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2007 10:55:40 -0400
Received: by an-out-0708.google.com with SMTP id d31so56126and
        for <linux-ide@vger.kernel.org>; Thu, 24 May 2007 07:55:37 -0700 (PDT)
In-Reply-To: <4655A588.40500@effenberger.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Effenberger <florian@effenberger.org>
Cc: Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org

On 5/24/07, Florian Effenberger <florian@effenberger.org> wrote:
> Hi,
>
> > Data integrity wise there should be no problem but your error rate is
> > pretty high and eventually will make libata turn off NCQ and/or speed
> > down PHY speed.
>
> switching ports is not easy. Both on-board SATA controllers are being
> used, and the error seems to occur on all ports.
>
> > Yeap, your data is safe.  With timeouts, data transfer speed can be much
> > lower tho.  It definitely seems something is wrong with your hardware setup.
>
> I will try to use another test disk. Right now we use different models
> of Western Digital "RAID edition".
>

iiuc, raid editions are designed to fail fast thus allowing an
alternate drive to provide the data rather than having to wait thru
multiple internal retries.

Could this just be a case of the drive functioning as designed?

Greg
-- 
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
