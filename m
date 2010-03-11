From: Justin Maggard <jmaggard10@gmail.com>
Subject: Re: Hotplug issue with Marvell 6121
Date: Wed, 10 Mar 2010 18:32:31 -0800
Message-ID: <150c16851003101832o358a8b4aj760384020658d1fc@mail.gmail.com>
References: <150c16851003091651r4ce4259v693f1310d0aa95ef@mail.gmail.com>
	 <150c16851003101446m633ad174tc784a94e2a2a5a5b@mail.gmail.com>
	 <4B983F08.6080701@gmail.com> <4B9840D3.7050109@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:1150 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184Ab0CKCcc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Mar 2010 21:32:32 -0500
Received: by qw-out-2122.google.com with SMTP id 9so335496qwb.37
        for <linux-ide@vger.kernel.org>; Wed, 10 Mar 2010 18:32:31 -0800 (PST)
In-Reply-To: <4B9840D3.7050109@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

On Wed, Mar 10, 2010 at 5:01 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On 03/11/2010 09:53 AM, Robert Hancock wrote:
>> That doesn't sound like a great solution. I'd think that the speed
>> limiting should be reset upon disabling the device so that we start =
over
>> at 3Gbps again when you reconnect..
>
> libata EH already does that. =A0It resets the speed limit mask after =
the
> device is disabled and when the *next* reset happens on device
> hotplug, the highest speed will be applied. =A0It's just that there
> usually is no need to do an extra reset right after disabling a
> device.
>
> Does 1.5Gbps work at all on those marvell controllers? =A0It's *very*
> strange to miss hotplug under 1.5Gbps. =A0Those signals are OOB and
> don't even follow the usual signal frequency.

It's not the 1.5Gbps that is causing the problem.  It appears to be
the act of changing speeds.  I added "libata.force=3D3:1.5Gbps" to my
kernel command line, and hotplugs seemed to work fine on that port
(presumably due to the fact that libata EH won't change the link speed
limit if it's already at 1.5Gbps).  The other port on the controller
still had hotplug problems.  So everything seems to be pointing to the
Marvell controller having problems when you change speeds.

-Justin
