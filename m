From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: Hotplug borked after suspend/resume in Linux-3.3 ?
Date: Wed, 18 Apr 2012 09:52:31 +0800
Message-ID: <CAF1ivSZwpW78RMFnNmhcm3Ntwz1ua1gEbK0PFttKwfhWQ8MDXw@mail.gmail.com>
References: <4F8DD4DC.4050503@teksavvy.com>
	<4F8DD708.8050502@teksavvy.com>
	<4F8DD939.1050909@pobox.com>
	<4F8DDB24.9080109@teksavvy.com>
	<4F8DDC4F.8060103@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:47803 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046Ab2DRBwc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2012 21:52:32 -0400
Received: by vbbff1 with SMTP id ff1so4654673vbb.19
        for <linux-ide@vger.kernel.org>; Tue, 17 Apr 2012 18:52:31 -0700 (PDT)
In-Reply-To: <4F8DDC4F.8060103@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <kernel@teksavvy.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Wed, Apr 18, 2012 at 5:10 AM, Jeff Garzik <jgarzik@pobox.com> wrote:
> On 04/17/2012 05:05 PM, Mark Lord wrote:
>>
>> On 12-04-17 04:57 PM, Jeff Garzik wrote:
>>>
>>> On 04/17/2012 04:48 PM, Mark Lord wrote:
>>>>
>>>> On 12-04-17 04:38 PM, Mark Lord wrote:
>>>>>
>>>>> Okay, so why isn't SATA hotplug working in linux-3.3.2 ?
>>>>> I don't know when it stopped working, but it's a blooming pain in=
 the
>>>>> sysadmin.
>>>>>
>>>>> I need to hotplug a SATA drive into an AHCI port,
>>>>> preferably without having to reboot first.
>>>>>
>>>>> Is there a patch available already for this regression?
>>>>
>>>>
>>>>
>>>> Answering my own question, this patch appears to address the issue=
=2E
>>>> I'll test and report back again shortly:
>>>>
>>>> =A0 =A0 =A0http://patchwork.ozlabs.org/patch/146326/
>>>>
>>>> Odd that it's been sitting in various people's inboxes since 3.3-r=
c1
>>>> and hasn't been pushed out yet.
>>>
>>>
>>> The vast majority of "hotpluggable" ports are not necessarily cover=
ed by
>>> this patch.
>>
>>
>>
>> And what majority of ports are currently broken by linux-3.3 ?
>> Any idea of what the offending commit may have been,
>> so I can test against that and perhaps get it reverted then?
>>
>> So far, my sample of three systems are all broken with this kernel.
>> That's definitely "regression" territory. =A0:)
>
>
> Right -- rather than breaking a bunch and fixing a few, we might just=
 need
> to revert the runtime pm stuff altogether.

Hi Jeff,

I'm working on the hotplug issue fix.
How about below suggestion:

1) forbid port runtime pm by default, user can allow it on demand by
sysfs interface
2) then driver to allow port runtime pm if it supports hotplug well

ZPODD feature relies on port runtime suspend/resume to enter/exit zero
power state.
[PATCH v3 0/7] SATA ZPODD support
https://lkml.org/lkml/2012/3/28/20

So we really need port runtime pm support.

Thanks,
Lin Ming

>
> Commits to look at include
>
> =A0 =A0 =A0 =A0966f1212e1ac5fe3ddf04479d21488ddb36a2608
> =A0 =A0 =A0 =A033574d68ae41ccbc6686cfabd965c685285c58a0
> =A0 =A0 =A0 =A0e90b1e5a6e04c8892007ff8db20ef6d4fbdb5402
> =A0 =A0 =A0 =A09ee4f3933930abf5cc34f8e9d69fe0e08c18f602
> =A0 =A0 =A0 =A05ef41082912bdfcb33fa53b8dba2ad17dea2ef90
> =A0 =A0 =A0 =A09a6d6a2ddabbd32c07f6a38b659e5f3db319fa5a
>
