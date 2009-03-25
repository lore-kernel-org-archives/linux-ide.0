From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 02/10] ide-tape: use single continuous buffer
Date: Wed, 25 Mar 2009 17:38:32 +0100
Message-ID: <9ea470500903250938t35cbc403l2d0bb3ea5f1f1def@mail.gmail.com>
References: <1237990673-8358-1-git-send-email-tj@kernel.org>
	 <1237990673-8358-3-git-send-email-tj@kernel.org>
	 <da824cf30903250904n211b157eje2db99b0bdb1f33a@mail.gmail.com>
	 <49CA582B.9080706@kernel.org>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:54902 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbZCYQif convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Mar 2009 12:38:35 -0400
In-Reply-To: <49CA582B.9080706@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Grant Grundler <grundler@google.com>, bzolnier@gmail.com, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org

Hi,

On Wed, Mar 25, 2009 at 5:13 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello, Grant.
>
> Grant Grundler wrote:
>> On Wed, Mar 25, 2009 at 7:17 AM, Tejun Heo <tj@kernel.org> wrote:
>>> Impact: simpler buffer allocation and handling, fix DMA transfers
>> ...
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 atomic_set(&bh->b_count, bcount);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (atomic_read(&bh->b_count) =3D=3D=
 bh->b_size)
>> ...
>>
>> I'm failing to see why bh->b_count is an atomic_t.
>> I always assumed tapes were exclusive access devices
>> and would be serialized at a higher level.
>
> Beats me. =A0I don't know. =A0The code is generally pretty over-engin=
eered
> but, well, it's an ancient piece of code with (probably too) rich
> history.

Yep, actually the driver was even bigger and it implemented a bunch of =
fun stuff
like command pipelining and those atomics had to protect the pipeline f=
rom
simultaneous ->open()s through its chrdev interface, IIRC.

--=20
Regards/Gruss,
Boris
