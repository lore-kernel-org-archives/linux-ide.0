From: Gottfried Haider <gottfried.haider@gmail.com>
Subject: Re: sata link speed on amd hudson
Date: Sun, 3 Apr 2011 13:42:54 +0200
Message-ID: <BANLkTik73+OOOUVS8UKt=6erGbhSRFW3eg@mail.gmail.com>
References: <BANLkTindfgFSi8mZ17xRo1LGky2Mb3w0OQ@mail.gmail.com> <20110403092911.GA5998@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47011 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab1DCLnQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Apr 2011 07:43:16 -0400
Received: by iyb14 with SMTP id 14so5044096iyb.19
        for <linux-ide@vger.kernel.org>; Sun, 03 Apr 2011 04:43:15 -0700 (PDT)
In-Reply-To: <20110403092911.GA5998@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-ide@vger.kernel.org, shane.huang@amd.com, borislav.petkov@amd.com

Hi Borislav,

> Hmm, interesting. We had a similar issue already, see
> http://marc.info/?t=128975810200005&r=1&w=2 and it could be that BIOS
> is downgrading the sata link to save power, as Shane pointed out then.
> Although in that case, it should detect a 6Gbps drive on the link and at
> operate at least that link at full speed. Hmmm...
>
> Gottfried, can you send full dmesg along with 'lspci -vvxxxx' as root
> please?

I uploaded the files to http://sukzessiv.net/x120e - please let me
know if you need any additional info or testing.

greetings,
gohai
