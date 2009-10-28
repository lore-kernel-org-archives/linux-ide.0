From: Mark Nelson <mdnelson8@gmail.com>
Subject: Re: [PATCH] ahci: Enable SB600 64bit DMA on MSI K9A2 Platinum
Date: Thu, 29 Oct 2009 09:30:35 +1100
Message-ID: <65a6ef750910281530k159fc622g8f3303758a103fb3@mail.gmail.com>
References: <65a6ef750910252203s58af446fv268c857191e698d3@mail.gmail.com>
	 <4AE5A330.3080506@kernel.org>
	 <65a6ef750910261605q45a08791h53cc2afd5d006bb3@mail.gmail.com>
	 <4AE7382F.20302@kernel.org>
	 <65a6ef750910271551i47858982xd1138e4a70a1b076@mail.gmail.com>
	 <65a6ef750910280449k5597d3abkc0995080954e5760@mail.gmail.com>
	 <4AE835A9.40806@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:53373 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108AbZJ1Wab (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Oct 2009 18:30:31 -0400
Received: by ewy4 with SMTP id 4so1263005ewy.37
        for <linux-ide@vger.kernel.org>; Wed, 28 Oct 2009 15:30:35 -0700 (PDT)
In-Reply-To: <4AE835A9.40806@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

On Wed, Oct 28, 2009 at 11:14 PM, Tejun Heo <tj@kernel.org> wrote:
> Mark Nelson wrote:
>> Things look promising so far with lots of DMAs above 4GB (snippets
>> from syslog):
>
> It's probably working okay but a good test would be to repeat to copy
> a large file and checksum it and verify checksums actually match.
>

Okay, that sounds like a good test. I'll give it a go tonight.

Thanks for your help on this!
Mark
