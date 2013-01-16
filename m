From: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH v2] libata: export host controller number thru /sys
Date: Wed, 16 Jan 2013 15:25:57 -0600
Message-ID: <50F71AE5.6050906@redhat.com>
References: <1358287662-24016-1-git-send-email-dmilburn@redhat.com> <CAPXgP12JEjksJz7eyvOmzAXh+nFPrEXEU_bsoff-u9bwiyipZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:61869 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755763Ab3APV0I (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Jan 2013 16:26:08 -0500
In-Reply-To: <CAPXgP12JEjksJz7eyvOmzAXh+nFPrEXEU_bsoff-u9bwiyipZg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kay Sievers <kay@vrfy.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, coughlan@redhat.com, fengguang.wu@intel.com, gwendal@google.com

Kay Sievers wrote:
> On Tue, Jan 15, 2013 at 11:07 PM, David Milburn <dmilburn@redhat.com> wrote:
>> As low-level drivers register their host controller(s), keep track
>> of the number of controllers and export thru /sys in a <host.port>
>> format so that udev can better match up port numbers with a
>> specific controller.
> 
> Hmm, I tried this and I don't think it will solve out problem. But I
> might have missed something ...
> 
> This is host 2 with port "7", but it is really port 1:
> 
>> ./0000:00:1e.0/0000:05:01.0/ata2.7
>> ./0000:00:1e.0/0000:05:01.0/ata2.7/link7/dev7.0/ata_device
> 
> This is host 1 with port "6":
> 
>> ./0000:00:1f.2/ata1.6/ata_port
>> ./0000:00:1f.2/ata1.6/ata_port/ata1.6
> 
> The host number is meaningless regarding stable identifiers, as it
> depends on probing/driver binding order.
> 
> Now, the port number is still *global* across all all controllers, and
> therefore also not useful. We need *host-local* numbers, which share
> nothing with other hosts, so the drivers and bus enumeration order can
> change at any time without affecting any of the device numbers used
> inside the host.
> 
> I have not much clue about port-multipliers, never seen them, but if
> we want to support arbitrary stacking of them we will need to compose
> a "chain of numbers" in the "stable identifier" out of the individual
> port numbers they are connected to, very much like USB hub chaining
> works. This means we will need every instance in the chain to start
> with their own numbers again.
> 
> Any global counters used for device naming/enumeration are not useful
> to identify devices from userspace.

Hi Kay,

So, if we eliminated the global ata_print_id counter, then we would
need to check all the places ap->print_id is used and consider the host
controller and a local_print_id. So, if the above changed to 2.1, we
would expect ata2.1 to show up in dmesg during error recovery
instead of ata7, right?

There are other places (non-printk stuff) in libata that check the global
counter that would need to change, and libsas increments the global
counter when a SATA drive is present on a SAS controller.

Thanks,
David

> 
> Thanks,
> Kay



