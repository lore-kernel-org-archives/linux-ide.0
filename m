From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Forcing PIO0 mode on reset must not freeze	system
Date: Mon, 11 Feb 2008 19:49:17 +0900
Message-ID: <47B0282D.2050703@gmail.com>
References: <20080210195556.GA5261@homac> <47AFB4DB.1000204@gmail.com> <20080211102907.GC4646@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757822AbYBKKtm@vger.kernel.org>
In-Reply-To: <20080211102907.GC4646@homac.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alan@redhat.com, jeff@garzik.org
List-Id: linux-ide@vger.kernel.org

Hello,

Holger Macht wrote:
>> In the above example, even the reset sequence itself can cause hang if
>> the hardware is implemented slightly differently.  The reason why
>> set_piomode() locks up but reset sequence doesn't is simple dumb luck.
> 
> Another thing, whether it's poor luck or not, it worked like this than at
> least 2.6.22. And it was _heavily_ tested. The above commit broke it
> between 2.6.24-rc1 and 2.6.24-rc2, which is at least a regression.

Yes, in a sense but the change is in the area where there's no defined
behavior, so I don't think it's a good idea to revert the change here.
Let's concentrate on finding the proper solution.

Thanks.

-- 
tejun
