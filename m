From: Terry Suereth <terry.suereth@gmail.com>
Subject: Re: libata-pmp.c patch for Silicon Image 3826 port multiplier
Date: Mon, 14 Jan 2013 12:56:12 -0800
Message-ID: <CANQSiW0v=r39iBd8RNBS3xE7Ve2za=kc40xF8yhBj1XY5ex1Qg@mail.gmail.com>
References: <CANQSiW0f4A=Y3db0-=2fdiHbGO2SigOE1ejPTYsUcZHhpEg1pQ@mail.gmail.com>
	<50F3F8D2.70506@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:56481 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757503Ab3ANU4N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jan 2013 15:56:13 -0500
Received: by mail-qc0-f181.google.com with SMTP id x40so2813986qcp.12
        for <linux-ide@vger.kernel.org>; Mon, 14 Jan 2013 12:56:12 -0800 (PST)
In-Reply-To: <50F3F8D2.70506@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-ide@vger.kernel.org

Thanks for the tips Sergei -- I'm totally in the dark re: kernel patch
submission process.  I bothered to read the SubmittingPatches page
this morning, and will be sending a more properly-formatted patch
email/subject to the list shortly.


On Mon, Jan 14, 2013 at 4:23 AM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
>
> On 14-01-2013 1:58, Terry Suereth wrote:
>
>> Hello linux-ide mailing list,
>
>
>> I recently purchased and equipped one of my Slackware boxes with a
>> Rosewill RAID enclosure (RSV-S8), which claimed to use a Sil3726 PMP
>> chipset, but which actually uses a Sil3826 chipset.  This appears to
>> be some relatively new silicon, and (presumably) a replacement for the
>> 3726 going forward.
>
>
>> I had some difficulties using this hardware at first - excessively
>> long delays linking to the PMP at startup - but once I discovered the
>> chipset version issue, it was simple to fix -- libata just needs to
>> apply the same PMP quirks that are currently used on the 3726, to the
>> 3826.  I've done this in a local kernel build and it's working great
>> so far.
>
>
>> The same bug/fix has been posted to the Red Hat bug tracker:
>> https://bugzilla.redhat.com/show_bug.cgi?id=890237 -- although the
>> patch noted there (in the PDF (!?) attachment) appears incomplete.
>
>
>> My somewhat-redundant patch, based on the current linux-stable version
>> from git, is pasted inline below.  It should be very simple and
>> unsurprising.
>
>
>> Best,
>
>
>> Terry Suereth
>> terry.suereth@gmail.com
>
>
>
>
>> --- libata-pmp.c.old 2013-01-13 13:42:56.582780772 -0800
>> +++ libata-pmp.c 2013-01-13 13:43:33.670964680 -0800
>> @@ -289,24 +289,24 @@
>>
>>    /* Disable sending Early R_OK.
>>    * With "cached read" HDD testing and multiple ports busy on a SATA
>> - * host controller, 3726 PMP will very rarely drop a deferred
>> + * host controller, 3x26 PMP will very rarely drop a deferred
>>    * R_OK that was intended for the host. Symptom will be all
>>    * 5 drives under test will timeout, get reset, and recover.
>>    */
>> - if (vendor == 0x1095 && devid == 0x3726) {
>> + if (vendor == 0x1095 && (devid == 0x3726 || devid == 0x3826)) {
>>    u32 reg;
>>
>>    err_mask = sata_pmp_read(&ap->link, PMP_GSCR_SII_POL, &reg);
>>    if (err_mask) {
>>    rc = -EIO;
>> - reason = "failed to read Sil3726 Private Register";
>> + reason = "failed to read Sil3x26 Private Register";
>>    goto fail;
>>    }
>>    reg &= ~0x1;
>>    err_mask = sata_pmp_write(&ap->link, PMP_GSCR_SII_POL, reg);
>>    if (err_mask) {
>>    rc = -EIO;
>> - reason = "failed to write Sil3726 Private Register";
>> + reason = "failed to write Sil3x26 Private Register";
>>    goto fail;
>>    }
>>    }
>> @@ -383,8 +383,8 @@
>>    u16 devid = sata_pmp_gscr_devid(gscr);
>>    struct ata_link *link;
>>
>> - if (vendor == 0x1095 && devid == 0x3726) {
>> - /* sil3726 quirks */
>> + if (vendor == 0x1095 && (devid == 0x3726 || devid == 0x3826)) {
>> + /* sil3x26 quirks */
>>    ata_for_each_link(link, ap, EDGE) {
>>    /* link reports offline after LPM */
>>    link->flags |= ATA_LFLAG_NO_LPM;
>
>
>    Your patch is whitespace damaged, misses signoff and proper description.
>
> MBR, Sergei
>
