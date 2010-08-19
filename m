From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Thu, 19 Aug 2010 14:24:49 +0200
Message-ID: <AANLkTi=oTW6Qko_ZpUL-S3e_mMqKYXSyEkxUXjhsps_u@mail.gmail.com>
References: <20100810155559.7620.79711.stgit@localhost.localdomain>
 <4C6AB68D.8000102@kernel.org> <20100817174257.3691ed68@lxorguk.ukuu.org.uk>
 <4C6AB919.7060203@kernel.org> <20100817180158.179e7780@lxorguk.ukuu.org.uk>
 <4C6ABFFA.2000502@kernel.org> <20100817192353.3529733c@lxorguk.ukuu.org.uk>
 <4C6B7B72.4090405@kernel.org> <20100818110306.03ce2fbc@lxorguk.ukuu.org.uk>
 <4C6BE9C8.4030803@kernel.org> <20100818161521.430ba361@lxorguk.ukuu.org.uk>
 <4C6CFB63.2070001@kernel.org> <20100819110959.40312e58@linux.intel.com>
 <4C6D13E2.1010703@kernel.org> <1282217732.1236.19.camel@yio.site> <4C6D189A.2080706@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48406 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab0HSMZG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Aug 2010 08:25:06 -0400
Received: by gwj17 with SMTP id 17so664117gwj.19
        for <linux-ide@vger.kernel.org>; Thu, 19 Aug 2010 05:25:04 -0700 (PDT)
In-Reply-To: <4C6D189A.2080706@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, jeff@garzik.org

On Thu, Aug 19, 2010 at 13:42, Tejun Heo <tj@kernel.org> wrote:
> What I was curious about is what
> happens if some of them are already in the kernel but not all of them=
=2E

> udev would still be invoked the same and modprobe too but device -
> driver matching can and is probably likely to happen before modprobe
> finishes loading all the drivers, right? =C2=A0Or is there a mechanis=
m to
> hold off device - driver matching before the udev finishes handling
> the event for the controller?

The compiled-in drivers have matched and bound and blocked-out any
other driver of the device long before udev is even started load the
other drivers. The matching compiled-in drivers will always win over
the modules, regardless of their priority.

Is that what you mean? :)

Kay
