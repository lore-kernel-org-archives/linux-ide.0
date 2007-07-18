From: "Yasha Okshtein" <flyashi@gmail.com>
Subject: Re: Recommendations on user-space soft/hardreset
Date: Tue, 17 Jul 2007 22:01:16 -0700
Message-ID: <6b01c6170707172201gde9e437q714dea601916087d@mail.gmail.com>
References: <6b01c6170707171723p4fdae403hf5b605fce4595b7@mail.gmail.com>
	 <6b01c6170707171734l12af7fbdt43c28edd32776858@mail.gmail.com>
	 <469D8A99.8050102@gmail.com>
	 <6b01c6170707172104s62408da6yc11f239cc2a37860@mail.gmail.com>
	 <469D93F3.8030707@gmail.com>
Reply-To: flyashi@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:33537 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbXGRFBS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 01:01:18 -0400
Received: by fk-out-0910.google.com with SMTP id z23so7443fkz
        for <linux-ide@vger.kernel.org>; Tue, 17 Jul 2007 22:01:17 -0700 (PDT)
In-Reply-To: <469D93F3.8030707@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On 7/17/07, Tejun Heo <htejun@gmail.com> wrote:
> Yasha Okshtein wrote:
> > Well ideally this should work with a port multiplier to soft/hardreset
> > only one disk behind the multiplier.
>
> You can do that too.  Just do 'echo x - -' where x corresponds to the
> PMP port number.  On older versions it's 'echo - x -'.
Nice, thanks!

> > Also, this again doesn't allow
> > the user to specify soft or hard reset - I believe rescanning forces
> > hardresets. Fully implementing the SATA spec, which should eventually
> > be done anyway, seems like a cleaner solution.
>
> It defaults to softreset.

That still leaves the original problem of hardresets :)

 - yasha
