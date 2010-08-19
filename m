From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Thu, 19 Aug 2010 15:14:57 +0200
Message-ID: <4C6D2E51.1090909@kernel.org>
References: <20100810155559.7620.79711.stgit@localhost.localdomain> <4C6AB68D.8000102@kernel.org> <20100817174257.3691ed68@lxorguk.ukuu.org.uk> <4C6AB919.7060203@kernel.org> <20100817180158.179e7780@lxorguk.ukuu.org.uk> <4C6ABFFA.2000502@kernel.org> <20100817192353.3529733c@lxorguk.ukuu.org.uk> <4C6B7B72.4090405@kernel.org> <20100818110306.03ce2fbc@lxorguk.ukuu.org.uk> <4C6BE9C8.4030803@kernel.org> <20100818161521.430ba361@lxorguk.ukuu.org.uk> <4C6CFB63.2070001@kernel.org> <20100819110959.40312e58@linux.intel.com> <4C6D13E2.1010703@kernel.org> <1282217732.1236.19.camel@yio.site> <4C6D189A.2080706@kernel.org> <AANLkTi=oTW6Qko_ZpUL-S3e_mMqKYXSyEkxUXjhsps_u@mail.gmail.com> <4C6D2486.4020702@kernel.org> <AANLkTi=K-mt_NhUYnJT7DJMwX-CUu8Ri6NwT_AFMct5a@mail.gmail.com> <4C6D299F.5090100@kernel.org
 > <AANLkTik_yUUzPVpD3hFzJ-TLxU+pcwx_vAjDO_M3oNrH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53448 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712Ab0HSNTD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Aug 2010 09:19:03 -0400
In-Reply-To: <AANLkTik_yUUzPVpD3hFzJ-TLxU+pcwx_vAjDO_M3oNrH@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Alan Cox <alan@linux.intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, jeff@garzik.org

Hello,

On 08/19/2010 03:08 PM, Kay Sievers wrote:
> Well, I wouldn't really call it broken. It's very helpful to have
> these priorities, and it solved a bunch of real problems because in
> most cases it produces predictable results, unlike it was before.
> 
> That compiled-in and and modules don't really mix here regarding your
> use case does not really matter in the general picture, it's still a
> predictable behavior, and we really need the priorities.

Yeah, in most usual cases, it has been fine.  I was just hoping that
it would work better so that fallback drivers can be handled with it.
For now, it seems there is no safe way to have a generic fallback
driver (be it pata_acpi or ata_generic).

> If we need finer-grained policy here, we need to move the driver
> binding to userspace. The driver core and udev can do that already.
> But nobody of us is so crazy to enable it, and handle all the fallout.
> But it's possible in theory ... :)

Right, userland already has enough mechanism and information to handle
the driver binding problem correctly, but given how little problem it
has been causing till now, I think that would be an overkill, for now
at least.

Thanks.

-- 
tejun
