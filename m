From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Thu, 19 Aug 2010 14:54:55 +0200
Message-ID: <4C6D299F.5090100@kernel.org>
References: <20100810155559.7620.79711.stgit@localhost.localdomain> <4C6AB68D.8000102@kernel.org> <20100817174257.3691ed68@lxorguk.ukuu.org.uk> <4C6AB919.7060203@kernel.org> <20100817180158.179e7780@lxorguk.ukuu.org.uk> <4C6ABFFA.2000502@kernel.org> <20100817192353.3529733c@lxorguk.ukuu.org.uk> <4C6B7B72.4090405@kernel.org> <20100818110306.03ce2fbc@lxorguk.ukuu.org.uk> <4C6BE9C8.4030803@kernel.org> <20100818161521.430ba361@lxorguk.ukuu.org.uk> <4C6CFB63.2070001@kernel.org> <20100819110959.40312e58@linux.intel.com> <4C6D13E2.1010703@kernel.org> <1282217732.1236.19.camel@yio.site> <4C6D189A.2080706@kernel.org> <AANLkTi=oTW6Qko_ZpUL-S3e_mMqKYXSyEkxUXjhsps_u@mail.gmail.com> <4C6D2486.4020702@kernel.org> <AANLkTi=K-mt_NhUYnJT7DJMwX-CUu8Ri6NwT_AFMct5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42787 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121Ab0HSM64 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Aug 2010 08:58:56 -0400
In-Reply-To: <AANLkTi=K-mt_NhUYnJT7DJMwX-CUu8Ri6NwT_AFMct5a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Alan Cox <alan@linux.intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, jeff@garzik.org

Hello,

On 08/19/2010 02:52 PM, Kay Sievers wrote:
> If the device we are currently handling has already a driver bound,
> udev will not call modprobe.
> It's:
>   DRIVER!="?*", ENV{MODALIAS}=="?*", RUN+="/sbin/modprobe -bv $env{MODALIAS}"
> which means:
>   !DRIVER && MODALIAS -> modprobe

Okay, thanks for the explanation.

>>   is
>>   there a mechanism to hold off device - driver matching before
>>   modprobe is finished?  Probably not, right?
> 
> What does 'modprobe finished' mean? The modprobe called for this
> specific device? The first driver loaded and initialized will win. If
> multiple drivers are loaded with the same modprobe call, the later
> ones will never see the device.

Yeap, you're right.  Loading all drivers is for cases where
controllers supported by different drivers share the same PCI ID (some
of hpt's need this).  So, the priority thing is mostly broken except
for pretty simple cases. :-( Oh well, it has worked well enough till
now.  Let's leave it alone for now.

Thanks.

-- 
tejun
