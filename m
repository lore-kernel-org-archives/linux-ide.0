From: "Yasha Okshtein" <flyashi@gmail.com>
Subject: Re: Recommendations on user-space soft/hardreset
Date: Tue, 17 Jul 2007 23:13:51 -0700
Message-ID: <6b01c6170707172313o46461bbj5d2dde34593e66d6@mail.gmail.com>
References: <6b01c6170707171723p4fdae403hf5b605fce4595b7@mail.gmail.com>
	 <6b01c6170707171734l12af7fbdt43c28edd32776858@mail.gmail.com>
	 <469D8A99.8050102@gmail.com>
	 <6b01c6170707172104s62408da6yc11f239cc2a37860@mail.gmail.com>
	 <469D93F3.8030707@gmail.com>
	 <6b01c6170707172201gde9e437q714dea601916087d@mail.gmail.com>
	 <469DA045.90706@gmail.com>
Reply-To: flyashi@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:55062 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbXGRGNw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 02:13:52 -0400
Received: by fk-out-0910.google.com with SMTP id z23so8797fkz
        for <linux-ide@vger.kernel.org>; Tue, 17 Jul 2007 23:13:51 -0700 (PDT)
In-Reply-To: <469DA045.90706@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On 7/17/07, Tejun Heo <htejun@gmail.com> wrote:
> After all, why do you care whether SRST or HRST is used?
> It's a reset anyway.

The softreset doesn't do what I need, which is to firmware upgrade a
certain drive model. While reloading the module does work, this takes
a while given the number of disks per machine (and lots of machines).

I've got a (hackish) way to do what I need, but I was hoping someone
else out there other than me needed a better way. And as it stands,
libata's implementation of the pass-through spec is incomplete.
