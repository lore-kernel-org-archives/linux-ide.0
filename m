From: Dan van der Ster <dan@vanderster.com>
Subject: Re: ata_dev_acpi_handle - NULL ptr deref (bug #48211)
Date: Mon, 8 Oct 2012 21:16:39 +0200
Message-ID: <CABZ+qqkAXvuUTOB59f6ZH1-Gk73bdMtAvjQPgRCsEt0+tx4ArQ@mail.gmail.com>
References: <CABZ+qqkQY4jRpTjLcOmLwBHY7Q8o1ooiqT82-Y6ogZp5OL6=4g@mail.gmail.com>
 <507244EC.4000206@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54175 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab2JHTRW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Oct 2012 15:17:22 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3896983obb.19
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2012 12:17:22 -0700 (PDT)
Received: by mail-oa0-f46.google.com with SMTP id h16so4221915oag.19
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2012 12:17:20 -0700 (PDT)
In-Reply-To: <507244EC.4000206@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-ide@vger.kernel.org, mjg@redhat.com, Jeff Garzik <jgarzik@pobox.com>

On Mon, Oct 8, 2012 at 5:13 AM, Aaron Lu <aaron.lu@intel.com> wrote:
> On 10/03/2012 07:30 PM, Dan van der Ster wrote:
>> Hi,
>> I filed this bug report:
>>    https://bugzilla.kernel.org/show_bug.cgi?id=48211
>> and Alan suggested I mail this list.
>>
>> I cannot boot 3.6 with acpi on using this hardware:
>>     Shuttle sp35p2, Intel P35, AHCI SATA
>>     disks attached via an external SATA port multiplier
>>
>> I get a NULL ptr deref in ata_dev_acpi_handle with 3.6, but not with 3.5.4.
>> Using acpi=off convinces 3.6 to boot.
>
> Attached a patch on the bugzilla page, can you please give it a try?

Your patch fixes the problem.

Thanks,
Dan


> Thanks.
>
> -Aaron
>
