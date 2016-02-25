From: Laura Abbott <labbott@redhat.com>
Subject: Re: [REGRESSION] 8a3e33cf92c7 "ata: ahci: find eSATA ports and flag
 them as removable" changes userspace behavior
Date: Thu, 25 Feb 2016 11:37:09 -0800
Message-ID: <56CF57E5.7040808@redhat.com>
References: <56CF35FA.1070500@redhat.com>
 <CAOLZvyEheaW128Yw7MNqZHjOERry0-v=46kXKbazNE3Oha=-Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41602 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933286AbcBYThM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Feb 2016 14:37:12 -0500
In-Reply-To: <CAOLZvyEheaW128Yw7MNqZHjOERry0-v=46kXKbazNE3Oha=-Mw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Manuel Lauss <manuel.lauss@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 02/25/2016 10:56 AM, Manuel Lauss wrote:
> On Thu, Feb 25, 2016 at 6:12 PM, Laura Abbott <labbott@redhat.com> wrote:
>> Hi,
>>
>> We received a bugzilla report
>> https://bugzilla.redhat.com/show_bug.cgi?id=1310682
>> of partitions being automounted unexpectedly. Testing showed that
>> 8a3e33cf92c7 ("ata: ahci: find eSATA ports and flag them as removable") was
>> responsible.
>> This seems to be classified as 'breaking' userspace given that this behavior
>> results
>> in partitions that were previously unmounted now being being mounted
>> unwanted
>> automatically which is unwanted behavior for the user. Can we revert this
>> patch or
>> give a fix to change this behavior?
>
> Do the affected users have sata ports set to hotplug capable? Because that's
> what the patch does: it flags ports which have the hotplug capability enabled
> as "removable", and I guess redhat just automounts anything that is flagged
> as a removable disk (like an usb drive).
>
> Manuel
>

The mounting comes from udisks. udisks will automount anything marked as removable
unless explicitly forbidden. You can argue whether or not this is good design but
it's still a change in behavior from what udisks was relying on to decide
whether or not to automount. lspci from the users hardware:

00:1f.2 SATA controller: Intel Corporation C600/X79 series chipset 6-Port SATA
AHCI Controller (rev 06)

I'll make a build with the patch you gave for testing.

Thanks,
Laura
