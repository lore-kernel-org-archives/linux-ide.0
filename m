From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 1/2] libata: Add support for SEND/RECEIVE FPDMA QUEUED
Date: Thu, 08 Aug 2013 23:07:10 +0400
Message-ID: <5203EC5E.8020703@cogentembedded.com>
References: <1375946182-2831-1-git-send-email-marc.ceeeee@gmail.com> <1375946182-2831-2-git-send-email-marc.ceeeee@gmail.com> <5203DAD0.6040604@cogentembedded.com> <CAO1A-8DqjSAZ=GD6_BxxaBxvbsbYTUuPZSc-odr=bikUk3FtAg@mail.gmail.com> <5203EB9B.3050206@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:56365 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450Ab3HHTHG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Aug 2013 15:07:06 -0400
Received: by mail-la0-f51.google.com with SMTP id fp13so2361127lab.24
        for <linux-ide@vger.kernel.org>; Thu, 08 Aug 2013 12:07:04 -0700 (PDT)
In-Reply-To: <5203EB9B.3050206@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

On 08/08/2013 11:03 PM, Sergei Shtylyov wrote:

>>>     How about non-AHCI FIS-based controllers?

>> Right. Since it's cost prohibitive for me to test exhaustively on
>> non-AHCI FIS-based controllers, do you think it would be acceptable to

>     You can mark your patch as RFT (request for testing) in this case.

>> add a new ATA host flag... something like, ATA_FLAG_AHCI, which would
>> denote the controller as being AHCI-based? Then the flag could be used
>> to gate processing of READ/WRITE/SEND/RECEIVE FPDMA commands that have
>> the 'auxiliary' field set. Or, I could add a big fat warning print
>> whenever an ata_queued_cmd is passed to the drivers with a non-zero
>> 'auxiliary' value.

>     I was rather thinking about a flag (ATA_FLAG_FIS_BASED, maybe) marking a
> controller as FIS-based, so that libata would know whether it can issue the
> new commands using the 'auxiliary' value.

    Perhaps we can test for the presence of one of the sff_*() methods as a 
negative condition for the controller being FIS-based.

>> Regards,
>> Marc

WBR, Sergei

