From: Levente Kurusa <levex@linux.com>
Subject: Re: [PATCH] ata_piix: minor typo fixes and threading fix
Date: Fri, 27 Sep 2013 15:29:56 +0200
Message-ID: <52458854.9090000@linux.com>
References: <523EF645.7050808@linux.com> <20130922153959.GB28571@htj.dyndns.org> <523F10BB.8020503@gmail.com> <20130922160551.GD28571@htj.dyndns.org> <CAAsK9AF_sJFcNTkCAR1vE5O80bJ0OoUL2AykqOoUvZt=5AYnxQ@mail.gmail.com> <20130926140930.GA3482@htj.dyndns.org> <CAPXgP13UZYEgdm6er8HrsoCiajwAXEzg_jn4Q7OgY2zDMGv-9g@mail.gmail.com>
Reply-To: levex@linux.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:50355 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706Ab3I0N37 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Sep 2013 09:29:59 -0400
Received: by mail-ee0-f52.google.com with SMTP id c41so1208047eek.39
        for <linux-ide@vger.kernel.org>; Fri, 27 Sep 2013 06:29:58 -0700 (PDT)
In-Reply-To: <CAPXgP13UZYEgdm6er8HrsoCiajwAXEzg_jn4Q7OgY2zDMGv-9g@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kay Sievers <kay@vrfy.org>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

2013-09-26 19:57 keltez=C3=A9ssel, Kay Sievers =C3=ADrta:
> On Thu, Sep 26, 2013 at 4:09 PM, Tejun Heo <tj@kernel.org> wrote:
>> (cc'ing Kay)
>>
>> On Wed, Sep 25, 2013 at 04:40:30PM +0200, Levente Kurusa wrote:
>>> I am getting the following output:
>>> [    2.236379] ata_piix 0000:00:1f.2: MAP [
>>> [    2.236492]  P0 P2 -- -- ]
>>> Instead of the expected:
>>> [    2.236379] ata_piix 0000:00:1f.2: MAP [ P0 P2 -- -- ]
>>>
>>> This might be a minor problem, but I think it is better the second =
way.
>>> Of course, now that I better understand the code, I see that my fix=
 to this,
>>> is not the best. I will make a new patch, if you think this should =
be fixed.
>>
>> Hmmm... so, you're saying pr_cont() is misbehaving after dev_info()?
>> If so, we don't want to paper over that from a low level driver like
>> ata_piix.  Let's find out what's going on with pr_cont().
>>
>> Kay, Levente is seeing the above output from
>> drivers/ata/ata_piix.c::piix_init_sata_map().  Any ideas?
>
> Yes, the dev_printk() versions are "atomic lines", cannot be
> concatenated with other invocations of printk() like the normal
> printks can. The reason is that the dev_* versions carry structured
> data to userspace, and there, the logs are indexed by device.
>
> We don't want to allow the convenient but very racy and
> non-thread-safe concatenation lines for dev_* versions, they might
> pick up unrelated text fragments from other threads into the logged
> text line; userspace (non-human tools) can not really cope with that.
>
> So, the printk should not use the dev_* version, or print all in one
> call, if a single line is expected.
>
> Kay
>

Thank you Kay for clarifying this! I think I will go with
creating a buffer, and printing this all in one line.

Tejun, during this weekend I will create a patch that
hopefully fixes this. However, if you think that setting
up a temporary buffer is inappropriate, please comment.


Thank you,
Levente Kurusa
