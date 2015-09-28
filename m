From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [RFC PATCH] ata: ahci: find eSATA ports and flag them as removable
Date: Mon, 28 Sep 2015 19:26:23 +0200
Message-ID: <CAOLZvyG9ov4X7omdaA=+geYMGb5WXWnaWggOQSXgMTCY_Yw++w@mail.gmail.com>
References: <1443179101-9870-1-git-send-email-manuel.lauss@gmail.com> <20150928162834.GE2589@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37755 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933540AbbI1R1D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Sep 2015 13:27:03 -0400
Received: by wicfx3 with SMTP id fx3so111362538wic.0
        for <linux-ide@vger.kernel.org>; Mon, 28 Sep 2015 10:27:02 -0700 (PDT)
In-Reply-To: <20150928162834.GE2589@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Linux-IDE <linux-ide@vger.kernel.org>

Hi Tejun,

On Mon, Sep 28, 2015 at 6:28 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello, Manuel.
>
> On Fri, Sep 25, 2015 at 01:05:01PM +0200, Manuel Lauss wrote:
>> If the AHCI ports' HPCP or ESP bits are set, the port
>> should be considered external (e.g. eSATA) and is marked
>> as removable.  Userspace tools like udisks then treat it
>> like an usb drive.
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>> --
>> This is a crude hack, but works fine on my laptop. If I plug something in
>> on the eSATA port, KDE pops up a windows asking me what to do with the
>> new drive(s), just like it does for any random usb stick.
>>
>> I didn't know how else to communicate to userspace that the drive is
>> removable other than adding it to the removable-bit-test of ATA IDENTIFY data.
>
> It'd probably be better if you include the above two paragraphs in the
> patch description proper.
>
> Heh, does a port being marked external indicate that it should be
> treated as a removable device?  Hmmm... maybe.  I'm not sure either
> way.  The other thing is that marking a device removeable cause
> internal behavior changes in the SCSI layer.  It constantly checks to
> detect media change events which should be fine but noteworthy.

I'm not sure either, but this is also how windows decides whether
a sata port should be treated as removable, i.e. add a "Safely
remove device" Icon on the taskbar for devices attached to it.
As I wrote, I haven't found another way to signal userspace (mainly
udisks) that everything attached to this port should be treated like
an USB stick.


>> @@ -1484,6 +1485,11 @@ static void ahci_postreset(struct ata_link *link, unsigned int *class)
>>               writel(new_tmp, port_mmio + PORT_CMD);
>>               readl(port_mmio + PORT_CMD); /* flush */
>>       }
>> +
>> +     /* mark esata ports */
>> +     if ((tmp & PORT_CMD_HPCP) ||
>> +         ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS)))
>> +             ap->pflags |= ATA_PFLAG_EXTERNAL;
>
> We probably should do this during port initialization rather than in
> the reset path.

I'll update the patch.

Thank you!
        Manuel
